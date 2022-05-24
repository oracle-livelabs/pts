# Create Shard App Schema

## Introduction

In this lab you will create a shard app schema. You will create a sharded table family `Customers->Orders->LineItems` sharded by `CustId`, and a duplicate table `Products`.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:
- Create the schema user, tablespace set, sharded tables and duplicated tables
- Verify that the DDLs have been propagated to all the shards
- Create a global service used to connect to the sharded database

### Prerequisites

This lab assumes you have already completed the following:
- Deploy the Sharded Database


## Task 1: Create Shard App Schema

1. Login to the shard director host using the public ip address, switch to oracle user.

    ```
    $ ssh -i labkey opc@xxx.xxx.xxx
    Last login: Sun Nov 29 01:26:28 2020 from 59.66.120.23
    -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
    
    [opc@sdbsd0 ~]$ sudo su - oracle
    Last login: Sun Nov 29 02:49:51 GMT 2020 on pts/0
     
    [oracle@sdbsd0 ~]$ 
    ```

   

2. Download the SQL scripts `create-app-schema-qs.sql`.

    ```
    [oracle@sdbsd0 ~]$ <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/create-app-schema-qs.sql</copy>
    ```

   

3. Edit the sql scripts file. Modify the sys user password in the connect string `connect sys/your-own-sys-password@sdbsc0:1521/sdbpdb as sysdba` to the catalog database. Make sure the connect string for the demo app_schema user to the catalog database is correct in your environment: `connect app_schema/App_Schema_Pass_123@sdbsc0:1521/sdbpdb`.

    ```
    [oracle@cata ~]$ <copy>vi create-app-schema-qs.sql</copy>  
    set echo on 
    set termout on
    set time on
    spool /home/oracle/create_app_schema.lst
    REM
    REM Connect to the Shard Catalog and Create Schema
    REM
    connect sys/your-own-sys-password@sdbsc0:1521/sdbpdb as sysdba
    REM alter session set container=catapdb;
    alter session enable shard ddl;
    create user app_schema identified by App_Schema_Pass_123;
    grant connect, resource, alter session to app_schema;
    grant execute on dbms_crypto to app_schema;
    grant create table, create procedure, create tablespace, create materialized view to app_schema;
    grant unlimited tablespace to app_schema;
    grant select_catalog_role to app_schema;
    grant all privileges to app_schema;
    grant gsmadmin_role to app_schema;
    grant dba to app_schema;
    
    
    REM
    REM Create a tablespace set for SHARDED tables
    REM
    CREATE TABLESPACE SET  TSP_SET_1 using template (datafile size 100m autoextend on next 10M maxsize unlimited extent management  local segment space management auto );
    
    REM
    REM Create a tablespace for DUPLICATED tables
    REM
    CREATE TABLESPACE products_tsp datafile size 100m autoextend on next 10M maxsize unlimited extent management local uniform size 1m; 
     
    REM
    REM Create Sharded and Duplicated tables
    REM
    connect app_schema/App_Schema_Pass_123@sdbsc0:1521/sdbpdb
    alter session enable shard ddl;
    REM
    REM Create a Sharded table for Customers  (Root table)
    REM
    CREATE SHARDED TABLE Customers
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
    ) TABLESPACE SET TSP_SET_1
    PARTITION BY CONSISTENT HASH (CustId) PARTITIONS AUTO;
    
    REM
    REM Create a Sharded table for Orders
    REM
    CREATE SHARDED TABLE Orders
    (
      OrderId     INTEGER NOT NULL,
      CustId      VARCHAR2(60) NOT NULL,
      OrderDate   TIMESTAMP NOT NULL,
      SumTotal    NUMBER(19,4),
      Status      CHAR(4),
      constraint  pk_orders primary key (CustId, OrderId),
      constraint  fk_orders_parent foreign key (CustId) 
        references Customers on delete cascade
    ) partition by reference (fk_orders_parent);
    
    REM
    REM Create the sequence used for the OrderId column
    REM
    CREATE SEQUENCE Orders_Seq;
    
    REM
    REM Create a Sharded table for LineItems
    REM
    CREATE SHARDED TABLE LineItems
    (
      OrderId     INTEGER NOT NULL,
      CustId      VARCHAR2(60) NOT NULL,
      ProductId   INTEGER NOT NULL,
      Price       NUMBER(19,4),
      Qty         NUMBER,
      constraint  pk_items primary key (CustId, OrderId, ProductId),
      constraint  fk_items_parent foreign key (CustId, OrderId)
        references Orders on delete cascade
    ) partition by reference (fk_items_parent);
    
    REM
    REM Create Duplicated table for Products
    REM
    CREATE DUPLICATED TABLE Products
    (
      ProductId  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
      Name       VARCHAR2(128),
      DescrUri   VARCHAR2(128),
      LastPrice  NUMBER(19,4)
    ) TABLESPACE products_tsp;
    
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
    [oracle@sdbsd0 ~]$ 
    ```

   

