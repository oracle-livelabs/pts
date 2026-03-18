# Setup The Primary Database

## Introduction
In this lab, You will check and modify the status of the primary site database, make it ready to ADG.

Estimated Time: 30 minutes

### Objectives
- Enable achivelog and flashback for the primary database.
- Change redo log size and create standby log.
- Modify the init parameters for best practice.

### Prerequisites
This lab assumes you have completed the following labs:

- Environment Setup For Primary And Standby

Now you have 2 VM hosts:

- `primary`: The primary database host, DB unique name **ORCL**, SID is **ORCL**
- `standby`: The standby database host, only db software installed. No database created.



## **Task 1:** Enable Achivelog And Flashback

1. Connect to the primary VM hosts with opc user. Use putty tool (Windows) or command line (Mac, Linux).

    ```
    <copy>ssh -i labkey opc@xxx.xxx.xxx.xxx</copy>
    ```

2. Swtich to **oracle** user, and connect to the database with sysdba

    ```
    <copy>
    sudo su - oracle
    sqlplus / as sysdba
    </copy>
    ```

   

3. Check the achivelog mode, you can find it's disable now.

    ```
    SQL> <copy>archive log list</copy>
    Database log mode	       No Archive Mode
    Automatic archival	       Disabled
    Archive destination	       USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     10
    Current log sequence	       12
    SQL> 
    ```

2. Enable the archive mode and flashback on.

    ```
    SQL> <copy>shutdown immediate</copy>
    Database closed.
    Database dismounted.
    ORACLE instance shut down.
    
    SQL> <copy>startup mount</copy>
    ORACLE instance started.
    
    Total System Global Area 6845104048 bytes
    Fixed Size		    9150384 bytes
    Variable Size		 1275068416 bytes
    Database Buffers	 5553258496 bytes
    Redo Buffers		    7626752 bytes
    Database mounted.
    
    SQL> <copy>alter database archivelog;</copy>
    
    Database altered.
    
    SQL> <copy>!mkdir -p /u01/app/oracle/fra/ORCL</copy>
    SQL> <copy>ALTER SYSTEM SET DB_RECOVERY_FILE_DEST_SIZE = 10G SCOPE=BOTH SID='*';</copy>
    SQL> <copy>ALTER SYSTEM SET DB_RECOVERY_FILE_DEST = '/u01/app/oracle/fra/ORCL' SCOPE=BOTH SID='*';</copy>
    
    SQL> <copy>alter database flashback on;</copy>
    
    Database altered.
    
    SQL> <copy>alter database open;</copy>
    
    Database altered.
    
    SQL> 
    ```

3. Check the status again, it's enabled now.

    ```
    SQL> <copy>archive log list</copy>
    Database log mode	       Archive Mode
    Automatic archival	       Enabled
    Archive destination	       USE_DB_RECOVERY_FILE_DEST
    Oldest online log sequence     10
    Next log sequence to archive   12
    Current log sequence	       12
    SQL> 
    ```

4. Enable force logging.

    ```
    SQL> <copy>alter database force logging;</copy>
    
    Database altered.
    
    SQL>
    ```


## **Task 2:** Change Redo Log Size And Create Standby Log

1. Change the redo log size to 1024M according to the best practice. Check the status of the redo log first.

    ```
    SQL> <copy>select group#, bytes, status from v$log;</copy>
    
        GROUP#	BYTES STATUS
    ---------- ---------- ----------------
    	 1  209715200 INACTIVE
    	 2  209715200 INACTIVE
    	 3  209715200 CURRENT
    ```

2. Add 3 new redo log group.

    ```
    <copy>
    alter database add logfile group 4 '/u01/app/oracle/oradata/ORCL/redo04.log' size 1024M; 
    alter database add logfile group 5 '/u01/app/oracle/oradata/ORCL/redo05.log' size 1024M; 
    alter database add logfile group 6 '/u01/app/oracle/oradata/ORCL/redo06.log' size 1024M;
    </copy>
    ```

3. Switch the logfile serveral times.

    ```
    <copy>
    alter system switch logfile;
    alter system checkpoint;
    </copy>
    ```

4. Check the status again.

    ```
    SQL> <copy>select group#, bytes, status from v$log;</copy>
    
        GROUP#	BYTES STATUS
    ---------- ---------- ----------------
    	 1  209715200 INACTIVE
    	 2  209715200 INACTIVE
    	 3  209715200 INACTIVE
    	 4 1073741824 CURRENT
    	 5 1073741824 UNUSED
    	 6 1073741824 UNUSED
    
    6 rows selected.
    
    SQL> 
    ```

5. When the first 3 groups status is INACTIVE, you can drop these group now.

    ```
    SQL> <copy>alter database drop logfile group 1;</copy> 
    
    Database altered.
    
    SQL> <copy>alter database drop logfile group 2;</copy> 
    
    Database altered.
    
    SQL> <copy>alter database drop logfile group 3;</copy> 
    
    Database altered.
    
    SQL> 
    ```

6. Create 4 standby log group.

    ```
    SQL> <copy>alter database add standby logfile thread 1 '/u01/app/oracle/oradata/ORCL/srl_redo01.log' size 1024M;</copy>
    
    Database altered.
    
    SQL> <copy>alter database add standby logfile thread 1 '/u01/app/oracle/oradata/ORCL/srl_redo02.log' size 1024M;</copy>
    
    Database altered.
    
    SQL> <copy>alter database add standby logfile thread 1 '/u01/app/oracle/oradata/ORCL/srl_redo03.log' size 1024M;</copy>
    
    Database altered.
    
    SQL> <copy>alter database add standby logfile thread 1 '/u01/app/oracle/oradata/ORCL/srl_redo04.log' size 1024M;</copy>
    
    Database altered.
    
    SQL> <copy>select group#,thread#,bytes from v$standby_log;</copy>
    
        GROUP#    THREAD#	   BYTES
    ---------- ---------- ----------
    	 1	    1 1073741824
    	 2	    1 1073741824
    	 3	    1 1073741824
    	 7	    1 1073741824
    
    SQL> 
    ```



## **Task 3:** Modify Init Parameters For Best Practice

1. Modify some init parameters for best practice.

    ```
    SQL> <copy>alter system set STANDBY_FILE_MANAGEMENT=AUTO scope=both;</copy>
    
    System altered.
    
    SQL> <copy>alter system set DB_LOST_WRITE_PROTECT=TYPICAL scope=both;</copy>
    
    System altered.
    
    SQL> <copy>alter system set FAST_START_MTTR_TARGET=300 scope=both;</copy>
    
    System altered.
    
    SQL> <copy>exit;</copy>
    ```



You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Minqiao Wang, Oct 2020 
* **Last Updated By/Date** - Minqiao Wang, Oct 2021

