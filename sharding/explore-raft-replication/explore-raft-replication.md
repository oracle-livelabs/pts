# Explore the RAFT replication Features

## Introduction

In this lab, you will explare the RAFT replication features

Estimated Lab Time: 30 minutes.

### Objectives

In this lab, you will perform the following steps:

- Check the current RAFT replication configure
- RAFT Replication Failover
- Manager the RAFT RU

### Prerequisites

This lab assumes you have already completed the following:

- Globally Distributed Database Deployment
- Create Demo Sample Schema

## **Task 1:** Explore RAFT Replication Configure

1.   Log into gsmhost , switch to **oracle** user

     ```
     $ <copy>ssh -i labkey opc@<gsmhost_public_ip></copy>
     Activate the web console with: systemctl enable --now cockpit.socket
     
     Last login: Mon Aug 12 03:23:12 2024 from 202.45.129.202
     
     [opc@gsmhost ~]$ <copy>sudo su - oracle</copy>
     Last login: Mon Aug 12 03:22:49 GMT 2024 on pts/0
     [oracle@gsmhost ~]$ 
     ```

     

2.   Connect to  GDSCLT

     ```
     [oracle@gsmhost ~]$ <copy>gdsctl</copy>
     GDSCTL: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Mon Aug 12 05:47:43 GMT 2024
     
     Copyright (c) 2011, 2024, Oracle.  All rights reserved.
     
     Welcome to GDSCTL, type "help" for information.
     
     Current GSM is set to SHARDDIRECTOR1
     GDSCTL> 
     ```

     

3.   Check current status of RU

     ```
     GDSCTL> <copy>status ru</copy>
     Replication units
     ------------------------
     Catalog connection is established
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb1_workshop_shard1          1    Leader    1    9         Ok           
     sdb1_workshop_shard1          2    Follower  2    2         Ok           
     sdb1_workshop_shard1          3    Follower  2    2         Ok           
     sdb1_workshop_shard1          4    Leader    1    9         Ok           
     sdb1_workshop_shard1          5    Follower  2    2         Ok           
     sdb1_workshop_shard1          6    Follower  2    2         Ok           
     sdb2_workshop_shard2          1    Follower  1    1         Ok           
     sdb3_workshop_shard3          1    Follower  1    1         Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb2_workshop_shard2          4    Follower  1    1         Ok           
     sdb3_workshop_shard3          4    Follower  1    1         Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok   
     ```

     

4.   Check the RU 1 status

     ```
     GDSCTL> <copy>status ru -ru 1</copy>
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Apply LogIdx LWM LogIdx On-disk LogIdx Status       
     --------                      ---  ----      ---- --------- ------------ ---------- -------------- ------       
     sdb1_workshop_shard1          1    Leader    1    1         0            0          9              Ok           
     sdb2_workshop_shard2          1    Follower  1    1         0            0          1              Ok           
     sdb3_workshop_shard3          1    Follower  1    1         0            0          1              Ok           
     ```

     

5.   Show chunk distribution across all replication units.

     ```
     GDSCTL> <copy>status ru -show_chunks</copy>
     Chunks
     ------------------------
     RU#                           From      To        
     ---                           ----      --        
     1                             1         3         
     2                             4         6         
     3                             7         9         
     4                             10        12        
     5                             13        15        
     6                             16        18        
     
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb1_workshop_shard1          6    Follower  2    10        Ok           
     sdb1_workshop_shard1          1    Leader    3    11        Ok           
     sdb1_workshop_shard1          2    Follower  2    10        Ok           
     sdb1_workshop_shard1          4    Leader    3    11        Ok           
     sdb1_workshop_shard1          5    Follower  2    10        Ok           
     sdb1_workshop_shard1          3    Follower  2    10        Ok           
     sdb2_workshop_shard2          1    Follower  3    11        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb2_workshop_shard2          4    Follower  3    11        Ok           
     sdb3_workshop_shard3          1    Follower  3    11        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Follower  3    11        Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok    
     ```

     

6.   Only check the RU leaders information .

     ```
     GDSCTL> <copy>status ru -leaders</copy>
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb1_workshop_shard1          1    Leader    1    9         Ok           
     sdb1_workshop_shard1          4    Leader    1    9         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     ```

     

     

## RAFT Replication Failover

1.   Open antoher terminal, from gsmhost **opc** user, connec to the shardhost1

     ```
     [opc@gsmhost ~]$ <copy>ssh -i labkey opc@shardhost1</copy>
     Last login: Sun Aug 11 13:14:07 2024 from 10.0.0.20
     [opc@shardhost1 ~]$ 
     ```

     