4. Use Sqlplus to run this sql scripts

    ```
    [oracle@sdbsd0 ~]$ sqlplus /nolog
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Mon Nov 30 01:26:03 2020
    Version 19.7.0.0.0
    
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    
    SQL> @create-app-schema-qs.sql
    ```

   

5. The result screen is like the following:

    ```
    SQL> set termout on
    SQL> set time on
    05:49:00 SQL> spool /home/oracle/create_app_schema.lst
    05:49:00 SQL> REM
    05:49:00 SQL> REM Connect to the Shard Catalog and Create Schema
    05:49:00 SQL> REM
    05:49:00 SQL> connect sys/sdwAf1Z82_wX5M_vm_0@sdbsc0:1521/sdbpdb as sysdba
    Connected.
    05:49:01 SQL> REM alter session set container=catapdb;
    05:49:01 SQL> alter session enable shard ddl;
    
    Session altered.
    
    05:49:01 SQL> create user app_schema identified by App_Schema_Pass_123;
    
    User created.
    
    05:49:01 SQL> grant connect, resource, alter session to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant execute on dbms_crypto to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant create table, create procedure, create tablespace, create materialized view to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant unlimited tablespace to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant select_catalog_role to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant all privileges to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant gsmadmin_role to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> grant dba to app_schema;
    
    Grant succeeded.
    
    05:49:01 SQL> 
    05:49:01 SQL> 
    05:49:01 SQL> REM
    05:49:01 SQL> REM Create a tablespace set for SHARDED tables
    05:49:01 SQL> REM
    05:49:01 SQL> CREATE TABLESPACE SET  TSP_SET_1 using template (datafile size 100m autoextend on next 10M maxsize unlimited extent management	local segment space management auto );
    
    Tablespace created.
    
    05:49:03 SQL> 
    05:49:03 SQL> REM
    05:49:03 SQL> REM Create a tablespace for DUPLICATED tables
    05:49:03 SQL> REM
    05:49:03 SQL> CREATE TABLESPACE products_tsp datafile size 100m autoextend on next 10M maxsize unlimited extent management local uniform size 1m;
    
    Tablespace created.
    
    05:49:04 SQL> 
    05:49:04 SQL> REM
    05:49:04 SQL> REM Create Sharded and Duplicated tables
    05:49:04 SQL> REM
    05:49:04 SQL> connect app_schema/App_Schema_Pass_123@sdbsc0:1521/sdbpdb
    Connected.
    05:49:04 SQL> alter session enable shard ddl;
    
    Session altered.
    
    05:49:04 SQL> REM
    05:49:04 SQL> REM Create a Sharded table for Customers	(Root table)
    05:49:04 SQL> REM
    05:49:04 SQL> CREATE SHARDED TABLE Customers
    05:49:04   2  (
    05:49:04   3  	CustId	    VARCHAR2(60) NOT NULL,
    05:49:04   4  	FirstName   VARCHAR2(60),
    05:49:04   5  	LastName    VARCHAR2(60),
    05:49:04   6  	Class	    VARCHAR2(10),
    05:49:04   7  	Geo	    VARCHAR2(8),
    05:49:04   8  	CustProfile VARCHAR2(4000),
    05:49:04   9  	Passwd	    RAW(60),
    05:49:04  10  	CONSTRAINT pk_customers PRIMARY KEY (CustId),
    05:49:04  11  	CONSTRAINT json_customers CHECK (CustProfile IS JSON)
    05:49:04  12  ) TABLESPACE SET TSP_SET_1
    05:49:04  13  PARTITION BY CONSISTENT HASH (CustId) PARTITIONS AUTO;
    
    Table created.
    
    05:49:04 SQL> 
    05:49:04 SQL> REM
    05:49:04 SQL> REM Create a Sharded table for Orders
    05:49:04 SQL> REM
    05:49:04 SQL> CREATE SHARDED TABLE Orders
    05:49:04   2  (
    05:49:04   3  	OrderId     INTEGER NOT NULL,
    05:49:04   4  	CustId	    VARCHAR2(60) NOT NULL,
    05:49:04   5  	OrderDate   TIMESTAMP NOT NULL,
    05:49:04   6  	SumTotal    NUMBER(19,4),
    05:49:04   7  	Status	    CHAR(4),
    05:49:04   8  	constraint  pk_orders primary key (CustId, OrderId),
    05:49:04   9  	constraint  fk_orders_parent foreign key (CustId)
    05:49:04  10  	  references Customers on delete cascade
    05:49:04  11  ) partition by reference (fk_orders_parent);
    
    Table created.
    
    05:49:05 SQL> 
    05:49:05 SQL> REM
    05:49:05 SQL> REM Create the sequence used for the OrderId column
    05:49:05 SQL> REM
    05:49:05 SQL> CREATE SEQUENCE Orders_Seq;
    
    Sequence created.
    
    05:49:05 SQL> 
    05:49:05 SQL> REM
    05:49:05 SQL> REM Create a Sharded table for LineItems
    05:49:05 SQL> REM
    05:49:05 SQL> CREATE SHARDED TABLE LineItems
    05:49:05   2  (
    05:49:05   3  	OrderId     INTEGER NOT NULL,
    05:49:05   4  	CustId	    VARCHAR2(60) NOT NULL,
    05:49:05   5  	ProductId   INTEGER NOT NULL,
    05:49:05   6  	Price	    NUMBER(19,4),
    05:49:05   7  	Qty	    NUMBER,
    05:49:05   8  	constraint  pk_items primary key (CustId, OrderId, ProductId),
    05:49:05   9  	constraint  fk_items_parent foreign key (CustId, OrderId)
    05:49:05  10  	  references Orders on delete cascade
    05:49:05  11  ) partition by reference (fk_items_parent);
    
    Table created.
    
    05:49:05 SQL> 
    05:49:05 SQL> REM
    05:49:05 SQL> REM Create Duplicated table for Products
    05:49:05 SQL> REM
    05:49:05 SQL> CREATE DUPLICATED TABLE Products
    05:49:05   2  (
    05:49:05   3  	ProductId  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    05:49:05   4  	Name	   VARCHAR2(128),
    05:49:05   5  	DescrUri   VARCHAR2(128),
    05:49:05   6  	LastPrice  NUMBER(19,4)
    05:49:05   7  ) TABLESPACE products_tsp;
    
    Table created.
    
    05:49:05 SQL> 
    05:49:05 SQL> REM
    05:49:05 SQL> REM Create functions for Password creation and checking – used by the REM demo loader application
    05:49:05 SQL> REM
    05:49:05 SQL> 
    05:49:05 SQL> CREATE OR REPLACE FUNCTION PasswCreate(PASSW IN RAW)
    05:49:05   2  	RETURN RAW
    05:49:05   3  IS
    05:49:05   4  	Salt RAW(8);
    05:49:05   5  BEGIN
    05:49:05   6  	Salt := DBMS_CRYPTO.RANDOMBYTES(8);
    05:49:05   7  	RETURN UTL_RAW.CONCAT(Salt, DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(Salt, PASSW), DBMS_CRYPTO.HASH_SH256));
    05:49:05   8  END;
    05:49:05   9  /
    
    Function created.
    
    05:49:05 SQL> 
    05:49:05 SQL> CREATE OR REPLACE FUNCTION PasswCheck(PASSW IN RAW, PHASH IN RAW)
    05:49:05   2  	RETURN INTEGER IS
    05:49:05   3  BEGIN
    05:49:05   4  	RETURN UTL_RAW.COMPARE(
    05:49:05   5  	    DBMS_CRYPTO.HASH(UTL_RAW.CONCAT(UTL_RAW.SUBSTR(PHASH, 1, 8), PASSW), DBMS_CRYPTO.HASH_SH256),
    05:49:05   6  	    UTL_RAW.SUBSTR(PHASH, 9));
    05:49:05   7  END;
    05:49:05   8  /
    
    Function created.
    
    05:49:05 SQL> 
    05:49:05 SQL> REM
    05:49:05 SQL> REM
    05:49:05 SQL> select table_name from user_tables;
    
    TABLE_NAME
    --------------------------------------------------------------------------------
    CUSTOMERS
    LINEITEMS
    ORDERS
    RUPD$_PRODUCTS
    MLOG$_PRODUCTS
    PRODUCTS
    
    6 rows selected.
    
    05:49:05 SQL> REM
    05:49:05 SQL> REM
    05:49:05 SQL> spool off
    05:49:05 SQL> 
    ```
   
   
   
