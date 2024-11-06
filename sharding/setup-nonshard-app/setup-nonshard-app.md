# Setup a Non-Sharded Application

## Introduction

In this lab, you will setup a non-sharded database application. You will migrate the schema and data to the globally distributed database in the next lab.  We will create a PDB in the shardhost3 to simulate a non-sharded instance.

Estimated Lab Time: 30 minutes.

### Objectives

In this lab, you will perform the following steps:

- Create a non-shard service.
- Create the demo schema
- Setup and run the demo application
- Export the demo data.



### Prerequisites

This lab assumes you have already completed the following:

- Setup the Workshop Environment 



## Task 1: Create a Non-Shard Service

1. Connect to gsm host using **opc** user.

    ```
    $ <copy>ssh -i <ssh_private_key> opc@<gsmhost_public_ip></copy>
    ```

   

2. Copy the ssh private key to the shardhost3.

    ```
    [opc@gsmhost ~]$ <copy>scp -i <ssh_private_key> <ssh_private_key> opc@shardhost3:~</copy>
    ```
    
    
    
2. Connect to the shardhost3.

    ```
    [opc@gsmhost ~]$ <copy>ssh -i <ssh_private_key> opc@shardhost3</copy>
    Last login: Fri Sep 20 04:59:46 2024 from 10.0.0.20
    [opc@shardhost3 ~]$ 
    ```
    
    
    
2. Switch to the **oracle** user

    ```
    [opc@shardhost3 ~]$ <copy>sudo su - oracle</copy>
    Last login: Fri Sep 20 05:00:24 UTC 2024
    [oracle@shardhost3 ~]$ 
    ```
    
    
    
2. Connect to the database as sysdba.

    ```
    [oracle@shardhost3 ~]$ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Fri Sep 20 05:01:02 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Version 23.5.0.24.07
    
    SQL> 
    ```

   

3. Create a new pdb name **nspdb**.

    ```
    SQL> <copy>CREATE PLUGGABLE DATABASE nspdb ADMIN USER admin IDENTIFIED BY WelcomePTS_2024#;</copy>   
    Pluggable database created.
    ```

   

4. Open the PDB.

    ```
    SQL> <copy>alter pluggable database nspdb open;</copy>
    
    Pluggable database altered.
    ```

   

5. Connect to the PDB as sysdba.

    ```
    SQL> <copy>alter session set container = nspdb;</copy>
    
    Session altered.
    ```

   

6. Create a service named `GDS$CATALOG.ORADBCLOUD` and start it in order to run the demo application correctly.  (The service name is hard code in the demo application.)

    ```
    SQL> <copy>BEGIN
      DBMS_SERVICE.create_service(
        service_name => 'GDS$CATALOG.ORADBCLOUD',
        network_name => 'GDS$CATALOG.ORADBCLOUD'
      );
    END;
    /</copy>  2    3    4    5    6    7  
    
    PL/SQL procedure successfully completed.
    
    SQL> <copy>BEGIN
      DBMS_SERVICE.start_service(
        service_name => 'GDS$CATALOG.ORADBCLOUD'
      );
    END;
    /</copy>  2    3    4    5    6  
    
    PL/SQL procedure successfully completed.
    
    SQL> 
    ```

   