2.   Switch to **oracle** user

     ```
     [opc@shardhost1 ~]$ <copy>sudo su - oracle</copy>
     Last login: Mon Aug 12 23:25:17 UTC 2024
     [oracle@shardhost1 ~]$ 
     ```

     

3.   Connect to SQLPLUS as sysdba

     ```
     [oracle@shardhost1 ~]$ <copy>sqlplus / as sysdba</copy>
     
     SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Mon Aug 12 23:26:51 2024
     Version 23.5.0.24.07
     
     Copyright (c) 1982, 2024, Oracle.  All rights reserved.
     
     
     Connected to:
     Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
     Version 23.5.0.24.07
     
     SQL> 
     ```

     

4.   Shutdown the database

     ```
     SQL> <copy>shutdown immediate</copy>
     Database closed.
     Database dismounted.
     ORACLE instance shut down.
     SQL> 
     ```

     

5.   From the first terminal connected with GDSCTL, check the status of RU

     ```
     GDSCTL> <copy>status ru</copy>
     Replication units
     ------------------------
     Catalog connection is established
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb2_workshop_shard2          1    Leader    2    10        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb2_workshop_shard2          4    Follower  2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok           
     sdb3_workshop_shard3          1    Follower  2    10        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Leader    2    10        Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     ```

     

6.   Check only the RU leaders

     ```
     GDSCTL> <copy>status ru -leaders</copy>
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Leader    2    10        Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb2_workshop_shard2          1    Leader    2    10        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok 
     ```

     

7.   From the second terminal, startup the database

     ```
     SQL> <copy>startup</copy>
     ORACLE instance started.
     
     Total System Global Area 1.5545E+10 bytes
     Fixed Size		    5378648 bytes
     Variable Size		 2147483648 bytes
     Database Buffers	 1.3254E+10 bytes
     Redo Buffers		  138514432 bytes
     Database mounted.
     Database opened.
     SQL> 
     ```

     

8.   From the first terminal, check the RU status, you can see all the RUs in shard1 are followers.

     ```
     GDSCTL> <copy>status ru</copy>
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb3_workshop_shard3          1    Follower  2    10        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Leader    2    10        Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb2_workshop_shard2          1    Leader    2    10        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb2_workshop_shard2          4    Follower  2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok           
     sdb1_workshop_shard1          6    Follower  2    10        Ok           
     sdb1_workshop_shard1          1    Follower  2    10        Ok           
     sdb1_workshop_shard1          2    Follower  2    10        Ok           
     sdb1_workshop_shard1          4    Follower  2    10        Ok           
     sdb1_workshop_shard1          5    Follower  2    10        Ok           
     sdb1_workshop_shard1          3    Follower  2    10        Ok 
     ```

     

9.   Rebalance the RU

     ```
     GDSCTL> <copy>switchover ru -rebalance</copy>
     The operation completed successfully
     ```

     

10.   Check the RUs status again,  you can see the RUs Leaders are balanced between the 3 shards.

      ```
      GDSCTL> <copy>status ru</copy>
      Replication units
      ------------------------
      Database                      RU#  Role      Term Log Index Status       
      --------                      ---  ----      ---- --------- ------       
      sdb3_workshop_shard3          1    Follower  3    11        Ok           
      sdb2_workshop_shard2          1    Follower  3    11        Ok           
      sdb2_workshop_shard2          2    Leader    2    10        Ok           
      sdb2_workshop_shard2          3    Follower  2    2         Ok           
      sdb2_workshop_shard2          4    Follower  3    11        Ok           
      sdb3_workshop_shard3          2    Follower  2    2         Ok           
      sdb2_workshop_shard2          5    Leader    2    10        Ok           
      sdb3_workshop_shard3          3    Leader    2    10        Ok           
      sdb2_workshop_shard2          6    Follower  2    2         Ok           
      sdb3_workshop_shard3          4    Follower  3    11        Ok           
      sdb3_workshop_shard3          5    Follower  2    2         Ok           
      sdb3_workshop_shard3          6    Leader    2    10        Ok           
      sdb1_workshop_shard1          6    Follower  2    10        Ok           
      sdb1_workshop_shard1          1    Leader    3    11        Ok           
      sdb1_workshop_shard1          2    Follower  2    10        Ok           
      sdb1_workshop_shard1          4    Leader    3    11        Ok           
      sdb1_workshop_shard1          5    Follower  2    10        Ok           
      sdb1_workshop_shard1          3    Follower  2    10        Ok  
      ```

      



## Manager the RAFT Replication RU

1.   From GDSCTL, check current RU Leaders

     ```
     GDSCTL> <copy>status ru -leaders</copy>
     Replication units
     ------------------------
     Catalog connection is established
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb1_workshop_shard1          1    Leader    3    11        Ok           
     sdb1_workshop_shard1          4    Leader    3    11        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok 
     ```

     