6. The shard app demo schema is created. Exit the sqlplus.

    ```
    01:26:41 SQL> exit
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.7.0.0.0
    [oracle@sdbsd0 ~]$
    ```

   

## Task 2: Verify the Shard App Schema

1. Run GDSCTL command.

    ```
    [oracle@sdbsd0 ~]$ <copy>gdsctl</copy>
    GDSCTL: Version 19.0.0.0.0 - Production on Sat Jan 23 05:50:54 GMT 2021
    
    Copyright (c) 2011, 2019, Oracle.  All rights reserved.
    
    Welcome to GDSCTL, type "help" for information.
    
    Current GSM is set to SDBSD0
    GDSCTL> 
    ```
   
   

2. Run the following commands to observe that there are no failures during the creation of tablespaces.

    ```
    GDSCTL> <copy>show ddl</copy>
    Catalog connection is established
    id      DDL Text                                 Failed shards 
    --      --------                                 ------------- 
    9       grant dba to app_schema                                
    10      CREATE TABLESPACE SET  TSP_SET_1 usin...               
    11      CREATE TABLESPACE products_tsp datafi...               
    12      CREATE SHARDED TABLE Customers (   Cu...               
    13      CREATE SHARDED TABLE Orders (   Order...               
    14      CREATE SEQUENCE Orders_Seq                             
    15      CREATE SHARDED TABLE LineItems (   Or...               
    16      CREATE MATERIALIZED VIEW "APP_SCHEMA"...               
    17      CREATE OR REPLACE FUNCTION PasswCreat...               
    18      CREATE OR REPLACE FUNCTION PasswCheck...               
    
    GDSCTL> 
    ```

   

