package oracle.demo;

import oracle.jdbc.OracleType;
import oracle.ucp.jdbc.PoolDataSource;
import oracle.ucp.jdbc.PoolDataSourceFactory;

import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Application
{
    final private PoolDataSource transactionPool;
    final private PoolDataSource readonlyPool;;

    final Logger logger = Logger.getLogger(this.getClass().getName());

    public final Statistics stats = new Statistics();

    /* NOTE: this should be only called in case this is a really
       serious exception and should be logged or something */
    public void reportUnhandledException(Throwable x)
    {
        if (x instanceof SQLException)
        {
            int oracode = ((SQLException) x).getErrorCode();

            /* */
            if (oracode == 14466 || oracode == 372) {
                stats.bump(Statistics.COUNTER_FAILED_READONLY);
            } else if (oracode == 12523) {
                stats.bump(Statistics.COUNTER_FAILED_LISTENER);
            } else {
                stats.bump(Statistics.COUNTER_FAILED_OTHER);
            }

            stats.bump(Statistics.COUNTER_FAILED_SQL_TOTAL);
        }

        synchronized (logger) {
            logger.log(Level.WARNING, "Unhandled or unexpected exception in thread", x);
        }
    }

    static final String CONN_FORMAT   = "jdbc:oracle:thin:@(description=%s(connect_data=(service_name=%s)))";

    private String catalogConnectionString = null;
    private String catalogUser = null;
    private String catalogPassword = null;

    PoolDataSource initPool(String endpoint, String service, String username, String password)
            throws SQLException
    {
        PoolDataSource pool = PoolDataSourceFactory.getPoolDataSource();

        pool.setConnectionFactoryClassName("oracle.jdbc.pool.OracleDataSource");
        pool.setURL(String.format(CONN_FORMAT, endpoint, service));
        pool.setUser(username);
        pool.setPassword(password);
        pool.setInitialPoolSize(10);
//        pool.setMaxStatements(10);
        pool.setMinPoolSize(1);
        pool.setMaxPoolSize(15);

        return pool;
    }

    Application(Properties properties)
    {
        String endpoint  = properties.getProperty("connect_string", properties.getProperty("endpoint", ""));
        String serviceRW = properties.getProperty("app.service.write", properties.getProperty("app.service", "customerService"));
        String serviceRO = properties.getProperty("app.service.readonly", properties.getProperty("app.service", "customerService"));
        String serviceXS = properties.getProperty("app.service.xs", "GDS$CATALOG.ORADBCLOUD");
        String username  = properties.getProperty("app.user", "");
        String password  = properties.getProperty("app.pass", "");

        try {
            transactionPool = initPool(endpoint, serviceRW, username, password);
            readonlyPool    = initPool(endpoint, serviceRO, username, password);

            catalogConnectionString = String.format(CONN_FORMAT, endpoint, serviceXS);
            catalogUser = username;
            catalogPassword = password;
        } catch (SQLException e) {
            reportUnhandledException(e);
            throw new RuntimeException(e);
        }
    }

    protected Connection getCustomerConnection(PoolDataSource pool, Customer customer) throws SQLException
    {
        return pool.createConnectionBuilder()
                .shardingKey(
                        pool.createShardingKeyBuilder()
                                .subkey(customer.email, OracleType.VARCHAR2)
                                .build())
                .build();
    }

    public Connection getReadonly(Customer customer) throws SQLException
    {
        return getCustomerConnection(readonlyPool, customer);
    }

    public Connection getTransaction(Customer customer) throws SQLException
    {
        Connection connection = getCustomerConnection(transactionPool, customer);

        try {
            connection.setAutoCommit(false);
        } catch (SQLException e) {
            reportUnhandledException(e);
        }

        return connection;
    }

    public Connection getXShard() throws SQLException
    {
        return DriverManager.getConnection(catalogConnectionString, catalogUser, catalogPassword);
    }
}
