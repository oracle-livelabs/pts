# Testing with Active Data Guard And Perform Switchover

## Introduction
In this lab, You can run some testing with the ADG and Perform a Switchover.

Estimated Time: 40 minutes

### Objectives

- Test transaction replication
- Check lag between the primary and standby
- Switchover to the standby

### Prerequisites

This lab assumes you have already completed the following labs:

- Deploy Active Data Guard

## **Task 1:** Test Transaction Replication

1. Connect the primary side with **oracle** user, create a test user in orclpdb, and grant privileges to the user. You need open the pdb if it is closed.

    ```
    [oracle@primary ~]$ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 06:52:50 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
    	 2 PDB$SEED			  READ ONLY  NO
    	 3 ORCLPDB			  MOUNTED
    
    SQL> <copy>alter pluggable database all open;</copy>
    
    Pluggable database altered.
    
    SQL> <copy>alter session set container=orclpdb;</copy>
    
    Session altered.
    
    SQL> <copy>create user testuser identified by testuser;</copy>
    
    User created.
    
    SQL> <copy>grant connect,resource to testuser;</copy>
    
    Grant succeeded.
    
    SQL> <copy>alter user testuser quota unlimited on users;</copy>
    
    User altered.
    
    SQL> <copy>exit;</copy>
    ```

2. Connect with **testuser**, create a test table and insert a test record.

    ```
    [oracle@primary ~]$ <copy>sqlplus testuser/testuser@localhost:1521/orclpdb</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 06:59:56 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>create table test(a number,b varchar2(20));</copy>
    
    Table created.
    SQL> <copy>insert into test values(1,'line1');</copy>
    
    1 row created.
    
    SQL> <copy>commit;</copy>
    
    Commit complete.
    
    SQL>  
    ```

3. From the standby side, open the standby database as read only.

    ```
    [oracle@standby ~]$ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 07:04:39 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>select open_mode,database_role from v$database;</copy>
    
    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    MOUNTED 	     PHYSICAL STANDBY
    
    SQL> <copy>alter database open;</copy>
    
    Database altered.
    
    SQL> <copy>alter pluggable database orclpdb open;</copy>
    
    Pluggable database altered.
    
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
    	 2 PDB$SEED			  READ ONLY  NO
    	 3 ORCLPDB			  READ ONLY  NO
    	 
    SQL> <copy>select open_mode,database_role from v$database;</copy>
    
    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY
    
    SQL> <copy>exit</copy>
    Disconnected from Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    [oracle@dbstby ~]$ 
    ```
If the `OPEN_MODE` is **READ ONLY**, you can run the following command in sqlplus as sysdba, then check the `open_mode` again, you can see the `OPEN_MODE` is **READ ONLY WITH APPLY** now.
    ```
    SQL> <copy>alter database recover managed standby database cancel;</copy>
    
    Database altered.
    
    SQL> <copy>alter database recover managed standby database using current logfile disconnect;</copy>
    
    Database altered.
    
    SQL> <copy>select open_mode,database_role from v$database;</copy>
    
    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY
    ```

4. From the standby side, connect as **testuser** to orclpdb. Check if the test table and record has replicated to the standby.

    ```
    [oracle@standby ~]$ <copy>sqlplus testuser/testuser@localhost:1521/orclpdb</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 07:09:27 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Feb 01 2020 06:59:56 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>select * from test;</copy>
    
    	 A B
    ---------- --------------------
    	 1 line1
    
    SQL> 
    ```

## **Task 2:** Check Lag Between Primary And Standby

There are several ways to check the lag between the primary and standby.

1. First let's prepare a sample workload in the primary side. Copy the following command:

    ```
    <copy>
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/workload.sh
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/scn.sql
    </copy>
    ```

   