3. Run the config commands as shown below for each of the shards and verify if there are any DDL error. Make sure change the shard db name to the name as what you query out like `sdbsh*_xxxxxx_sdbpdb`.

    ```
    GDSCTL> config shard
    Name                Shard Group         Status    State       Region    Availability 
    ----                -----------         ------    -----       ------    ------------ 
    sdbsh0_icn1gr_sdbpd shardgroup0         Ok        Deployed    apseoul1  ONLINE       
    b                                                                                    
    sdbsh1_icn1xv_sdbpd shardgroup0         Ok        Deployed    apseoul1  ONLINE       
    b                                                                                    
    
    GDSCTL> config shard -shard sdbsh0_icn1gr_sdbpdb
    Name: sdbsh0_icn1gr_sdbpdb
    Shard Group: shardgroup0
    Status: Ok
    State: Deployed
    Region: apseoul1
    Connection string: 193.122.123.64:1521/sdbpdb
    SCAN address: 
    ONS remote port: 0
    Disk Threshold, ms: 20
    CPU Threshold, %: 75
    Version: 19.0.0.0
    Failed DDL: 
    DDL Error: ---
    Failed DDL id: 
    Availability: ONLINE
    Rack: 
    
    
    Supported services
    ------------------------
    Name                                                            Preferred Status    
    ----                                                            --------- ------    
    
    GDSCTL> config shard -shard sdbsh1_icn1xv_sdbpdb
    Name: sdbsh1_icn1xv_sdbpdb
    Shard Group: shardgroup0
    Status: Ok
    State: Deployed
    Region: apseoul1
    Connection string: 193.123.225.45:1521/sdbpdb
    SCAN address: 
    ONS remote port: 0
    Disk Threshold, ms: 20
    CPU Threshold, %: 75
    Version: 19.0.0.0
    Failed DDL: 
    DDL Error: ---
    Failed DDL id: 
    Availability: ONLINE
    Rack: 
    
    
    Supported services
    ------------------------
    Name                                                            Preferred Status    
    ----                                                            --------- ------    
    
    GDSCTL> 
    ```

   

4. Exit GDSCTL.

    ```
    GDSCTL> <copy>exit</copy>
    [oracle@sdbsd0 ~]$ 
    ```
   
   
   
