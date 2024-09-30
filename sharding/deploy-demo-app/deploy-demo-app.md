# Deploy the Demo Application

## Introduction

To learn more about Oracle Globally Distributed Database, download and deploy the system-managed shard demo application. The demo application uses the shard environment and schema you have just created to simulate the workload of an online retail store. 

Estimated Lab Time: 30 minutes.

### Objectives

In this lab, you will perform the following steps:
- Setup and Configure the sharding demo application
- Start the workload to load the demo data

### Prerequisites

This lab assumes you have already completed the following:
- Globally Distributed Database Deployment
- Create Demo Sample Schema

## **Task 1:** Setup and Configure the Sharding Demo Application

1. Login to the gsm host.

    ```
    $ ssh -i labkey opc@<gsmhost public ip>
    Activate the web console with: systemctl enable --now cockpit.socket
    
    Last login: Sun Aug 11 00:49:24 2024 from 222.129.1.52
    [opc@gsmhost ~]$ 
    ```
    
    Switch to oracle user.
    
    ```
    [opc@gsmhost ~]$ sudo su - oracle
    Last login: Sun Aug 11 00:49:28 GMT 2024 on pts/3
    [oracle@gsmhost ~]$ 
    ```

   

2. Download the `sdb_demo_app.zip`  file. 

    ```
    [oracle@gsmhost ~]$ wget https://github.com/minqiaowang/globally-distributed-database-with-raft/raw/main/deploy-demo-app/sdb_demo_app.zip
    ```

   

3. Unzip the file. This will create `sdb_demo_app` directory under the `/home/oracle`

    ```
    [oracle@gsmhost ~]$ unzip sdb_demo_app.zip
    ```

   

4. Change to the `sdb_demo_app/sql` directory.

    ```
    [oracle@gsmhost ~]$ cd ./sdb_demo_app/sql
    [oracle@gsmhost sql]$
    ```

   

5. View the content of the `demo_app_ext.sql`. Make sure the connect string is correct.

    ```
    [oracle@gsmhost sql]$ cat demo_app_ext.sql
    -- Create catalog monitor packages
    connect sys/WelcomePTS_2024#@catahost:1521/catapdb as sysdba
    @catalog_monitor.sql
    
    connect app_schema/App_Schema_Pass_123@catahost:1521/catapdb;
    
    alter session enable shard ddl;
    
    CREATE OR REPLACE VIEW SAMPLE_ORDERS AS
      SELECT OrderId, CustId, OrderDate, SumTotal FROM
        (SELECT * FROM ORDERS ORDER BY OrderId DESC)
          WHERE ROWNUM < 10;
    
    alter session disable shard ddl;
    
    -- Allow a special query for dbaview
    connect sys/WelcomePTS_2024#@catahost:1521/catapdb as sysdba
    
    -- For demo app purposes
    grant shard_monitor_role, gsmadmin_role to app_schema;
    
    alter session enable shard ddl;
    
    create user dbmonuser identified by TEZiPP4_MsLLL_1;
    grant connect, alter session, shard_monitor_role, gsmadmin_role to dbmonuser;
    
    grant all privileges on app_schema.products to dbmonuser;
    grant read on app_schema.sample_orders to dbmonuser;
    
    alter session disable shard ddl;
    -- End workaround
    
    exec dbms_global_views.create_any_view('SAMPLE_ORDERS', 'APP_SCHEMA.SAMPLE_ORDERS', 'GLOBAL_SAMPLE_ORDERS', 0, 1);
    ```

   

6. Connect to SQLPLUS

    ```
    [oracle@gsmhost sql]$ sqlplus /nolog
    
    SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sun Aug 11 01:53:22 2024
    Version 23.5.0.24.07
    
    Copyright (c) 1982, 2024, Oracle.  All rights reserved.
    
    SQL> 
    ```
    
7. Run the script. Make sure there is no error return. 

    ```
    SQL> @demo_app_ext.sql
    SQL> exit
    ```

    

8. Exit the sqlplus. Change directory to the `sdb_demo_app`.

    ```
    [oracle@gsmhost sql]$ cd ~/sdb_demo_app
    [oracle@gsmhost sdb_demo_app]$ 
    ```

   

