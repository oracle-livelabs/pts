# Data Dependent Routing

## Introduction
In Oracle Sharding, database query and DML requests are routed to the shards in two main ways, depending on whether a sharding key is supplied with the request. 

You can connect directly to the shards to execute queries and DML by providing a sharding key with the database request. Direct routing is the preferred way of accessing shards to achieve better performance, among other benefits. 

Queries that need data from multiple shards, and queries that do not specify a sharding key, cannot be routed directly by the application. Those queries require a proxy to route requests between the application and the shards. Proxy routing is handled by the shard catalog query coordinator.

Estimated Lab Time: 20 minutes.

### Objectives

In this lab, you will perform the following steps:
- Routing Queries and DMLs Directly to Shards
- Routing Queries and DMLs by Proxy
- Multi-Shard Queries.

### Prerequisites

This lab assumes you have already completed the following:
- Sharded Database Deployment
- Create demo app schema

## **STEP 1:** Routing Queries and DMLs Directly to Shards

1. Login to the shard director host, switch to oracle user.

    ```
    $ ssh -i labkey opc@xxx.xxx.xxx.xxx
    Last login: Sat Jan 23 05:22:09 2021 from 59.66.120.23
    -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
    
    [opc@sdbsd0 ~]$ sudo su - oracle
    Last login: Sat Jan 23 05:22:16 GMT 2021 on pts/0
    [oracle@sdbsd0 ~]$ 
    ```

   

3. For single-shard queries, direct routing to a shard with a given sharding_key.

    ```
    [oracle@sdbsd0 ~]$ <copy>sqlplus app_schema/App_Schema_Pass_123@'(description=(address=(protocol=tcp)(host=sdbsd0)(port=1522))(connect_data=(service_name=oltp_rw_srvc.sdb.oradbcloud)(SHARDING_KEY=tom.edwards@y.bogus)))'</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 23 06:47:03 2021
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Jan 23 2021 06:07:11 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    
    SQL> 
    ```

   

4. Insert a record and commit.

    ```
    SQL> <copy>INSERT INTO Customers (CustId, FirstName, LastName, CustProfile, Class, Geo, Passwd) VALUES ('tom.edwards@y.bogus', 'Tom', 'Edwards', NULL, 'Gold', 'east', hextoraw('8d1c00e'));</copy>
    
    1 row created.
    
    SQL> 
    ```

   

5. Commit.

    ```
    SQL> <copy>commit;</copy>
    
    Commit complete.
    
    SQL> 
    ```

   

5. Check current connected shard database. 

    ```
    SQL> <copy>select db_unique_name from v$database;</copy>
    
    DB_UNIQUE_NAME
    ------------------------------
    sdbsh0_icn1gr
    
    SQL> 
    ```

   

6. Select from the customer table. You can see there is one record which you just insert in the table.

    ```
    SQL> <copy>select * from customers where custid like '%y.bogus';</copy>
    
    CUSTID
    ------------------------------------------------------------
    FIRSTNAME
    ------------------------------------------------------------
    LASTNAME						     CLASS	GEO
    ------------------------------------------------------------ ---------- --------
    CUSTPROFILE
    --------------------------------------------------------------------------------
    PASSWD
    --------------------------------------------------------------------------------
    tom.edwards@y.bogus
    Tom
    Edwards 						     Gold	east
    
    CUSTID
    ------------------------------------------------------------
    FIRSTNAME
    ------------------------------------------------------------
    LASTNAME						     CLASS	GEO
    ------------------------------------------------------------ ---------- --------
    CUSTPROFILE
    --------------------------------------------------------------------------------
    PASSWD
    --------------------------------------------------------------------------------
    
    08D1C00E
    
    
    SQL> 
    ```

   