6. Connect to the shard db0 using your own sys user password.

    ```
    [oracle@sdbsd0 ~]$ <copy>sqlplus sys/sdwAf1Z82_wX5M_vm_0@sdbsh0:1521/sdbpdb as sysdba</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 23 05:56:24 2021
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    
    SQL> 
    ```

   

7. Check the created tablespace set.

    ```
    SQL> <copy>select TABLESPACE_NAME, BYTES/1024/1024 MB from sys.dba_data_files order by tablespace_name;</copy>
    
    TABLESPACE_NAME 		       MB
    ------------------------------ ----------
    C001TSP_SET_1			      100
    C002TSP_SET_1			      100
    C003TSP_SET_1			      100
    C004TSP_SET_1			      100
    C005TSP_SET_1			      100
    C006TSP_SET_1			      100
    PRODUCTS_TSP			      100
    SYSAUX				      420
    SYSTEM				      310
    TSP_SET_1			      100
    UNDOTBS1			      165
    
    TABLESPACE_NAME 		       MB
    ------------------------------ ----------
    USERS					5
    
    12 rows selected.
    
    SQL> 
    ```

   

8. Verify that the chunks and chunk tablespaces are created.

    ```
    SQL> set linesize 140
    SQL> column table_name format a20
    SQL> column tablespace_name format a20
    SQL> column partition_name format a20
    SQL> select table_name, partition_name, tablespace_name from dba_tab_partitions where tablespace_name like 'C%TSP_SET_1' order by tablespace_name;
    
    TABLE_NAME	     PARTITION_NAME	  TABLESPACE_NAME
    -------------------- -------------------- --------------------
    ORDERS		     CUSTOMERS_P1	  C001TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P1	  C001TSP_SET_1
    LINEITEMS	     CUSTOMERS_P1	  C001TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P2	  C002TSP_SET_1
    LINEITEMS	     CUSTOMERS_P2	  C002TSP_SET_1
    ORDERS		     CUSTOMERS_P2	  C002TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P3	  C003TSP_SET_1
    ORDERS		     CUSTOMERS_P3	  C003TSP_SET_1
    LINEITEMS	     CUSTOMERS_P3	  C003TSP_SET_1
    ORDERS		     CUSTOMERS_P4	  C004TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P4	  C004TSP_SET_1
    
    TABLE_NAME	     PARTITION_NAME	  TABLESPACE_NAME
    -------------------- -------------------- --------------------
    LINEITEMS	     CUSTOMERS_P4	  C004TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P5	  C005TSP_SET_1
    LINEITEMS	     CUSTOMERS_P5	  C005TSP_SET_1
    ORDERS		     CUSTOMERS_P5	  C005TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P6	  C006TSP_SET_1
    LINEITEMS	     CUSTOMERS_P6	  C006TSP_SET_1
    ORDERS		     CUSTOMERS_P6	  C006TSP_SET_1
    
    18 rows selected.
    
    SQL> 
    ```

   

9. Connect to the shard pdb1 using your own sys user password.

    ```
    SQL> <copy>connect sys/sdwAf1Z82_wX5M_vm_0@sdbsh1:1521/sdbpdb as sysdba</copy>
    Connected.
    SQL>
    ```

   

10. Check the created tablespace set.

    ```
    SQL> <copy>select TABLESPACE_NAME, BYTES/1024/1024 MB from sys.dba_data_files order by tablespace_name;</copy>
    
    TABLESPACE_NAME 		       MB
    ------------------------------ ----------
    C007TSP_SET_1			      100
    C008TSP_SET_1			      100
    C009TSP_SET_1			      100
    C00ATSP_SET_1			      100
    C00BTSP_SET_1			      100
    C00CTSP_SET_1			      100
    PRODUCTS_TSP			      100
    SYSAUX				      440
    SYSTEM				      310
    TSP_SET_1			      100
    UNDOTBS1			      165
    
    TABLESPACE_NAME 		       MB
    ------------------------------ ----------
    USERS					5
    
    12 rows selected.
    
    SQL> 
    ```

    