9. View the `demo.properties` file, make sure it's like the following. 

    ```
    [oracle@gsmhost sdb_demo_app]$ cat demo.properties
    name=demo
    connect_string=(ADDRESS_LIST=(LOAD_BALANCE=off)(FAILOVER=on)(ADDRESS=(HOST=localhost)(PORT=1522)(PROTOCOL=tcp)))
    monitor.user=dbmonuser
    monitor.pass=TEZiPP4_MsLLL_1
    app.service.write=oltp_rw_svc.orasdb.oradbcloud
    #app.service.write=rw.orasdb.oradbcloud
    app.service.readonly=oltp_ro_svc.orasdb.oradbcloud
    #app.service.readonly=ro.orasdb.oradbcloud
    app.user=app_schema
    app.pass=App_Schema_Pass_123
    app.threads=7
    ```

   

   

## **Task 2:** Start the workload

1. Start the workload by executing command: `./run.sh demo`.

    ```
    [oracle@gsmhost sdb_demo_app]$ ./run.sh demo
    ```

   

2. The result likes the following.

    ```
    Performing initial fill of the products table...
    Syncing shards...
     RO Queries | RW Queries | RO Failed  | RW Failed  | APS 
              0            0            0            0            2
            223           32            0            0           69
           2483          386            0            0          762
           5860         1003            0            0         1143
           9769         1632            0            0         1338
          13868         2273            0            0         1375
          17755         2969            0            0         1321
          21525         3604            0            0         1283
          25555         4283            0            0         1371
          30065         4958            0            0         1545
          34781         5638            0            0         1614
          38837         6295            0            0         1402
          42698         6982            0            0         1315
          47105         7649            0            0         1517
          51284         8335            0            0         1421
          55114         9015            0            0         1303
          59265         9687            0            0         1427
          63319        10330            0            0         1400
          67034        10985            0            0         1285
    ```
    
3. Keep this app running

   

## Task 3: Working with RAFT High Availability

1. Open another terminal, connect to the gsm host,.

    ```
    $ ssh -i labkey opc@<gsmhost public ip>
    Activate the web console with: systemctl enable --now cockpit.socket
    
    Last login: Sun Aug 11 02:12:28 2024 from 222.129.1.52
    [opc@gsmhost ~]$ 
    ```
    
    Switch to oracle user.
    
    ```
    [opc@gsmhost ~]$ sudo su - oracle
    Last login: Sun Aug 11 02:12:35 GMT 2024 on pts/6
    [oracle@gsmhost ~]$ 
    ```
    
       
    
2. Connect to GDSCTL

   ```
   [oracle@gsmhost ~]$ gdsctl
   GDSCTL: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sun Aug 11 02:42:21 GMT 2024
   
   Copyright (c) 2011, 2024, Oracle.  All rights reserved.
   
   Welcome to GDSCTL, type "help" for information.
   
   Current GSM is set to SHARDDIRECTOR1
   GDSCTL> 
   ```
   
   
   
2. Show current RU

   ```
   GDSCTL> status ru
   Replication units
   ------------------------
   Catalog connection is established
   Database                      RU#  Role      Term Log Index Status       
   --------                      ---  ----      ---- --------- ------       
   sdb2_workshop_shard2          1    Follower  1    253648    Ok           
   sdb2_workshop_shard2          2    Leader    2    256193    Ok           
   sdb2_workshop_shard2          3    Follower  2    257854    Ok           
   sdb2_workshop_shard2          4    Follower  1    258642    Ok           
   sdb2_workshop_shard2          5    Leader    2    255395    Ok           
   sdb2_workshop_shard2          6    Follower  2    257924    Ok           
   sdb1_workshop_shard1          1    Leader    1    253648    Ok           
   sdb1_workshop_shard1          2    Follower  2    256193    Ok           
   sdb1_workshop_shard1          3    Follower  2    257854    Ok           
   sdb1_workshop_shard1          4    Leader    1    258642    Ok           
   sdb1_workshop_shard1          5    Follower  2    255395    Ok           
   sdb1_workshop_shard1          6    Follower  2    257924    Ok           
   sdb3_workshop_shard3          1    Follower  1    253648    Ok           
   sdb3_workshop_shard3          2    Follower  2    256193    Ok           
   sdb3_workshop_shard3          3    Leader    2    257854    Ok           
   sdb3_workshop_shard3          4    Follower  1    258642    Ok           
   sdb3_workshop_shard3          5    Follower  2    255395    Ok           
   sdb3_workshop_shard3          6    Leader    2    257924    Ok  
   ```
   
   
   