7. Exit from the sqlplus.

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Version 23.5.0.24.07
    [oracle@shardhost3 ~]$ 
    ```




## Task 2: Create the Demo Schema

1. Still in the shardhost3 with **oracle** user. Download the SQL script `nonshard-app-schema.sql`.

    ```
    [oracle@shardhost3 ~]$ <copy>wget https://github.com/minqiaowang/globally-distributed-database-with-raft/raw/main/setup-nonshard-app/nonshard-app-schema.sql</copy>
    ```

   

2. Review the content in the sql scripts file.

    ```
    [oracle@shardhost3 ~]$ <copy>cat nonshard-app-schema.sql</copy>
    set echo on 
    set termout on
    set time on
    spool /home/oracle/nonshard_app_schema.lst
    REM
    REM Connect to the pdb and Create Schema
    REM
    connect / as sysdba
    alter session set container=nspdb;
    create user app_schema identified by app_schema;
    grant connect, resource, alter session to app_schema;
    grant execute on dbms_crypto to app_schema;
    grant create table, create procedure, create tablespace, create materialized view to app_schema;
    grant unlimited tablespace to app_schema;
    grant select_catalog_role to app_schema;
    grant all privileges to app_schema;
    grant dba to app_schema;
    
    REM
    REM Create tables
    REM
    connect app_schema/app_schema@localhost:1521/nspdb
    
    REM
    REM Create for Customers  
    REM
    CREATE TABLE Customers
    (
      CustId      VARCHAR2(60) NOT NULL,
      FirstName   VARCHAR2(60),
      LastName    VARCHAR2(60),
      Class       VARCHAR2(10),
      Geo         VARCHAR2(8),
      CustProfile VARCHAR2(4000),
      Passwd      RAW(60),
      CONSTRAINT pk_customers PRIMARY KEY (CustId),
      CONSTRAINT json_customers CHECK (CustProfile IS JSON)
    ) 
    PARTITION BY HASH (CustId) PARTITIONS 12;
    
    REM
    REM Create table for Orders
    REM
    CREATE TABLE Orders
    (
      OrderId     INTEGER NOT NULL,
      CustId      VARCHAR2(60) NOT NULL,
      OrderDate   TIMESTAMP NOT NULL,
      SumTotal    NUMBER(19,4),
      Status      CHAR(4),
      constraint  pk_orders primary key (CustId, OrderId),
      constraint  fk_orders_parent foreign key (CustId) 
        references Customers on delete cascade
    ) 
    partition by reference (fk_orders_parent);
    
    REM
    REM Create the sequence used for the OrderId column
    REM
    CREATE SEQUENCE Orders_Seq;
    
    REM
    REM Create table for LineItems
    REM
    CREATE TABLE LineItems
    (
      OrderId     INTEGER NOT NULL,
      CustId      VARCHAR2(60) NOT NULL,
      ProductId   INTEGER NOT NULL,
      Price       NUMBER(19,4),
      Qty         NUMBER,
      constraint  pk_items primary key (CustId, OrderId, ProductId),
      constraint  fk_items_parent foreign key (CustId, OrderId)
        references Orders on delete cascade
    ) 
    partition by reference (fk_items_parent);
    
    REM
    REM Create table for Products
    REM
    CREATE TABLE Products
    (
      ProductId  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      Name       VARCHAR2(128),
      DescrUri   VARCHAR2(128),
      LastPrice  NUMBER(19,4)
    ) ;
    
    REM
    REM Create functions for Password creation and checking – used by the REM demo loader application
    REM
    
    CREATE OR REPLACE FUNCTION PasswCreate(PASSW IN RAW)
      RETURN RAW
    IS
      Salt RAW(8);
    BEGIN
      Salt := DBMS_CRYPTO.RANDOMBYTES(8);
      RETURN UTL_RAW.CONCAT(Salt, DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(Salt, PASSW), DBMS_CRYPTO.HASH_SH256));
    END;
    /
    
    CREATE OR REPLACE FUNCTION PasswCheck(PASSW IN RAW, PHASH IN RAW)
      RETURN INTEGER IS
    BEGIN
      RETURN UTL_RAW.COMPARE(
          DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(UTL_RAW.SUBSTR(PHASH, 1, 8), PASSW), DBMS_CRYPTO.HASH_SH256),
          UTL_RAW.SUBSTR(PHASH, 9));
    END;
    /
    
    REM
    REM
    select table_name from user_tables;
    REM
    REM
    spool off
    ```
    
   

3. Use SQLPLUS to run this sql scripts.

    ```
    [oracle@shardhost3 ~]$ <copy>sqlplus /nolog</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sat Sep 21 05:29:30 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle.  All rights reserved.
    
    SQL> <copy>@nonshard-app-schema.sql</copy>
    ```

   

4. The result screen like the following:

    ```
    SQL> set termout on
    SQL> set time on
    02:59:24 SQL> spool /home/oracle/nonshard_app_schema.lst
    02:59:24 SQL> REM
    02:59:24 SQL> REM Connect to the pdb and Create Schema
    02:59:24 SQL> REM
    02:59:24 SQL> connect / as sysdba
    Connected.
    02:59:24 SQL> alter session set container=nspdb;
    
    Session altered.
    
    02:59:24 SQL> create user app_schema identified by app_schema;
    
    User created.
    
    02:59:24 SQL> grant connect, resource, alter session to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant execute on dbms_crypto to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant create table, create procedure, create tablespace, create materialized view to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant unlimited tablespace to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant select_catalog_role to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant all privileges to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> grant dba to app_schema;
    
    Grant succeeded.
    
    02:59:24 SQL> 
    02:59:24 SQL> REM
    02:59:24 SQL> REM Create tables
    02:59:24 SQL> REM
    02:59:24 SQL> connect app_schema/app_schema@localhost:1521/nspdb
    Connected.
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create for Customers
    02:59:25 SQL> REM
    02:59:25 SQL> CREATE TABLE Customers
    02:59:25   2  (
    02:59:25   3  	CustId	    VARCHAR2(60) NOT NULL,
    02:59:25   4  	FirstName   VARCHAR2(60),
    02:59:25   5  	LastName    VARCHAR2(60),
    02:59:25   6  	Class	    VARCHAR2(10),
    02:59:25   7  	Geo	    VARCHAR2(8),
    02:59:25   8  	CustProfile VARCHAR2(4000),
    02:59:25   9  	Passwd	    RAW(60),
    02:59:25  10  	CONSTRAINT pk_customers PRIMARY KEY (CustId),
    02:59:25  11  	CONSTRAINT json_customers CHECK (CustProfile IS JSON)
    02:59:25  12  )
    02:59:25  13  PARTITION BY HASH (CustId) PARTITIONS 12;
    
    Table created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create table for Orders
    02:59:25 SQL> REM
    02:59:25 SQL> CREATE TABLE Orders
    02:59:25   2  (
    02:59:25   3  	OrderId     INTEGER NOT NULL,
    02:59:25   4  	CustId	    VARCHAR2(60) NOT NULL,
    02:59:25   5  	OrderDate   TIMESTAMP NOT NULL,
    02:59:25   6  	SumTotal    NUMBER(19,4),
    02:59:25   7  	Status	    CHAR(4),
    02:59:25   8  	constraint  pk_orders primary key (CustId, OrderId),
    02:59:25   9  	constraint  fk_orders_parent foreign key (CustId)
    02:59:25  10  	  references Customers on delete cascade
    02:59:25  11  )
    02:59:25  12  partition by reference (fk_orders_parent);
    
    Table created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create the sequence used for the OrderId column
    02:59:25 SQL> REM
    02:59:25 SQL> CREATE SEQUENCE Orders_Seq;
    
    Sequence created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create table for LineItems
    02:59:25 SQL> REM
    02:59:25 SQL> CREATE TABLE LineItems
    02:59:25   2  (
    02:59:25   3  	OrderId     INTEGER NOT NULL,
    02:59:25   4  	CustId	    VARCHAR2(60) NOT NULL,
    02:59:25   5  	ProductId   INTEGER NOT NULL,
    02:59:25   6  	Price	    NUMBER(19,4),
    02:59:25   7  	Qty	    NUMBER,
    02:59:25   8  	constraint  pk_items primary key (CustId, OrderId, ProductId),
    02:59:25   9  	constraint  fk_items_parent foreign key (CustId, OrderId)
    02:59:25  10  	  references Orders on delete cascade
    02:59:25  11  )
    02:59:25  12  partition by reference (fk_items_parent);
    
    Table created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create table for Products
    02:59:25 SQL> REM
    02:59:25 SQL> CREATE TABLE Products
    02:59:25   2  (
    02:59:25   3  	ProductId  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    02:59:25   4  	Name	   VARCHAR2(128),
    02:59:25   5  	DescrUri   VARCHAR2(128),
    02:59:25   6  	LastPrice  NUMBER(19,4)
    02:59:25   7  ) ;
    
    Table created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM Create functions for Password creation and checking – used by the REM demo loader application
    02:59:25 SQL> REM
    02:59:25 SQL> 
    02:59:25 SQL> CREATE OR REPLACE FUNCTION PasswCreate(PASSW IN RAW)
    02:59:25   2  	RETURN RAW
    02:59:25   3  IS
    02:59:25   4  	Salt RAW(8);
    02:59:25   5  BEGIN
    02:59:25   6  	Salt := DBMS_CRYPTO.RANDOMBYTES(8);
    02:59:25   7  	RETURN UTL_RAW.CONCAT(Salt, DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(Salt, PASSW), DBMS_CRYPTO.HASH_SH256));
    02:59:25   8  END;
    02:59:25   9  /
    
    Function created.
    
    02:59:25 SQL> 
    02:59:25 SQL> CREATE OR REPLACE FUNCTION PasswCheck(PASSW IN RAW, PHASH IN RAW)
    02:59:25   2  	RETURN INTEGER IS
    02:59:25   3  BEGIN
    02:59:25   4  	RETURN UTL_RAW.COMPARE(
    02:59:25   5  	    DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(UTL_RAW.SUBSTR(PHASH, 1, 8), PASSW), DBMS_CRYPTO.HASH_SH256),
    02:59:25   6  	    UTL_RAW.SUBSTR(PHASH, 9));
    02:59:25   7  END;
    02:59:25   8  /
    
    Function created.
    
    02:59:25 SQL> 
    02:59:25 SQL> REM
    02:59:25 SQL> REM
    02:59:25 SQL> select table_name from user_tables;
    
    TABLE_NAME
    --------------------------------------------------------------------------------
    CUSTOMERS
    ORDERS
    LINEITEMS
    PRODUCTS
    
    02:59:25 SQL> REM
    02:59:25 SQL> REM
    02:59:25 SQL> spool off
    ```

   

5. The single instance demo schema is created. Exit to the gsmhost.

    ```
    05:06:43 SQL> <copy>exit</copy>
    Disconnected from Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Version 23.5.0.24.07
    [oracle@shardhost3 ~]$ <copy>exit</copy>
    logout
    [opc@shardhost3 ~]$ <copy>exit</copy>
    logout
    Connection to shardhost3 closed.
    [opc@gsmhost ~]$ 
    ```




## Task 3: Setup and Run the Demo Application

1. From the gsm host, switch to the oracle user.

    ```
    [opc@gsmhost ~]$ <copy>sudo su - oracle</copy>
    Last login: Thu Sep 19 23:21:41 GMT 2024 on pts/0
    [oracle@gsmhost ~]$ 
    ```

   

2. Download the `sdb_demo_app.zip`  file.

    ```
    [oracle@gsmhost ~]$ <copy>wget https://github.com/minqiaowang/globally-distributed-database-with-raft/raw/main/setup-nonshard-app/sdb_demo_app.zip</copy>
    ```

   

3. Unzip the file. This will create `sdb_demo_app` directory under the `/home/oracle`.

    ```
    [oracle@gsmhost ~]$ <copy>unzip sdb_demo_app.zip</copy>
    ```

   

4. Change to the `sdb_demo_app/sql` directory.

    ```
    [oracle@gsmhost ~]$ <copy>cd sdb_demo_app/sql</copy>
    [oracle@gsmhost sql]$ 
    ```

   

5. View the content of the `nonshard_demo_app_ext.sql`. Make sure the connect string is correct to the non-sharded instance pdb.

    ```
    [oracle@gsmhost sql]$ <copy>cat nonshard_demo_app_ext.sql</copy> 
    -- Create catalog monitor packages
    connect sys/WelcomePTS_2024#@shardhost3:1521/nspdb as sysdba;
    
    @catalog_monitor.sql
    
    connect app_schema/app_schema@shardhost3:1521/nspdb;
    
    
    CREATE OR REPLACE VIEW SAMPLE_ORDERS AS
      SELECT OrderId, CustId, OrderDate, SumTotal FROM
        (SELECT * FROM ORDERS ORDER BY OrderId DESC)
          WHERE ROWNUM < 10;
    
    
    -- Allow a special query for dbaview
    connect sys/WelcomePTS_2024#@shardhost3:1521/nspdb as sysdba;
    
    -- For demo app purposes
    grant shard_monitor_role, gsmadmin_role to app_schema;
    
    
    create user dbmonuser identified by TEZiPP4_MsLLL_1;
    grant connect, alter session, shard_monitor_role, gsmadmin_role to dbmonuser;
    
    grant all privileges on app_schema.products to dbmonuser;
    grant read on app_schema.sample_orders to dbmonuser;
    
    -- End workaround
    
    exec dbms_global_views.create_any_view('SAMPLE_ORDERS', 'APP_SCHEMA.SAMPLE_ORDERS', 'GLOBAL_SAMPLE_ORDERS', 0, 1);
    ```

   

6. Using SQLPLUS to run the script.

    ```
    [oracle@gsmhost sql]$ <copy>sqlplus /nolog</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Fri Sep 20 04:42:49 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle.  All rights reserved.
    
    SQL> <copy>@nonshard_demo_app_ext.sql</copy>
    ```

   

7. The result screen like the following. Ignore the `ORA-02521` error because it's not a shard database.

    ```
    Connected.
    ERROR:
    ORA-02521: attempted to enable shard DDL in a non-shard database
    Help: https://docs.oracle.com/error-help/db/ora-02521/
    
    
    
    Role created.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Session altered.
    
    
    Package created.
    
    No errors.
    
    Package body created.
    
    No errors.
    
    PL/SQL procedure successfully completed.
    
    
    Type created.
    
    
    Type created.
    
    
    Package created.
    
    No errors.
    
    Package body created.
    
    No errors.
    
    Package body created.
    
    No errors.
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    PL/SQL procedure successfully completed.
    
    
    PL/SQL procedure successfully completed.
    
    
    PL/SQL procedure successfully completed.
    
    
    PL/SQL procedure successfully completed.
    
    Connected.
    
    View created.
    
    
    Session altered.
    
    Connected.
    
    Grant succeeded.
    
    ERROR:
    ORA-02521: attempted to enable shard DDL in a non-shard database
    Help: https://docs.oracle.com/error-help/db/ora-02521/
    
    
    
    User created.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Grant succeeded.
    
    
    Session altered.
    
    
    PL/SQL procedure successfully completed.
    ```

   

8. Exit the sqlplus. Then change directory to the `sdb_demo_app`.

    ```
    [oracle@gsmhost sql]$ <copy>cd ~/sdb_demo_app</copy>
    [oracle@gsmhost sdb_demo_app]$ 
    ```

   

9. Review the `nonsharddemo.properties` file content. Make sure the `connect_string` and service name  is correct.

    ```
    [oracle@gsmhost sdb_demo_app]$ <copy>cat nonsharddemo.properties</copy> 
    name=demo
    connect_string=(ADDRESS_LIST=(LOAD_BALANCE=off)(FAILOVER=on)(ADDRESS=(HOST=shardhost3)(PORT=1521)(PROTOCOL=tcp)))
    monitor.user=dbmonuser
    monitor.pass=TEZiPP4_MsLLL_1
    app.service.write=nspdb
    app.service.readonly=nspdb
    app.user=app_schema
    app.pass=app_schema
    app.threads=7
    ```

   

10. Start the workload by executing command using the nonsharddemo.properties parameter file: `"./run.sh demo nonsharddemo.properties"`.

    ```
    [oracle@cata sdb_demo_app]$ <copy>./run.sh demo nonsharddemo.properties</copy>
    ```

   

11. The result likes the following.

    ```
     RO Queries | RW Queries | RO Failed  | RW Failed  | APS 
              0            0            0            0            2
             82            0            0            0           24
            280           42            0            0           69
           4561          701            0            0         1439
          10162         1644            0            0         1899
          16393         2640            0            0         2116
          22619         3686            0            0         2104
          29035         4762            0            0         2179
          35508         5803            0            0         2199
          41834         6866            0            0         2170
          48704         7889            0            0         2366
          55126         8968            0            0         2191
          61378        10032            0            0         2131
          67119        10993            0            0         1965
          73903        12069            0            0         2335
          80310        13113            0            0         2200
          86965        14113            0            0         2313
          93728        15165            0            0         2326
         100194        16247            0            0         2241
         106178        17211            0            0         2087
    ```
    
    
    
12. Wait the application run several minutes and press `Ctrl-C` to exit the application. 

    ```
     RO Queries | RW Queries | RO Failed  | RW Failed  | APS 
         360777        59498            0            0         2301
         367004        60534            0            0         2266
         373080        61532            0            0         2190
         379101        62594            0            0         2215
         385379        63640            0            0         2310
         391673        64697            0            0         2292
         397901        65731            0            0         2262
         404158        66799            0            0         2297
         410087        67894            0            0         2168
         416111        68929            0            0         2205
         422107        70023            0            0         2192
         428365        71073            0            0         2301
         434379        72102            0            0         2186
         440585        73122            0            0         2289
         446531        74149            0            0         2209
    ^C[oracle@gsmhost sdb_demo_app]$ 
    ```




## Task 4: Export the Demo Data and Copy the DMP File

In this step, you will export the demo application data and copy the dmp file to the catalog and each of the shard hosts. You will import the data to the globally distributed database in the next lab.

1. Exit to the gsmhost **opc** user, connect to the shardhost3.

    ```
    [opc@gsmhost ~]$ <copy>ssh -i <ssh_private_key> opc@shardhost3</copy>
    Last login: Fri Sep 20 05:00:04 2024 from 10.0.0.20
    [opc@shardhost3 ~]$ 
    ```

   

2.  Switch to the oracle user.

    ```
    [opc@shardhost3 ~]$ <copy>sudo su - oracle</copy>
    Last login: Fri Sep 20 05:18:56 UTC 2024 on pts/0
    [oracle@shardhost3 ~]$ 
    ```
    
    
    
2. Connect to the non-sharded database as `app_schema` user with SQLPLUS.

    ```
    [oracle@shardhost3 ~]$ <copy>sqlplus app_schema/app_schema@shardhost3:1521/nspdb</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Fri Sep 20 05:19:53 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle.  All rights reserved.
    
    Last Successful login time: Fri Sep 20 2024 05:14:54 +00:00
    
    Connected to:
    Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Version 23.5.0.24.07
    
    SQL> 
    ```

   

3. Create a dump directory and 

    ```
    SQL> <copy>create directory demo_pump_dir as '/home/oracle';</copy>
    
    Directory created.
    ```

   

4. Exit the SQLPLUS.

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Version 23.5.0.24.07
    [oracle@shardhost3 ~]$ 
    ```
    
    
    