7. Exit from the sqlplus.

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    [oracle@sdbsd0 ~]$ 
    ```

   

8. Connect to a shard with another shard key.

    ```
    [oracle@sdbsd0 ~]$ <copy>sqlplus app_schema/App_Schema_Pass_123@'(description=(address=(protocol=tcp)(host=sdbsd0)(port=1522))(connect_data=(service_name=oltp_rw_srvc.sdb.oradbcloud)(SHARDING_KEY=james.parker@y.bogus)))'</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 23 06:53:23 2021
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Jan 23 2021 06:07:34 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    
    SQL> 
    ```

   

9. Insert another record and commit.

    ```
    SQL> <copy>INSERT INTO Customers (CustId, FirstName, LastName, CustProfile, Class, Geo, Passwd) VALUES ('james.parker@y.bogus', 'James', 'Parker', NULL, 'Gold', 'west', hextoraw('9a3b00c'));</copy>
    
    1 row created.
    
    SQL> 
    ```

   

10. Commit.

    ```
    SQL> <copy>commit;</copy>
    
    Commit complete.
    
    SQL> 
    ```

   

11. Check current connected shard database.

    ```
    SQL> <copy>select db_unique_name from v$database;</copy>
    
    DB_UNIQUE_NAME
    ------------------------------
    sdbsh1_icn1xv
    
    SQL> 
    ```

    

12. Select from the table. You can see there is only one record in the shard1 database.

    ```
    SQL> <copy>select * from customers where custid like '%y.bogus';</copy>
    
    CUSTID
    ------------------------------------------------------------
    FIRSTNAME
    ------------------------------------------------------------
    LASTNAME						     CLASS	GEO
    ------------------------------------------------------------ ---------- --------
    CUSTPROFILE
    --------------------------------------------------------------------------------
    PASSWD
    --------------------------------------------------------------------------------
    james.parker@y.bogus
    James
    Parker							     Gold	west
    
    CUSTID
    ------------------------------------------------------------
    FIRSTNAME
    ------------------------------------------------------------
    LASTNAME						     CLASS	GEO
    ------------------------------------------------------------ ---------- --------
    CUSTPROFILE
    --------------------------------------------------------------------------------
    PASSWD
    --------------------------------------------------------------------------------
    
    09A3B00C
    
    
    SQL> 
    ```

    

13. Exit from the sqlplus.

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    [oracle@sdbsd0 ~]$
    ```

    

## **STEP 2:** Routing Queries and DMLs by Proxy

1. Connect to the shardcatalog (coordinator database) using the GDS$CATALOG service (from catalog or any shard host):

    ```
    [oracle@sdbsd0 ~]$ <copy>sqlplus app_schema/App_Schema_Pass_123@sdbsd0:1522/GDS\$CATALOG.oradbcloud</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 23 06:57:25 2021
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Jan 23 2021 06:56:27 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    
    SQL> 
    ```

   

2. Select records from customers table. You can see all the records are selected.

    ```
    SQL> <copy>select custid from customers where custid like '%y.bogus';</copy>
    
    CUSTID
    ------------------------------------------------------------
    tom.edwards@y.bogus
    james.parker@y.bogus
    
    SQL> 
    ```

   

3. Check current connected database.

    ```
    SQL> <copy>select db_unique_name from v$database;</copy>
    
    DB_UNIQUE_NAME
    ------------------------------
    sdbsc0_icn1s2
    
    SQL> 
    ```

   