2. Show RU 1 status and related chunks

   ```
   GDSCTL> status ru -ru 1 -show_chunks
   Chunks
   ------------------------
   RU#                           From      To        
   ---                           ----      --        
   1                             1         3         
   
   Replication units
   ------------------------
   Database                      RU#  Role      Term Log Index Apply LogIdx LWM LogIdx On-disk LogIdx Status       
   --------                      ---  ----      ---- --------- ------------ ---------- -------------- ------       
   sdb2_workshop_shard2          1    Follower  1    253647    253648       253647     253648         Ok           
   sdb1_workshop_shard1          1    Leader    1    253647    0            0          253648         Ok           
   sdb3_workshop_shard3          1    Follower  1    253647    253648       253647     253648         Ok           
   ```
   
   
   
2. Exit the GDSCTL, and exit to **opc** user.

   ```
   GDSCTL> exit
   [oracle@gsmhost ~]$ exit
   [opc@gsmhost ~]$ 
   ```
   
   
   
2. Now, connect to the shard host1 with **opc** user and switch to **oracle** user.

   ```
   [opc@gsmhost ~]$ ssh -i labkey opc@shardhost1
   Last login: Tue Aug 13 02:44:40 2024 from 10.0.0.20
   [opc@shardhost1 ~]$ sudo su - oracle
   Last login: Tue Aug 13 02:48:21 UTC 2024
   [oracle@shardhost1 ~]$ 
   ```
   
   
   
2. Connect to SQLPLUS as sysdba and shutdown the database

   ```
   [oracle@shardhost1 ~]$ sqlplus / as sysdba
   
   SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Tue Aug 13 02:49:23 2024
   Version 23.5.0.24.07
   
   Copyright (c) 1982, 2024, Oracle.  All rights reserved.
   
   
   Connected to:
   Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
   Version 23.5.0.24.07
   
   SQL> shutdown immediate
   Database closed.
   Database dismounted.
   ORACLE instance shut down.
   SQL> 
   ```
   
   
   
2. You can see the apps still running with some error

   ```
   RO Queries | RW Queries | RO Failed  | RW Failed  | APS 
        501580        88693            0            0         1258
        504605        89248            0            0         1279
        507215        89703            0            0         1123
        509813        90146            0            0         1095
        512664        90603            0            0         1223
        515241        91092            0            0         1127
        518779        91716            0            0         1542
        522263        92357            0            0         1503
        525993        92989            0            0         1604
        529690        93641            0            0         1562
   ```
   
   
   
2. Keep App running. In the terminal 2, Exit to the gsmhost, connect to GDSCTL

   ```
   [oracle@gsmhost ~]$ gdsctl
   GDSCTL: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sun Aug 11 02:54:19 GMT 2024
   
   Copyright (c) 2011, 2024, Oracle.  All rights reserved.
   
   Welcome to GDSCTL, type "help" for information.
   
   Current GSM is set to SHARDDIRECTOR1
   GDSCTL> 
   ```
   
   
   
2. check the status of the RU, there is no shard1.

   ```
   GDSCTL> status ru
   Replication units
   ------------------------
   Catalog connection is established
   Database                      RU#  Role      Term Log Index Status       
   --------                      ---  ----      ---- --------- ------       
   sdb2_workshop_shard2          1    Leader    2    425816    Ok           
   sdb2_workshop_shard2          2    Leader    2    430689    Ok           
   sdb2_workshop_shard2          3    Follower  2    435821    Ok           
   sdb2_workshop_shard2          4    Follower  2    433249    Ok           
   sdb2_workshop_shard2          5    Leader    2    431403    Ok           
   sdb2_workshop_shard2          6    Follower  2    435903    Ok           
   sdb3_workshop_shard3          1    Follower  2    425816    Ok           
   sdb3_workshop_shard3          2    Follower  2    430697    Ok           
   sdb3_workshop_shard3          3    Leader    2    435821    Ok           
   sdb3_workshop_shard3          4    Leader    2    433254    Ok           
   sdb3_workshop_shard3          5    Follower  2    431403    Ok           
   sdb3_workshop_shard3          6    Leader    2    435918    Ok  
   ```
   
   
   
