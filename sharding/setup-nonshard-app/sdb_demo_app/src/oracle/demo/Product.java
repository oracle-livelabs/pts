package oracle.demo;

import oracle.RandomGenerator;
import oracle.Utils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;

public class Product
{
    private int id;
    private String description = null;
    private String name = null;

    final static Random rand = new Random();
    static final RandomGenerator<String> productNameGenerator = RandomGenerator.initStaticUniformGenerator("parts.txt");

    private static final String modelLetters = "ABCDEFG";

    private static String generateModel()
    {
        int idx = rand.nextInt(modelLetters.length());
        return modelLetters.substring(idx, idx + 1) + "-" + Integer.toString(rand.nextInt(7));
    }

    public Product(Random rand)
    {
        String[] generated = productNameGenerator.getI(rand).split(";");

        this.name = generated[0] + " (for model " + generateModel() + ")";

        if (generated.length > 1) {
            this.description = "https://en.wikipedia.org/wiki/" + generated[1].replace(' ', '_');
        }
    }

    public Product(String s)
    {
        String[] generated = s.split(";");

        this.name = generated[0];

        if (generated.length > 1) {
            this.description = "https://en.wikipedia.org/wiki/" + generated[1].replace(' ', '_');
        }
    }

    private static final String insertIntoProducts =
            "INSERT INTO Products(Name, DescrUri, LastPrice) " +
                    " VALUES (:p1, :p2, :p3) ";

    public static void addProducts(Application app, List<Product> productList)
            throws ApplicationException
    {
        try (Connection catalogConnection = app.getXShard())
        {
            catalogConnection.setAutoCommit(false);

            try (PreparedStatement statement = catalogConnection.prepareStatement(insertIntoProducts))
            {
                for (Product item : productList)
                {
                    Utils.setBinds(statement,
                            item.name,
                            item.description,
                            RandomGenerator.generatePrice(rand))
                        .addBatch();
                }

                statement.executeBatch();
            }

            catalogConnection.commit();
            upToDateSet.clear();
        } catch (SQLException e) {
            app.stats.bump(Statistics.COUNTER_TXN_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to add products");
        }
    }

    private static final String checkProducts = "SELECT COUNT(ProductId) FROM Products";

    public static int checkProductTableFilled(Application app)
            throws ApplicationException
    {
        try (Connection catalogConnection = app.getXShard())
        {
            try (PreparedStatement statement = catalogConnection.prepareStatement(checkProducts))
            {
                try (ResultSet resultSet = statement.executeQuery())
                {
                    if (resultSet.next()) {
                        return resultSet.getInt(1);
                    } else {
                        return 0;
                    }
                }
            }
        } catch (SQLException e) {
            app.stats.bump(Statistics.COUNTER_TXN_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to add products");
        }
    }

    private static final ConcurrentHashMap<String, AtomicBoolean> upToDateSet = new ConcurrentHashMap<>();

    public static void checkProductTable(Application app, Connection connection)
            throws ApplicationException
    {
        try
        {
            String instanceName = ((oracle.jdbc.internal.OracleConnection) connection)
                    .getServerSessionInfo().get("INSTANCE_NAME").toString();

            AtomicBoolean updated = upToDateSet.computeIfAbsent(instanceName, (x) -> new AtomicBoolean(false));

            if (updated.compareAndSet(false, true))
            {
                try (CallableStatement call = connection.prepareCall("CALL DBMS_MVIEW.REFRESH('PRODUCTS')"))
                {
                    call.execute();
                }
            }
        } catch (SQLException e) {
            app.stats.bump(Statistics.COUNTER_TXN_FAILED);
            app.reportUnhandledException(e);
            throw new ApplicationException("Failed to update products");
        }
    }

    public static void initialFill(Application app)
            throws ApplicationException
    {
        if (checkProductTableFilled(app) < 10)
        {
            System.out.print("Performing initial fill of the products table...\n");

            final List<Product> productList = new ArrayList<>();

            for (RandomGenerator.Item<String> x : productNameGenerator.getItems()) {
                productList.add(new Product(x.getValue()));
            }

            addProducts(app, productList);

            System.out.print("Syncing shards...\n");

            try (Connection catalogConnection = app.getXShard())
            {
                try (PreparedStatement statement = catalogConnection.prepareStatement(
        "select * from table(sys.shard_helper_remote.execute_at_shards('" +
                "declare pragma autonomous_transaction; begin dbms_mview.refresh(''app_schema.products''); end;', 1))"))
                {
                    try (ResultSet resultSet = statement.executeQuery())
                    {
                        if (resultSet.next())
                        {
                            if (!resultSet.getString(2).equals("1"))
                            {
                                throw new RuntimeException(String.format(
                                        "Update failed at %s : %s", resultSet.getString(1), resultSet.getString(3)));
                            }
                        }
                    }
                }
            } catch (SQLException e) {
                app.stats.bump(Statistics.COUNTER_TXN_FAILED);
                app.reportUnhandledException(e);
                throw new ApplicationException("Failed to update products");
            }
        }
    }
}