4. Run the following command to export the demo data.

    - `GROUP_PARTITION_TABLE_DATA `: Unloads all partitions as a single operation producing a single partition of data in the dump file. Subsequent imports will not know this was originally made up of multiple partitions.

    ```
    [oracle@shardhost3 ~]$ <copy>expdp app_schema/app_schema@shardhost3:1521/nspdb directory=demo_pump_dir \
      dumpfile=original.dmp logfile=original.log \
      schemas=app_schema data_options=group_partition_table_data</copy>
    ```

   

5. The result screen like the following.

    ```
    Export: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Fri Sep 20 05:26:48 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle and/or its affiliates.  All rights reserved.
    
    Connected to: Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
    Starting "APP_SCHEMA"."SYS_EXPORT_SCHEMA_01":  app_schema/********@shardhost3:1521/nspdb directory=demo_pump_dir dumpfile=original.dmp logfile=original.log schemas=app_schema data_options=group_partition_table_data 
    Processing object type SCHEMA_EXPORT/TABLE/TABLE_DATA
    Processing object type SCHEMA_EXPORT/TABLE/INDEX/STATISTICS/INDEX_STATISTICS
    Processing object type SCHEMA_EXPORT/TABLE/STATISTICS/TABLE_STATISTICS
    Processing object type SCHEMA_EXPORT/USER
    Processing object type SCHEMA_EXPORT/SYSTEM_GRANT
    Processing object type SCHEMA_EXPORT/ROLE_GRANT
    Processing object type SCHEMA_EXPORT/DEFAULT_ROLE
    Processing object type SCHEMA_EXPORT/PRE_SCHEMA/PROCACT_SCHEMA/LOGREP
    Processing object type SCHEMA_EXPORT/SEQUENCE/SEQUENCE
    Processing object type SCHEMA_EXPORT/TABLE/TABLE
    Processing object type SCHEMA_EXPORT/TABLE/GRANT/OWNER_GRANT/OBJECT_GRANT
    Processing object type SCHEMA_EXPORT/TABLE/COMMENT
    Processing object type SCHEMA_EXPORT/TABLE/IDENTITY_COLUMN
    Processing object type SCHEMA_EXPORT/FUNCTION/FUNCTION
    Processing object type SCHEMA_EXPORT/FUNCTION/ALTER_FUNCTION
    Processing object type SCHEMA_EXPORT/VIEW/VIEW
    Processing object type SCHEMA_EXPORT/VIEW/GRANT/OWNER_GRANT/OBJECT_GRANT
    Processing object type SCHEMA_EXPORT/TABLE/INDEX/INDEX
    Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/CONSTRAINT
    Processing object type SCHEMA_EXPORT/TABLE/CONSTRAINT/REF_CONSTRAINT
    . . exported "APP_SCHEMA"."CUSTOMERS"                      6.6 MB   29481 rows
    . . exported "APP_SCHEMA"."PRODUCTS"                      27.4 KB     480 rows
    . . exported "APP_SCHEMA"."ORDERS"                         2.3 MB   45611 rows
    . . exported "APP_SCHEMA"."LINEITEMS"                      3.2 MB   80891 rows
    Master table "APP_SCHEMA"."SYS_EXPORT_SCHEMA_01" successfully loaded/unloaded
    ******************************************************************************
    Dump file set for APP_SCHEMA.SYS_EXPORT_SCHEMA_01 is:
      /home/oracle/original.dmp
    Job "APP_SCHEMA"."SYS_EXPORT_SCHEMA_01" successfully completed at Fri Sep 20 05:28:26 2024 elapsed 0 00:01:36
    ```

   

