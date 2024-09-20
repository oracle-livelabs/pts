package oracle.demo;

import oracle.jdbc.OracleShardingKey;
import oracle.jdbc.OracleType;
import oracle.ucp.jdbc.PoolDataSource;
import oracle.ucp.jdbc.PoolDataSourceFactory;

import java.sql.Connection;
import java.sql.SQLException;

public class Test {
    static public void main(String [] args) throws SQLException
    {
        Connection connection = null;
        String SHARD_DB_URL = "jdbc:oracle:thin:@(DESCRIPTION=" +
                "(ADDRESS_LIST=(LOAD_BALANCE=off)(FAILOVER=on)(ADDRESS=(HOST=localhost)(PORT=1522)(PROTOCOL=tcp)))" +
                "(CONNECT_DATA=(SERVICE_NAME=oltp_rw_srvc.orasdb.oradbcloud)))";

        PoolDataSource pds = PoolDataSourceFactory.getPoolDataSource();
        pds.setConnectionFactoryClassName("oracle.jdbc.pool.OracleDataSource");
        pds.setURL(SHARD_DB_URL);
        pds.setUser("app_schema");
        pds.setPassword("app_schema");
        pds.setConnectionPoolName("UCP_POOL");
        pds.setInitialPoolSize(5);
        pds.setMinPoolSize(5);
        pds.setMaxPoolSize(20);

        OracleShardingKey shardingKey = pds.createShardingKeyBuilder()
                .subkey("abc@test.com", OracleType.VARCHAR2)
                .build();

        System.out.print(pds.createConnectionBuilder().shardingKey(shardingKey).build().createStatement());
    }
}
