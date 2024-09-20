package oracle.monitor;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import oracle.JsonSerializer;
import oracle.Utils;
import oracle.sql.NUMBER;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.*;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

public class DatabaseMonitor {
    AtomicReference<String> statInfo = new AtomicReference<>("{\"no-data\" : \"no-data\"}");
    Logger logger = Logger.getGlobal();

    static final String DRIVER_PREFIX = "jdbc:oracle:thin:";
    static final String CONN_FORMAT   = "%s@(description=%s(connect_data=(service_name=%s)%s))";
    static final String CATALOG_SERVICE_NAME = "GDS$CATALOG.oradbcloud";

    public DatabaseMonitor(Properties db, ScheduledExecutorService executor)
    {
        String endpoint = db.getProperty("catalog.connect_string", db.getProperty("connect_string", ""));
        String connectionString = String.format(CONN_FORMAT, DRIVER_PREFIX, endpoint, CATALOG_SERVICE_NAME, "");

        executor.scheduleWithFixedDelay(
                new BackgroundStatusCheck(connectionString,
                        db.getProperty("monitor.user", ""),
                        db.getProperty("monitor.pass", "")), 0, 3, TimeUnit.SECONDS);
    }

    private static String[] getItems(String[] x, int m, int off)
    {
        int n = x.length / m;
        String[] result = new String[n];

        for (int i = 0; i < n; ++i)
        {
            result[i] = x[i*m + off];
        }

        return result;
    }

    public interface ProcessRow
    {
        void row(ResultSet resultSet) throws SQLException;
    }

    Connection connection;

    private final static int ALIGN_LEFT   = 0;
    private final static int ALIGN_RIGHT  = 0;
    private final static int ALIGN_CENTER = 0;

    static class TableColumnDescriptor
    {
        int align;
        int type;

        TableColumnDescriptor(int align, int type) { this.align = align; this.type = type; }
    }

    public class SimpleStatementWrapper
    {
        PreparedStatement statement = null;
        String query;
        long timestamp;

        public SimpleStatementWrapper(String query)
        {
            this.query = query;
        }

        public void executeAndProcess(ProcessRow p) throws SQLException
        {
            if (statement == null) {
                statement = connection.prepareStatement(query);
            }

            timestamp = System.currentTimeMillis();

            logger.fine("Execute " + query);

            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    p.row(result);
                }
            }