11. Verify that the chunks and chunk tablespaces are created.

    ```
    SQL> select table_name, partition_name, tablespace_name from dba_tab_partitions where tablespace_name like 'C%TSP_SET_1' order by tablespace_name;
    
    TABLE_NAME	     PARTITION_NAME	  TABLESPACE_NAME
    -------------------- -------------------- --------------------
    ORDERS		     CUSTOMERS_P7	  C007TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P7	  C007TSP_SET_1
    LINEITEMS	     CUSTOMERS_P7	  C007TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P8	  C008TSP_SET_1
    LINEITEMS	     CUSTOMERS_P8	  C008TSP_SET_1
    ORDERS		     CUSTOMERS_P8	  C008TSP_SET_1
    CUSTOMERS	     CUSTOMERS_P9	  C009TSP_SET_1
    ORDERS		     CUSTOMERS_P9	  C009TSP_SET_1
    LINEITEMS	     CUSTOMERS_P9	  C009TSP_SET_1
    ORDERS		     CUSTOMERS_P10	  C00ATSP_SET_1
    CUSTOMERS	     CUSTOMERS_P10	  C00ATSP_SET_1
    
    TABLE_NAME	     PARTITION_NAME	  TABLESPACE_NAME
    -------------------- -------------------- --------------------
    LINEITEMS	     CUSTOMERS_P10	  C00ATSP_SET_1
    CUSTOMERS	     CUSTOMERS_P11	  C00BTSP_SET_1
    LINEITEMS	     CUSTOMERS_P11	  C00BTSP_SET_1
    ORDERS		     CUSTOMERS_P11	  C00BTSP_SET_1
    CUSTOMERS	     CUSTOMERS_P12	  C00CTSP_SET_1
    LINEITEMS	     CUSTOMERS_P12	  C00CTSP_SET_1
    ORDERS		     CUSTOMERS_P12	  C00CTSP_SET_1
    
    18 rows selected.
    
    SQL> 
    ```
    
    
    
12. Connect to the catalog database using your own sys user password..

    ```
    SQL> <copy>connect sys/sdwAf1Z82_wX5M_vm_0@sdbsc0:1521/sdbpdb as sysdba</copy>
    Connected.
    SQL> 
    ```

    

13.  Query the `gsmadmin_internal.chunk_loc` table to observe that the chunks are uniformly distributed.

    ```
    SQL> column shard format a40
    SQL> select a.name Shard,count( b.chunk_number) Number_of_Chunks from gsmadmin_internal.database a, gsmadmin_internal.chunk_loc b where a.database_num=b.database_num group by a.name;
    
    SHARD					 NUMBER_OF_CHUNKS
    ---------------------------------------- ----------------
    shd1_shdpdb1						6
    shd2_shdpdb2						6
    
    SQL> 
    ```

    

14. Connect into the app_schema on the catalog, shard0, shard1 databases and verify that the sharded and duplicated tables are created.

    ```
    SQL> connect app_schema/App_Schema_Pass_123@sdbsc0:1521/sdbpdb
    Connected.
    SQL> select table_name from user_tables;
    
    TABLE_NAME
    --------------------------------------------------------------------------------
    CUSTOMERS
    ORDERS
    LINEITEMS
    PRODUCTS
    MLOG$_PRODUCTS
    RUPD$_PRODUCTS
    
    6 rows selected.
    
    SQL> connect app_schema/App_Schema_Pass_123@sdbsh0:1521/sdbpdb
    Connected.
    SQL> select table_name from user_tables;
    
    TABLE_NAME
    --------------------------------------------------------------------------------
    CUSTOMERS
    ORDERS
    LINEITEMS
    PRODUCTS
    USLOG$_PRODUCTS
    
    SQL> connect app_schema/App_Schema_Pass_123@sdbsh1:1521/sdbpdb
    Connected.
    SQL> select table_name from user_tables;
    
    TABLE_NAME
    --------------------------------------------------------------------------------
    CUSTOMERS
    ORDERS
    LINEITEMS
    PRODUCTS
    USLOG$_PRODUCTS
    
    SQL> 
    ```

    

15. Exit the sqlplus.

    ```
    SQL> exit
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    [oracle@sdbsd0 ~]$
    ```

    

## Task 3: Create a global service

1. Login to the shard director host, switch to oracle user.

    ```
    $ ssh -i labkey opc@xxx.xxx.xxx.xxx
    Last login: Sat Jan 23 05:22:09 2021 from 59.66.120.23
    -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
    
    [opc@sdbsd0 ~]$ sudo su - oracle
    Last login: Sat Jan 23 05:22:16 GMT 2021 on pts/0
    [oracle@sdbsd0 ~]$ 
    ```

   