2. From primary side, run as **oracle** user, download scripts using the command you copied.

    ```
    [oracle@primary ~]$ wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/workload.sh
    --2020-10-31 02:48:08--  https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/workload.sh
    Resolving objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1. oraclecloud.com)... 134.70.31.247, 134.70.27.247, 134.70.35.189
    Connecting to objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1. oraclecloud.com)|134.70.31.247|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 1442 (1.4K) [text/x-sh]
    Saving to: ‘workload.sh’
    
    100%[==============================================>] 1,442       --.-K/s   in 0s      
    
    2020-10-31 02:48:09 (10.5 MB/s) - ‘workload.sh’ saved [1442/1442]
    
    [oracle@primary ~]$ wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/scn.sql
    --2020-10-31 02:48:29--  https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/scn.sql
    Resolving objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1. oraclecloud.com)... 134.70.35.189, 134.70.31.247, 134.70.27.247
    Connecting to objectstorage.us-ashburn-1.oraclecloud.com (objectstorage.us-ashburn-1. oraclecloud.com)|134.70.35.189|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 108 [application/octet-stream]
    Saving to: ‘scn.sql’
    
    100%[==============================================>] 108         --.-K/s   in 0s      
    
    2020-10-31 02:48:30 (8.08 MB/s) - ‘scn.sql’ saved [108/108]
    
    [oracle@primary ~]$  
    ```

   

3. Change mode of the `workload.sh` file and run the workload. Ignore the error message of drop table. Keep this window open and running for the next few Task s in this lab.

    ```
    [oracle@primary ~]$ <copy>chmod a+x workload.sh</copy> 
    [oracle@primary ~]$ <copy>. ./workload.sh</copy> 
    
      NOTE:
      To break out of this batch
      job, please issue CTL-C 
    
    ...sleeping 5 seconds
    
      drop table sale_orders
                 *
    ERROR at line 1:
    ORA-00942: table or view does not exist
    
    
    
    Table created.
    
    
    10 rows created.
    
    
    Commit complete.
    
    
      COUNT(*)
    ----------
    	10
    
    
    CURRENT_SCN TIME
    ----------- ---------------
        2814533 20200905-092831
    
    
    10 rows created.
    
    
    Commit complete.
    
    
      COUNT(*)
    ----------
    	20
    
    
    CURRENT_SCN TIME
    ----------- ---------------
        2814548 20200905-092833
        
    ```

   

4. From the standby side, connect as **testuser** to orclpdb, count the records in the sample table several times. Compare the record number with the primary side.

    ```
    [oracle@standby ~]$ <copy>sqlplus testuser/testuser@standby:1521/orclpdb</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Sep 5 09:41:29 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2020, Oracle.  All rights reserved.
    
    Last Successful login time: Sat Sep 05 2020 02:09:45 +00:00
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>select count(*) from sale_orders;</copy>
    
      COUNT(*)
    ----------
    	390
    
    SQL> 
    ```

    

5. From standby site, connect as sysdba. Check the Oracle System Change Number (SCN). Compare it with the primary side.

    ```
    SQL> <copy>connect / as sysdba</copy>
    Connected.
    SQL> <copy>SELECT current_scn FROM v$database;</copy>
    
    CURRENT_SCN
    -----------
        2784330
    ```

   

6. From standby site, query the `v$dataguard_stats` view to check the lag.

    ```
    SQL> <copy>set linesize 120;</copy>
    SQL> <copy>column name format a25;</copy>
    SQL> <copy>column value format a20;</copy>
    SQL> <copy>column time_computed format a20;</copy>
    SQL> <copy>column datum_time format a20;</copy>
    SQL> <copy>select name, value, time_computed, datum_time from v$dataguard_stats;</copy>
    
    NAME			                VALUE 	             TIME_COMPUTED	      DATUM_TIME
    ------------------------- -------------------- -------------------- --------------------
    transport lag		          +00 00:00:00	       09/05/2020 07:17:33  09/05/2020 07:17:30
    apply lag		              +00 00:00:00	       09/05/2020 07:17:33  09/05/2020 07:17:30
    apply finish time	        +00 00:00:00.000     09/05/2020 07:17:33
    estimated startup time	  9		                 09/05/2020 07:17:33
    
    SQL> 
    ```

   

7. Check lag using Data Guard Broker.

    ```
    [oracle@standby ~]$ <copy>dgmgrl sys/Ora_DB4U@orcl</copy>
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Sep 5 07:25:52 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.
    
    Welcome to DGMGRL, type "help" for information.
    Connected to "ORCL"
    Connected as SYSDBA.
    DGMGRL> <copy>show database ORCLSTBY</copy>
    
    Database - orclstby
    
      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 3 seconds ago)
      Apply Lag:          0 seconds (computed 3 seconds ago)
      Average Apply Rate: 6.00 KByte/s
      Real Time Query:    ON
      Instance(s):
        ORCL
    
    Database Status:
    SUCCESS
    
    DGMGRL> 
    ```
   