            logger.fine("Execute done : " + query);
        }

        public JsonSerializer getAsTable(JsonSerializer output) throws SQLException
        {
            if (statement == null) {
                statement = connection.prepareStatement(query);
            }

            if (output == null) {
                output = new JsonSerializer();
            }

            logger.fine("Execute " + query);

            try (ResultSet result = statement.executeQuery()) {
                ResultSetMetaData meta = result.getMetaData();

                output.array("columns");

                for (int i = 1; i <= meta.getColumnCount(); ++i) {
                    output.put(meta.getColumnName(i));
                }

                output.end();

                output.array("values");

                while (result.next()) {
                    output.array();

                    for (int i = 1; i <= meta.getColumnCount(); ++i) {
                        output.put(result.getString(i));
                    }

                    output.end();
                }
                output.end();
            }

            logger.fine("Execute done : " + query);

            return output;
        }
    }

    public class InfoStatementWrapper extends SimpleStatementWrapper
    {
        final String[] fieldNameList;

        public InfoStatementWrapper(String[] dsc, String src)
        {
            super(
               Utils.join(new StringBuilder("SELECT "), ",",
                       new Utils.ArrayIterator<String>(getItems(dsc, 2, 0)), Object::toString)
                .append(" FROM ").append(src).toString());

            fieldNameList = getItems(dsc, 2, 1);
        }

        public void toJson(JsonSerializer writer, ResultSet resultSet) throws SQLException
        {
            for (int i = 0; i < fieldNameList.length; ++i)
            {
                writer.put(fieldNameList[i], resultSet.getString(i + 1));
            }
        }
    }

    private static final String[] databaseStatusQuery = {
            "R.DB_UNIQUE_NAME", "Name",
            "DECODE(BITAND(L.FLAGS, 2), 2, 'PRIMARY', 'STANDBY')", "Role",
            "DECODE(BITAND(L.FLAGS, 1), 1, '*ONLINE', '*OFFLINE')", "Status",
            "R.PRIMARY_DB_UNIQUE_NAME", "Primary DB",
            "L.RACK", "Rack",
            "REGION.NAME", "Region",
    };

    private static final String databaseStatusQuerySrc =
            "GSMADMIN_INTERNAL.DATABASE L " +
                    " LEFT JOIN SGV$DATABASE R ON R.PUBLIC_DBNAME=L.NAME " +
                    " LEFT JOIN GSMADMIN_INTERNAL.REGION REGION ON L.REGION_NUM = REGION.NUM";

    private static final String[] chunkStatusQuery = {
            "PUBLIC_DBNAME", "DBNAME", "CHUNK_NAME", "CHUNK_NAME", "STATE", "STATE"
    };

    private static final String chunkStatusQuerySrc = " GLOBAL_CHUNKS ";

    final private static MessageDigest md5;

    static
    {
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    class DatabaseInfo
    {
        final int id;
        final String dbName;
        final List<String> chunks = new ArrayList<>();
        final List<String> readOnlyChunks = new ArrayList<>();
        final JsonSerializer info = new JsonSerializer();

        public String dataDigest()
        {
            return Base64.getEncoder().encodeToString(
                    md5.digest(String.format("%d/%s/%s/%s/%s", id, dbName,
                        Utils.join(",", chunks.iterator(), Object::toString),
                        Utils.join(",", readOnlyChunks.iterator(), Object::toString),
                        info.close().toString()).getBytes()));
        }

        public DatabaseInfo(String dbName) {
            this.dbName = dbName;
            this.id = getDbId(dbName);
        }
    }

    private final List<String> databases = new ArrayList<>();
    private final Map<String, Integer> databaseIndex = new TreeMap<>();

    private int getDbId(String db)
    {
        Integer x = databaseIndex.get(db);

        if (x == null) {
            x = databases.size();
            databases.add(db);
            databaseIndex.put(db, x);
        }

        return x;
    }

    class MetricSeries
    {
        final int t;
        final double [] ucps = new double[databases.size()];
        public MetricSeries(int t) { this.t = t; }
    }

    private List<MetricSeries> statHistory = new ArrayList<>();

    private static int timeToSeconds(String value)
    {
        int[] t = Arrays.stream(value.split(":")).mapToInt(Integer::parseInt).toArray();
        return ((t[0] * 60 + t[1]) * 60 + t[2]);
    }

    private List<MetricSeries> getLastMetrics()
    {
        List<MetricSeries> latest = new ArrayList<>(
                statHistory.subList(Math.max(0, statHistory.size() - 20), statHistory.size()));
        Collections.reverse(latest);
        Collections.sort(latest, (o1, o2) -> o2.t - o1.t);

        return latest;
    }

    private static int getTimeOnly()
    {
        return (int) ((System.currentTimeMillis() / 1000) % (60*60*24));
    }

    public class BackgroundStatusCheck implements Runnable
    {
        final String connectionString;
        final String username;
        final String password;

        final InfoStatementWrapper dbStatusStatement    = new InfoStatementWrapper(databaseStatusQuery, databaseStatusQuerySrc);
        final InfoStatementWrapper chunkStatusStatement = new InfoStatementWrapper(chunkStatusQuery, chunkStatusQuerySrc);

        final SimpleStatementWrapper updateStats    = new SimpleStatementWrapper(
            "select * from table(sys.shard_helper_remote.execute_at_shards('declare pragma autonomous_transaction; " +
                " begin dbms_stats.gather_schema_stats(''APP_SCHEMA'', null, false, ''FOR ALL INDEXED COLUMNS SIZE 1'', " +
                    " null, ''ALL'', false, null, null, ''GATHER''); end;', 1))");

        final SimpleStatementWrapper sessionStats   = new SimpleStatementWrapper(
                "select public_dbname, count(*) from sgv$session where type='USER' group by public_dbname");

        final SimpleStatementWrapper userCallStats  = new SimpleStatementWrapper(
                "select PUBLIC_DBNAME, 0, 0, sum(CALLSPERSEC) from SGV$SERVICEMETRIC where service_name like 'oltp%' and group_id=10 group by PUBLIC_DBNAME");

        final SimpleStatementWrapper partitionStats = new SimpleStatementWrapper(
                "SELECT PARTITION_NAME, SUM(NUM_ROWS) TOTAL_ROWS"+
                        "    FROM GLOBAL_DBA_TAB_PARTITIONS WHERE READ_ONLY = 'NO' AND TABLE_OWNER='app_schema'"+
                        "        GROUP BY PARTITION_NAME");

        final SimpleStatementWrapper sampleOrders = new SimpleStatementWrapper(
                "select PUBLIC_DBNAME DATABASE, OrderId ID, CustId CUSTOMER, OrderDate \"DATE\", TO_CHAR(SumTotal, '999,999,999.00') SUM " +
                        " FROM (SELECT * FROM GLOBAL_SAMPLE_ORDERS ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM < 10 ORDER BY OrderId DESC");

        public BackgroundStatusCheck(String connectionString, String username, String password)
        {
            this.connectionString = connectionString;
            this.username = username;
            this.password = password;
        }

        @Override
        public void run()
        {
            final Map<String, DatabaseInfo> dbs  = new TreeMap<>();
            final Map<String, Integer> chunkLoad = new TreeMap<>();

            try {
                if (connection == null)
                {
                    logger.fine("connection : " + connectionString);
                    connection = DriverManager.getConnection(connectionString, username, password);
                }

                updateStats.executeAndProcess(resultSet -> { /* Ignore */ });

                dbStatusStatement.executeAndProcess(resultSet -> {
                    String dbName = resultSet.getString(1);

                    if (dbName != null)
                    {
                        DatabaseInfo db = new DatabaseInfo(dbName);
                        dbStatusStatement.toJson(db.info, resultSet);
                        dbs.put(dbName, db);
                    }
                });

                chunkStatusStatement.executeAndProcess(resultSet -> {
                    DatabaseInfo db;

                    if ((db = dbs.get(resultSet.getString(1))) != null) {
                        db.chunks.add(resultSet.getString(2));

                        if (resultSet.getInt(3) != 0) {
                            db.readOnlyChunks.add(resultSet.getString(2));
                        }
                    }
                });

                final int [] sessionCount = new int [databases.size()];

                sessionStats.executeAndProcess(resultSet -> {
                    sessionCount[getDbId(resultSet.getString(1))] = resultSet.getInt(2);
                });

                partitionStats.executeAndProcess(resultSet -> {
                    chunkLoad.put(resultSet.getString(1), resultSet.getInt(2));
                });

                final int bogusTime = getTimeOnly();
                MetricSeries metric = new MetricSeries(bogusTime);

                userCallStats.executeAndProcess(resultSet -> {
                    metric.ucps[getDbId(resultSet.getString(1))] = resultSet.getDouble(4);
                });

                statHistory.add(metric);

                JsonSerializer output = new JsonSerializer();

                output.putAsString("databaseNames", databases);

                output.array("databases");

                for (DatabaseInfo db : dbs.values())
                {
                    output.begin()
                        .put("digest", db.dataDigest())
                        .put("name", db.dbName)
                        .put("info", db.info)
                        .putAsString("chunks", db.chunks)
                            .putAsString("rochunks", db.readOnlyChunks).end();
                }

                output.end();

                output.putAsIntArray("sessions", sessionCount);

                if (!chunkLoad.isEmpty()) {
                    output.begin("partitions");
                    chunkLoad.forEach(output::putI);
                    output.end();
                }

                while (statHistory.size() > 10240) {
                    statHistory = statHistory.stream()
                            .filter(item -> (bogusTime - item.t) < 60)
                            .collect(Collectors.toList());

                    statHistory.sort((o1, o2) -> o1.t - o2.t);
                }

                output.array("metrics");

                for (MetricSeries x : getLastMetrics())
                {
                    output.begin()
                      .putI("t", x.t)
                      .putAsDoubleArray("ucps", x.ucps)
                            .end();
                }

                output.end();

                sampleOrders.getAsTable(output.begin("lastOrders")).end();

                String newData = output.close().toString();

//                System.out.print(newData);

                statInfo.lazySet(newData);
            } catch (Exception e) {
                logger.log(Level.SEVERE, "SQL Error : ", e);
            }
        }
    }

    public class InfoHandler implements HttpHandler
    {
        @Override
        public void handle(HttpExchange httpExchange) throws IOException
        {
            logger.fine(httpExchange.getRequestURI().toString());
            final ByteArrayOutputStream output = new ByteArrayOutputStream();
            output.write(statInfo.get().getBytes("UTF8"));
            output.flush();

            httpExchange.getResponseHeaders().put("Content-Type", Collections.singletonList("application/json"));
            httpExchange.getResponseHeaders().put("Access-Control-Allow-Origin", Collections.singletonList("*"));
            httpExchange.sendResponseHeaders(200, output.size());
            output.writeTo(httpExchange.getResponseBody());
            httpExchange.close();
        }
    }

    public HttpHandler getInfoHandler()
    {
        return new InfoHandler();
    }
}