2. Run the GDSCTL command.

    ```
    [oracle@sdbsd0 ~]$ <copy>gdsctl</copy>
    GDSCTL: Version 19.0.0.0.0 - Production on Sat Jan 23 06:24:25 GMT 2021
    
    Copyright (c) 2011, 2019, Oracle.  All rights reserved.
    
    Welcome to GDSCTL, type "help" for information.
    
    Current GSM is set to SDBSD0
    GDSCTL> 
    ```

   

3. Create a global service named `oltp_rw_srvc` that a client can use to connect to the sharded database. The `oltp_rw_srvc` service runs read/write transactions on the primary shards.

    ```
    GDSCTL> <copy>add service -service oltp_rw_srvc -role primary</copy>
    Catalog connection is established
    The operation completed successfully
    GDSCTL> 
    ```

   

4. Start the service.

    ```
    GDSCTL> <copy>start service -service oltp_rw_srvc</copy>
    The operation completed successfully
    GDSCTL>
    ```

   

5. Check the service configuration.

    ```
    GDSCTL> <copy>config service</copy>
    
    
    Name           Network name                  Pool           Started Preferred all 
    ----           ------------                  ----           ------- ------------- 
    oltp_rw_srvc   oltp_rw_srvc.sdb.oradbcloud   sdb            Yes     Yes           
    
    GDSCTL> 
    ```

   

6. Check the status of the service

    ```
    GDSCTL> <copy>status service</copy>
    Service "oltp_rw_srvc.sdb.oradbcloud" has 2 instance(s). Affinity: ANYWHERE
       Instance "sdb%1", name: "sdbsh0", db: "sdbsh0_icn1gr_sdbpdb", region: "apseoul1", status: ready.
       Instance "sdb%11", name: "sdbsh1", db: "sdbsh1_icn1xv_sdbpdb", region: "apseoul1", status: ready.
    
    GDSCTL> 
    ```

   

7. Exit the GDSCTL.

    ```
    GDSCTL> exit
    [oracle@sdbsd0 ~]$
    ```

   

8. Check the shard director listener status. You can see listening on 1522 port there is a service named `oltp_rw_srvc.orasdb.oradbcloud` which we create previously.

    ```
    [oracle@sdbsd0 ~]$ lsnrctl status sdbsd0
    
    LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 23-JAN-2021 06:34:17
    
    Copyright (c) 1991, 2019, Oracle.  All rights reserved.
    
    Connecting to (DESCRIPTION=(ADDRESS=(HOST=sdbsd0.subnet.vcn.oraclevcn.com)(PORT=1522)(PROTOCOL=tcp))(CONNECT_DATA=(SERVICE_NAME=GDS$CATALOG.oradbcloud)))
    STATUS of the LISTENER
    ------------------------
    Alias                     SDBSD0
    Version                   TNSLSNR for Linux: Version 19.0.0.0.0 - Production
    Start Date                23-JAN-2021 05:18:54
    Uptime                    0 days 1 hr. 15 min. 23 sec
    Trace Level               off
    Security                  ON: Local OS Authentication
    SNMP                      OFF
    Listener Parameter File   /u01/app/oracle/product/19.3.0/gsmhome_1/network/admin/gsm.ora
    Listener Log File         /u01/app/oracle/diag/gsm/sdbsd0/sdbsd0/alert/log.xml
    Listening Endpoints Summary...
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=sdbsd0.subnet.vcn.oraclevcn.com)(PORT=1522)))
    Services Summary...
    Service "GDS$CATALOG.oradbcloud" has 1 instance(s).
      Instance "sdbsc0", status READY, has 1 handler(s) for this service...
    Service "GDS$COORDINATOR.oradbcloud" has 1 instance(s).
      Instance "sdbsc0", status READY, has 1 handler(s) for this service...
    Service "_MONITOR" has 1 instance(s).
      Instance "SDBSD0", status READY, has 1 handler(s) for this service...
    Service "_PINGER" has 1 instance(s).
      Instance "SDBSD0", status READY, has 1 handler(s) for this service...
    Service "oltp_rw_srvc.sdb.oradbcloud" has 2 instance(s).
      Instance "sdb%1", status READY, has 1 handler(s) for this service...
      Instance "sdb%11", status READY, has 1 handler(s) for this service...
    The command completed successfully
    [oracle@sdbsd0 ~]$ 
    ```

   

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Minqiao Wang, DB Product Management, Jan 2021
* **Last Updated By/Date** - Minqiao Wang, Jul 2021
* **Workshop Expiry Date** - Jul 2022