2. Check the ru 1 and related chunks, you can see the ru leader is change to shard2.

   ```
   GDSCTL> status ru -ru 1 -show_chunks
   Chunks
   ------------------------
   RU#                           From      To        
   ---                           ----      --        
   1                             1         3         
   
   Replication units
   ------------------------
   Database                      RU#  Role      Term Log Index Apply LogIdx LWM LogIdx On-disk LogIdx Status       
   --------                      ---  ----      ---- --------- ------------ ---------- -------------- ------       
   sdb3_workshop_shard3          1    Follower  2    453131    453065       453110     453131         Ok           
   sdb2_workshop_shard2          1    Leader    2    453131    253648       253647     453131         Ok    
   ```
   
   
   
2. exit to gsmhost **opc** user, connect to the shardhost1

   ```
   [opc@gsmhost ~]$ ssh -i labkey opc@shardhost1
   Last failed login: Sun Aug 11 02:58:29 UTC 2024 from 10.0.0.20 on ssh:notty
   There were 4 failed login attempts since the last successful login.
   Last login: Sat Aug 10 13:12:02 2024 from 10.0.0.20
   [opc@shardhost1 ~]$ 
   ```
   
   
   
2. Switch to **oracle** user

   ```
   [opc@shardhost1 ~]$ sudo su - oracle
   Last login: Sun Aug 11 03:00:00 UTC 2024
   [oracle@shardhost1 ~]$ 
   ```
   
   
   
2. Connect to SQLPLUS and start up the database

   ```
   [oracle@shardhost1 ~]$ sqlplus / as sysdba
   
   SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sun Aug 11 03:00:48 2024
   Version 23.5.0.24.07
   
   Copyright (c) 1982, 2024, Oracle.  All rights reserved.
   
   Connected to an idle instance.
   
   SQL> startup
   ORACLE instance started.
   
   Total System Global Area 1.5545E+10 bytes
   Fixed Size		    5378648 bytes
   Variable Size		 2516582400 bytes
   Database Buffers	 1.2885E+10 bytes
   Redo Buffers		  138514432 bytes
   Database mounted.
   Database opened.
   SQL> 
   ```
   
   
   
2. Exit back to gsmhost and switch to **oracle** user

   ```
   [opc@gsmhost ~]$ sudo su - oracle
   Last login: Sun Aug 11 02:54:15 GMT 2024 on pts/8
   [oracle@gsmhost ~]$ 
   ```
   
   
   
2. Connect to GDSCTL

   ```
   [oracle@gsmhost ~]$ gdsctl
   GDSCTL: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Sun Aug 11 03:02:59 GMT 2024
   
   Copyright (c) 2011, 2024, Oracle.  All rights reserved.
   
   Welcome to GDSCTL, type "help" for information.
   
   Current GSM is set to SHARDDIRECTOR1
   GDSCTL> 
   ```
   
   
   
2. check current RU status, you can see all the RUs in shard1 is follower.

   ```
   GDSCTL> status ru
   Replication units
   ------------------------
   Database                      RU#  Role      Term Log Index Status       
   --------                      ---  ----      ---- --------- ------       
   sdb2_workshop_shard2          1    Leader    2    767794    Ok           
   sdb2_workshop_shard2          2    Leader    2    772185    Ok           
   sdb2_workshop_shard2          3    Follower  2    781839    Ok           
   sdb2_workshop_shard2          4    Follower  2    775976    Ok           
   sdb2_workshop_shard2          5    Leader    2    774351    Ok           
   sdb2_workshop_shard2          6    Follower  2    780455    Ok           
   sdb1_workshop_shard1          6    Follower  2    780455    Ok           
   sdb1_workshop_shard1          1    Follower  2    767794    Ok           
   sdb1_workshop_shard1          2    Follower  2    772190    Ok           
   sdb1_workshop_shard1          4    Follower  2    775989    Ok           
   sdb1_workshop_shard1          5    Follower  2    774364    Ok           
   sdb1_workshop_shard1          3    Follower  2    781844    Ok           
   sdb3_workshop_shard3          1    Follower  2    767794    Ok           
   sdb3_workshop_shard3          2    Follower  2    772202    Ok           
   sdb3_workshop_shard3          3    Leader    2    781844    Ok           
   sdb3_workshop_shard3          4    Leader    2    775991    Ok           
   sdb3_workshop_shard3          5    Follower  2    774371    Ok           
   sdb3_workshop_shard3          6    Leader    2    780455    Ok           
   ```
   
   
   