6. From the shardhost3, Exit to **opc** user.

    ```
    [oracle@shardhost3 ~]$ <copy>exit</copy>
    logout
    [opc@shardhost3 ~]$
    ```

   

7. You can copy the dump file to a shared storage which all the host can access it or you can copy it to each of the host. In our lab, we will copy the dump file to the catalog host and each of the shard host.

    ```
    [opc@shardhost3 ~]$ <copy>sudo scp -i <ssh_private_key> /home/oracle/original.dmp opc@shardhost0:/tmp</copy>
    The authenticity of host 'shardhost0 (10.0.0.10)' can't be established.
    ECDSA key fingerprint is SHA256:+9TKXWk+ZjpgVTHccz73xTHhrj+T8UHvBPhOjutPk5c.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added 'shardhost0,10.0.0.10' (ECDSA) to the list of known hosts.
    original.dmp                                                                                     100%   13MB 189.4MB/s   00:00  
    
    [opc@shardhost3 ~]$ <copy>sudo scp -i <ssh_private_key> /home/oracle/original.dmp opc@shardhost1:/tmp</copy>
    The authenticity of host 'shardhost1 (10.0.0.11)' can't be established.
    ECDSA key fingerprint is SHA256:Ukred/JAQK0SvhfGPr7SuBexUkW4FqiLKsNQzwsiv3w.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added 'shardhost1,10.0.0.11' (ECDSA) to the list of known hosts.
    original.dmp                                                                                     100%   13MB 152.0MB/s   00:00    
    
    [opc@shardhost3 ~]$ <copy>sudo scp -i <ssh_private_key> /home/oracle/original.dmp opc@shardhost2:/tmp</copy>
    The authenticity of host 'shardhost2 (10.0.0.12)' can't be established.
    ECDSA key fingerprint is SHA256:9bcJpOj9J0YdRhuer1cenmiIkj/R0sImAuWaHlO9YSQ.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added 'shardhost2,10.0.0.12' (ECDSA) to the list of known hosts.
    original.dmp                                                                                     100%   13MB 172.4MB/s   00:00 
    ```
    
    
    