4. Exit from the sqlplus

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    [oracle@sdbsd0 ~]$ 
    ```




## **STEP 3:**  Multi-Shard Query

A multi-shard query is a query that must scan data from more than one shard, and the processing on each shard is independent of any other shard.

A multi-shard query maps to more than one shard and the coordinator might need to do some processing before sending the result to the client. The inline query block is mapped to every shard just as a remote mapped query block. The coordinator performs further aggregation and `GROUP BY` on top of the result set from all shards. The unit of execution on every shard is the inline query block. 

1. Use sqlplus connect to catalog database as `app_schema` user.

    ```
    [oracle@sdbsd0 ~]$ <copy>sqlplus app_schema/App_Schema_Pass_123@sdbsc0:1521/sdbpdb</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Jan 23 07:00:46 2021
    Version 19.3.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Jan 23 2021 07:00:28 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    
    SQL> 
    ```

   

2. Let’s run a multi-shard query which joins sharded and duplicated table (join on non sharding key) to get the fast moving products (qty sold > 10). The output that you will observe will be different (due to data load randomization). First, explain the SQL excution plan.

    ```
    SQL> <copy>set echo on</copy>
    SQL> <copy>set linesize 120</copy>
    SQL> <copy>column name format a40</copy>
    SQL> <copy>explain plan for SELECT name, SUM(qty) qtysold FROM lineitems l, products p WHERE l.productid = p.productid GROUP BY name HAVING sum(qty) > 10 ORDER BY qtysold desc;</copy>
    
    Explained.
    
    SQL> <copy>set echo off</copy>
    SQL> <copy>select * from table(dbms_xplan.display());</copy>
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    Plan hash value: 2044377012
    
    --------------------------------------------------------------------------------------------------------
    | Id  | Operation	   | Name	       | Rows  | Bytes | Cost (%CPU)| Time     | Inst	|IN-OUT|
    --------------------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT   |		       |     1 |    79 |     4	(50)| 00:00:01 |	|      |
    |   1 |  SORT ORDER BY	   |		       |     1 |    79 |     4	(50)| 00:00:01 |	|      |
    |*  2 |   HASH GROUP BY    |		       |     1 |    79 |     4	(50)| 00:00:01 |	|      |
    |   3 |    VIEW 	   | VW_SHARD_372F2D25 |     1 |    79 |     4	(50)| 00:00:01 |	|      |
    |   4 |     SHARD ITERATOR |		       |       |       |	    |	       |	|      |
    |   5 |      REMOTE	   |		       |       |       |	    |	       | ORA_S~ | R->S |
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------
    
    Predicate Information (identified by operation id):
    ---------------------------------------------------
    
       2 - filter(SUM("ITEM_1")>10)
    
    Remote SQL Information (identified by operation id):
    ----------------------------------------------------
    
       5 - EXPLAIN PLAN INTO PLAN_TABLE@! FOR SELECT SUM("A2"."QTY"),"A1"."NAME" FROM "LINEITEMS"
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
           "A2","PRODUCTS" "A1" WHERE "A2"."PRODUCTID"="A1"."PRODUCTID" GROUP BY "A1"."NAME" /*
           coord_sql_id=g415vyfr9rg2a */  (accessing 'ORA_SHARD_POOL.SUBNET.VCN.ORACLEVCN.COM@ORA_MULTI_TAR
           GET' )
    
    
    26 rows selected.
    ```
    
    Then, run the query.
    
    ```
    SQL> <copy>SELECT name, SUM(qty) qtysold FROM lineitems l, products p WHERE l.productid = p.productid GROUP BY name HAVING sum(qty) > 10 ORDER BY qtysold desc;</copy>
    
    NAME					    QTYSOLD
    ---------------------------------------- ----------
    Engine block				       5068
    Distributor				       4935
    Battery 				       4907
    Thermostat				       4889
    Fastener				       4841
    ......
    ......
    Starter solenoid			       2170
    Brake lining				       2167
    Gear ring				       2163
    Carburetor parts			       2162
    Valve cover				       2161
    Exhaust flange gasket			       2137
    
    469 rows selected.
    
    SQL> 
    ```

   

3. Let’s run a multi-shard query which runs an IN subquery to get orders that includes product with `price > 900000`. First, explain the SQL execute plan.

    ```
    SQL> <copy>set echo on</copy>
    SQL> <copy>column name format a20</copy>
    SQL> <copy>explain plan for SELECT COUNT(orderid) FROM orders o WHERE orderid IN (SELECT orderid FROM lineitems l, products p WHERE l.productid = p.productid AND o.custid = l.custid AND p.lastprice > 900000);</copy>
    
    Explained.
    
    SQL> <copy>set echo off</copy>
    SQL> <copy>select * from table(dbms_xplan.display());</copy>
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    Plan hash value: 2403723386
    
    -------------------------------------------------------------------------------------------------------
    | Id  | Operation	  | Name	      | Rows  | Bytes | Cost (%CPU)| Time     | Inst   |IN-OUT|
    -------------------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |		      |     1 |    13 |     2	(0)| 00:00:01 |        |      |
    |   1 |  SORT AGGREGATE   |		      |     1 |    13 | 	   |	      |        |      |
    |   2 |   VIEW		  | VW_SHARD_72AE2D8F |     1 |    13 |     2	(0)| 00:00:01 |        |      |
    |   3 |    SHARD ITERATOR |		      |       |       | 	   |	      |        |      |
    |   4 |     REMOTE	  |		      |       |       | 	   |	      | ORA_S~ | R->S |
    -------------------------------------------------------------------------------------------------------
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    
    Remote SQL Information (identified by operation id):
    ----------------------------------------------------
    
       4 - EXPLAIN PLAN INTO PLAN_TABLE@! FOR SELECT COUNT(*) FROM "ORDERS" "A1" WHERE
           "A1"."ORDERID"=ANY (SELECT "A3"."ORDERID" FROM "LINEITEMS" "A3","PRODUCTS" "A2" WHERE
           "A3"."PRODUCTID"="A2"."PRODUCTID" AND "A1"."CUSTID"="A3"."CUSTID" AND "A2"."LASTPRICE">900000)
           /* coord_sql_id=ff5nrpzr2ddnf */  (accessing 'ORA_SHARD_POOL.SUBNET.VCN.ORACLEVCN.COM@ORA_MULTI
           _TARGET' )
    
    
    21 rows selected.
    ```
    
    Then, run the query.
    
    ```
    SQL> <copy>SELECT COUNT(orderid) FROM orders o WHERE orderid IN (SELECT orderid FROM lineitems l, products p WHERE l.productid = p.productid AND o.custid = l.custid AND p.lastprice > 900000);</copy>
    
    COUNT(ORDERID)
    --------------
    	 32366
    
    SQL> 
    ```

   

4. Let’s run a multi-shard query that calculates customer distribution based on the number of orders placed. Please wait several minutes for the results return. First, explain the SQL execute plan.

    ```
    SQL> <copy>set echo off</copy>
    SQL> <copy>column name format a40</copy>
    SQL> <copy>explain plan for SELECT ordercount, COUNT(*) as custdist
        FROM (SELECT c.custid, COUNT(orderid) ordercount
        	   FROM customers c LEFT OUTER JOIN orders o
        	   ON c.custid = o.custid AND
        	   orderdate BETWEEN sysdate-4 AND sysdate GROUP BY c.custid)
        GROUP BY ordercount
        ORDER BY custdist desc, ordercount desc;</copy>  2    3    4    5    6    7  
    
    Explained.
    
    SQL> <copy>select * from table(dbms_xplan.display());</copy>
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    Plan hash value: 313106859
    
    ----------------------------------------------------------------------------------------------------------
    | Id  | Operation	     | Name		 | Rows  | Bytes | Cost (%CPU)| Time	 | Inst   |IN-OUT|
    ----------------------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT     |			 |     1 |    13 |     5  (20)| 00:00:01 |	  |	 |
    |   1 |  SORT ORDER BY	     |			 |     1 |    13 |     5  (20)| 00:00:01 |	  |	 |
    |   2 |   HASH GROUP BY      |			 |     1 |    13 |     5  (20)| 00:00:01 |	  |	 |
    |   3 |    VIEW 	     |			 |     1 |    13 |     5  (20)| 00:00:01 |	  |	 |
    |   4 |     HASH GROUP BY    |			 |     1 |    45 |     5  (20)| 00:00:01 |	  |	 |
    |   5 |      VIEW	     | VW_SHARD_28C476E6 |     1 |    45 |     5  (20)| 00:00:01 |	  |	 |
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
    |   6 |       SHARD ITERATOR |			 |	 |	 |	      | 	 |	  |	 |
    |   7 |        REMOTE	     |			 |	 |	 |	      | 	 | ORA_S~ | R->S |
    ----------------------------------------------------------------------------------------------------------
    
    Remote SQL Information (identified by operation id):
    ----------------------------------------------------
    
       7 - EXPLAIN PLAN INTO PLAN_TABLE@! FOR SELECT COUNT("A1"."ORDERID"),"A2"."CUSTID" FROM
           "CUSTOMERS" "A2","ORDERS" "A1" WHERE "A2"."CUSTID"="A1"."CUSTID"(+) AND
           "A1"."ORDERDATE"(+)>=CAST(SYSDATE@!-4 AS TIMESTAMP) AND "A1"."ORDERDATE"(+)<=CAST(SYSDATE@! AS
           TIMESTAMP) GROUP BY "A2"."CUSTID" /* coord_sql_id=92fs7p19a7pfy */  (accessing
    
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------------------------------------
           'ORA_SHARD_POOL.SUBNET.VCN.ORACLEVCN.COM@ORA_MULTI_TARGET' )
    
    
    Note
    -----
       - dynamic statistics used: dynamic sampling (level=2)
    
    28 rows selected.
    ```
    
    Then, run the query.
    
    ```
    SQL> <copy>SELECT ordercount, COUNT(*) as custdist
        FROM (SELECT c.custid, COUNT(orderid) ordercount
        	   FROM customers c LEFT OUTER JOIN orders o
        	   ON c.custid = o.custid AND
        	   orderdate BETWEEN sysdate-4 AND sysdate GROUP BY c.custid)
        GROUP BY ordercount
        ORDER BY custdist desc, ordercount desc;</copy>  2    3    4    5    6    7  
    
    ORDERCOUNT   CUSTDIST
    ---------- ----------
    	 1     132307
    	 2	51814
    	 3	22105
    	 4	10204
    	 5	 5082
    ......
    ......
    	66	    1
    	65	    1
    	63	    1
    	59	    1
    
    96 rows selected.
    
    SQL> 	 
    ```

   

7. Exit the sqlplus.

    ```
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.9.0.0.0
    [oracle@sdbsd0 ~]$ 
    ```

   

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Minqiao Wang, Jan 2021
* **Last Updated By/Date** - Minqiao Wang, Mar 2023