2. Check the RU1 and related chunks

   ```
   GDSCTL> status ru -ru 1 -show_chunks
   Chunks
   ------------------------
   RU#                           From      To        
   ---                           ----      --        
   1                             1         3         
   
   Replication units
   ------------------------
   Database                      RU#  Role      Term Log Index Apply LogIdx LWM LogIdx On-disk LogIdx Status       
   --------                      ---  ----      ---- --------- ------------ ---------- -------------- ------       
   sdb2_workshop_shard2          1    Leader    2    724867    253648       253647     724867         Ok           
   sdb3_workshop_shard3          1    Follower  2    724875    724855       724875     724875         Ok           
   sdb1_workshop_shard1          1    Follower  2    724880    724695       724880     724880         Ok           
   GDSCTL> 
   ```
   
   
   
2. Rebalance the RUs

   ```
   GDSCTL> switchover ru -rebalance
   The operation completed successfully
   ```
   
   
   
2. check the RU status again, You can see the shard1 have become some RUs leader.

   ```
   GDSCTL> status ru
   Replication units
   ------------------------
   Database                      RU#  Role      Term Log Index Status       
   --------                      ---  ----      ---- --------- ------       
   sdb2_workshop_shard2          1    Follower  3    843836    Ok           
   sdb2_workshop_shard2          2    Leader    2    848627    Ok           
   sdb2_workshop_shard2          3    Follower  2    860722    Ok           
   sdb2_workshop_shard2          4    Follower  3    854545    Ok           
   sdb2_workshop_shard2          5    Leader    2    848261    Ok           
   sdb2_workshop_shard2          6    Follower  2    858873    Ok           
   sdb3_workshop_shard3          1    Follower  3    843836    Ok           
   sdb3_workshop_shard3          2    Follower  2    848637    Ok           
   sdb3_workshop_shard3          3    Leader    2    860722    Ok           
   sdb3_workshop_shard3          4    Follower  3    854552    Ok           
   sdb3_workshop_shard3          5    Follower  2    848261    Ok           
   sdb3_workshop_shard3          6    Leader    2    858878    Ok           
   sdb1_workshop_shard1          6    Follower  2    858886    Ok           
   sdb1_workshop_shard1          1    Leader    3    843843    Ok           
   sdb1_workshop_shard1          2    Follower  2    848637    Ok           
   sdb1_workshop_shard1          4    Leader    3    854552    Ok           
   sdb1_workshop_shard1          5    Follower  2    848261    Ok           
   sdb1_workshop_shard1          3    Follower  2    860722    Ok
   ```
   
   
   
2. During this time, the application still running, and maybe some errors.

   ```
   RO Queries | RW Queries | RO Failed  | RW Failed  | APS 
       4204870       766917            3            3         1693
       4208261       767555            3            3         1614
       4211605       768185            3            3         1647
       4215169       768847            3            3         1706
       4218724       769482            3            3         1712
       4222272       770131            3            3         1695
       4225985       770808            3            3         1783
       4229450       771464            3            3         1670
       4232758       772140            3            3         1586
       4235236       772618            3            3         1195
       4238737       773241            3            3         1727
       4242125       773851            3            3         1622
       4245427       774429            3            3         1636
       4248504       774996            3            3         1518
       4251696       775610            3            3         1587
   ```
   
   
   
2. Press `Control+C` to exist the application.

   ​     

## Acknowledgements
* **Author** - Minqiao Wang, Aug 2024
* **Last Updated By/Date** - 