7. Exit to the gsmhost

    ```
    [opc@shardhost3 ~]$ <copy>exit</copy>
    logout
    Connection to shardhost3 closed.
    [opc@gsmhost ~]$ 
    ```
    
    
    
7. Connect to catalog host, move the dump file to the ```/home/oracle``` directory

    ```
    [opc@gsmhost ~]$ <copy>ssh -i <ssh_private_key> opc@shardhost0</copy>
    Last login: Fri Sep 20 04:53:28 2024 from 10.0.0.20
    
    [opc@shardhost0 ~]$ <copy>sudo chown oracle:oinstall /tmp/original.dmp</copy>
    [opc@shardhost0 ~]$ <copy>sudo mv /tmp/original.dmp /home/oracle</copy>
    [opc@shardhost0 ~]$ <copy>exit</copy>
    logout
    Connection to shardhost0 closed.
    [opc@gsmhost ~]$ 
    ```
    
    
    
7. Connect to shardhost1, move the dump file to the ```/home/oracle``` directory

    ```
    [opc@gsmhost ~]$ <copy>ssh -i <ssh_private_key> opc@shardhost1</copy>
    Last login: Thu Sep 19 23:15:42 2024 from 10.0.0.20
    [opc@shardhost1 ~]$ <copy>sudo chown oracle:oinstall /tmp/original.dmp</copy>
    [opc@shardhost1 ~]$ <copy>sudo mv /tmp/original.dmp /home/oracle</copy>
    [opc@shardhost1 ~]$ <copy>exit</copy>
    logout
    Connection to shardhost1 closed.
    [opc@gsmhost ~]$ 
    ```
    
    
    
7. Connect to shardhost2, move the dump file to the ```/home/oracle``` directory

    ```
    [opc@gsmhost ~]$ <copy>ssh -i <ssh_private_key> opc@shardhost2</copy>
    Last login: Fri Sep 20 04:53:28 2024 from 10.0.0.20
    
    [opc@shardhost2 ~]$ <copy>sudo chown oracle:oinstall /tmp/original.dmp</copy>
    [opc@shardhost2 ~]$ <copy>sudo mv /tmp/original.dmp /home/oracle</copy>
    [opc@shardhost2 ~]$ <copy>exit</copy>
    logout
    Connection to shardhost2 closed.
    [opc@gsmhost ~]$ 
    ```

   

You may now proceed to the next lab..

## Acknowledgements
* **Author** - Minqiao Wang, Oracle SE
* **Contributor** - Satyabrata Mishra, Database Product Management
* **Last Updated By/Date** - Minqiao Wang, Sep 2024