2.   Change leader of RU1 to shard2

     ```
     GDSCTL> <copy>switchover ru -ru 1 -shard sdb2_workshop_shard2</copy>
     Switchover process has been started
     Switchover process completed
     The operation completed successfully
     ```

     

3.   Show current leaders

     ```
     GDSCTL> <copy>status ru -leaders</copy>
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb2_workshop_shard2          1    Leader    4    12        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb1_workshop_shard1          4    Leader    3    11        Ok  
     ```

     

4.   Change back the leader

     ```
     GDSCTL> <copy>switchover ru -ru 1 -shard sdb1_workshop_shard1</copy>
     Switchover process has been started
     Switchover process completed
     The operation completed successfully
     ```

     

5.   To use RELOCATE CHUNK, the source and target replication unit leaders must be located on the same shard, and their followers must also be on the same shards. If they are not on the same shard, use SWITCHOVER RU to move the leader and MOVE RU to move the followers to co-located shards. Check current chunks status. You can see the chunks 1-3 in RU1 and chunks 10-12 in RU4, the leaders are in the same shard1, and the followers in shard2 and shard3.

     ```
     GDSCTL> <copy>status ru -show_chunks</copy>
     Chunks
     ------------------------
     RU#                           From      To        
     ---                           ----      --        
     1                             1         3         
     2                             4         6         
     3                             7         9         
     4                             10        12        
     5                             13        15        
     6                             16        18        
     
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb2_workshop_shard2          1    Follower  5    13        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb2_workshop_shard2          4    Follower  3    11        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok           
     sdb3_workshop_shard3          1    Follower  5    13        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Follower  3    11        Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb1_workshop_shard1          6    Follower  2    10        Ok           
     sdb1_workshop_shard1          1    Leader    5    13        Ok           
     sdb1_workshop_shard1          2    Follower  2    10        Ok           
     sdb1_workshop_shard1          4    Leader    3    11        Ok           
     sdb1_workshop_shard1          5    Follower  2    10        Ok           
     sdb1_workshop_shard1          3    Follower  2    10        Ok 
     ```

     

6.   Relocate Chunk 3 from RU1 to RU4

     ```
     GDSCTL> <copy>relocate chunk -chunk 3 -sourceru 1 -targetru 4</copy>
     The operation completed successfully
     ```

     

7.   Show current status of the chunks

     ```
     GDSCTL> <copy>status ru -show_chunks</copy>
     Chunks
     ------------------------
     RU#                           From      To        
     ---                           ----      --        
     1                             1         2         
     2                             4         6         
     3                             7         9         
     4                             3         3         
     4                             10        12        
     5                             13        15        
     6                             16        18        
     
     Replication units
     ------------------------
     Database                      RU#  Role      Term Log Index Status       
     --------                      ---  ----      ---- --------- ------       
     sdb1_workshop_shard1          6    Follower  2    10        Ok           
     sdb1_workshop_shard1          1    Leader    5    15        Ok           
     sdb1_workshop_shard1          2    Follower  2    10        Ok           
     sdb1_workshop_shard1          4    Leader    3    12        Ok           
     sdb1_workshop_shard1          5    Follower  2    10        Ok           
     sdb1_workshop_shard1          3    Follower  2    10        Ok           
     sdb3_workshop_shard3          1    Follower  5    15        Ok           
     sdb3_workshop_shard3          2    Follower  2    2         Ok           
     sdb3_workshop_shard3          3    Leader    2    10        Ok           
     sdb3_workshop_shard3          4    Follower  3    11        Ok           
     sdb3_workshop_shard3          5    Follower  2    2         Ok           
     sdb3_workshop_shard3          6    Leader    2    10        Ok           
     sdb2_workshop_shard2          1    Follower  5    15        Ok           
     sdb2_workshop_shard2          2    Leader    2    10        Ok           
     sdb2_workshop_shard2          3    Follower  2    2         Ok           
     sdb2_workshop_shard2          4    Follower  3    11        Ok           
     sdb2_workshop_shard2          5    Leader    2    10        Ok           
     sdb2_workshop_shard2          6    Follower  2    2         Ok 
     ```

     

8.   Move back the chunk.

     ```
     GDSCTL> <copy>relocate chunk -chunk 3 -sourceru 4 -targetru 1</copy>
     The operation completed successfully
     ```

     

     You may now proceed to the next lab.

     ## Acknowledgements

     * **Author** - Minqiao Wang, Aug 2024 
     * **Last Updated By/Date** - 

     