8. From the on-premise side, press `Ctrl-C` to terminate the running workload.




## **Task 3:** Switchover To Standby 

At any time, you can manually execute a Data Guard switchover (planned event) or failover (unplanned event). Customers may also choose to automate Data Guard failover by configuring Fast-Start failover. Switchover and failover reverse the roles of the databases in a Data Guard configuration – the standby database becomes primary and the original primary becomes the standby database. Refer to Oracle MAA Best Practices for additional information on Data Guard role transitions. 

Switchovers are always a planned event that guarantees no data is lost. To execute a switchover, perform the following in Data Guard Broker 

1. Connect DGMGRL from the primary side, validate the standby database to see if Ready For Switchover is Yes. 

    ```
    [oracle@primary ~]$ <copy>dgmgrl sys/Ora_DB4U@orcl</copy>
    DGMGRL for Linux: Release 19.0.0.0.0 - Production on Sat Feb 1 07:21:55 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle and/or its affiliates.  All rights reserved.
    
    Welcome to DGMGRL, type "help" for information.
    Connected to "ORCL"
    Connected as SYSDBA.
    DGMGRL> <copy>validate database ORCLSTBY</copy>
    
      Database Role:     Physical standby database
      Primary Database:  orcl
    
      Ready for Switchover:  Yes
      Ready for Failover:    Yes (Primary Running)
    
      Flashback Database Status:
        orcl    :  On
        orclstby:  Off
    
      Managed by Clusterware:
        orcl    :  NO             
        orclstby:  NO             
        Validating static connect identifier for the primary database orcl...
        The static connect identifier allows for a connection to database "orcl".
    
    DGMGRL> 
    ```

2. Switch over to the standby database.

    ```
    DGMGRL> <copy>switchover to orclstby</copy>
    Performing switchover NOW, please wait...
    Operation requires a connection to database "orclstby"
    Connecting ...
    Connected to "ORCLSTBY"
    Connected as SYSDBA.
    New primary database "orclstby" is opening...
    Operation requires start up of instance "ORCL" on database "orcl"
    Starting instance "ORCL"...
    Connected to an idle instance.
    ORACLE instance started.
    Connected to "ORCL"
    Database mounted.
    Database opened.
    Connected to "ORCL"
    Switchover succeeded, new primary is "orclstby"
    DGMGRL> <copy>show configuration</copy>
    
    Configuration - adgconfig
    
      Protection Mode: MaxPerformance
      Members:
      orclstby - Primary database
        orcl     - Physical standby database 
    
    Fast-Start Failover:  Disabled
    
    Configuration Status:
    SUCCESS   (status updated 65 seconds ago)
    
    DGMGRL> <copy>exit</copy>
    ```

3. Check from the original primary side. You can see the previous primary side becomes the new standby side.

    ```
    [oracle@primary ~]$ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 10:16:54 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
    	 2 PDB$SEED			  READ ONLY  NO
    	 3 ORCLPDB			  READ ONLY  NO
    SQL> <copy>select open_mode,database_role from v$database;</copy>
    
    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ ONLY WITH APPLY PHYSICAL STANDBY
    
    SQL> 
    ```

4. Check from the original standby side. You can see it's becomes the new primary side.

    ```
    [oracle@standby ~]$ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 19.0.0.0.0 - Production on Sat Feb 1 10:20:06 2020
    Version 19.10.0.0.0
    
    Copyright (c) 1982, 2019, Oracle.  All rights reserved.
    
    
    Connected to:
    Oracle Database 19c EE Extreme Perf Release 19.0.0.0.0 - Production
    Version 19.10.0.0.0
    
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
    	 2 PDB$SEED			  READ ONLY  NO
    	 3 ORCLPDB			  READ WRITE NO
    SQL> <copy>select open_mode,database_role from v$database;</copy>
    
    OPEN_MODE	     DATABASE_ROLE
    -------------------- ----------------
    READ WRITE	     PRIMARY
    
    SQL> 
    ```

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Minqiao Wang, Oct 2020 
* **Last Updated By/Date** - Minqiao Wang, Oct 2021

