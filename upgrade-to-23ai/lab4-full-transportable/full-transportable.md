# Upgrade using Full Transportable Database #

## Introduction ##

 In this lab, we will use the Full (Cross Platform) Transportable Database functionality to migrate an existing 19c (single-mode, non-CDB architecture) to a 23ai Pluggable database.

 Estimated time: 15 minutes

### Objectives ###

- Create a new 23ai PDB to act as a target for the source database.
- Prepare the target 23ai database for the transported tablespaces
- Prepare the source database for the transportable tablespace step
- Execute the upgrade using Full Transportable Tablespaces
- Check the target (upgraded) database to see that all data has been migrated

### Important ###

- If you use the copy functionality in this lab, make sure you open the Lab instructions INSIDE the client image
    - When copied outside of the client image, additional *returns* can be placed between the lines, which makes the command fail

### Prerequisites ###

- You have access to the Upgrade to 23ai Hands-on-Lab client image
- A new 23ai database has been created in this image
- All databases in the image are running




When in doubt or need to start the databases use the following steps:

1. Please log in as **oracle** user and execute the following command:

    ```text
    $ <copy>. oraenv</copy>
    ```
2. Please enter the SID of the 23ai database that you have created in the first lab. In this example, the SID is **`DB23AI`**

    ```text
    ORACLE_SID = [oracle] ? <copy>DB23AI</copy>

    The Oracle base has been set to /u01/oracle
    ```
3. Now execute the command to start all databases listed in the `/etc/oratab` file:

    ```text
    $ <copy>dbstart $ORACLE_HOME</copy>

    dbstart $ORACLE_HOME
    Processing Database instance "BBB": log file /u01/oracle/product/23/dbhome/rdbms/log/startup.log
    Processing Database instance "CCC": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "RRR": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "TTT": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "DB23AI": log file /u01/oracle/product/23/dbhome/rdbms/log/startup.log
    ```
## Task 1: Prepare the target 23ai database ##

The FTTS functionality requires an existing (pluggable) database as a target. For this, we will log into the existing 23ai instance and create a new Pluggable Database.

### Set the correct environment and log in using SQL*Plus ###

1. Please set the correct ORACLE\_HOME and ORACLE\_SID using oraenv:

    ```text
    $ <copy>. oraenv</copy>
    ```

    Enter the SID for the 23ai environment you already created in a previous lab:

    ```text
    ORACLE_SID = [oracle] ? <copy>DB23AI</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```

2. We can now log in to the 23ai environment. After login, we will create a new pluggable database as the target:

    ```text
    $ <copy>sqlplus / as sysdba</copy>
    ```

### Create a new PDB called PDB19C02 ###

3. Please create a new PDB using the following command:

    ```text
    SQL> <copy>create pluggable database TTT01 admin user admin identified by Welcome_123 file_name_convert=('pdbseed','TTT01');</copy>

    Pluggable database created.
    ```

    In the above example, we choose the location for the filenames by using the file_name_convert clause. Another option would have been setting the `PDB_FILE_NAME_CONVERT` init.ora parameter or have Oracle sort it out using Oracle Managed Files.

    The files for this PDB have been created in `/u01/oradata/DB23AI/TTT01` using our create pluggable database command.

4. After creating the new PDB, we need to start it so it can be used as a target for our migration:

    ```text
    SQL> <copy>alter pluggable database TTT01 open;</copy>

    Pluggable database altered.
    ```

### Prepare the target PDB ###

The migration described in this lab requires a directory object for Datapump (for the logging) and a database link to the source database. We will use `/u01` as the temporary location for the Data Pump files.

5. As are already logged in, we change the session focus to our new PDB (or container):

    ```text
    SQL> <copy>alter session set container=TTT01;</copy>

    Session altered.
    ```
6. Create a new directory object that will be used by the DataPump import command:

    ```text
    SQL> <copy>create directory u01_dir as '/u01';</copy>

    Directory created.
    ```
7. Grant rights to the system user:

    ```text
    SQL> <copy>grant read, write on directory u01_dir to system;</copy>

    Grant succeeded.
    ```
8. Create the database link the we will use during the Transportable Tablespace step:

    ```text
    SQL> <copy>create public database link SOURCEDB
        connect to system identified by Welcome_123
        using '//localhost:1521/TTT';</copy>

    Database link created.
    ```

9. We can check the database link to see if it works by querying a remote table:

    ```text
    SQL> <copy>select instance_name from v$instance@sourcedb;</copy>

    INSTANCE_NAME
    ----------------
    TTT
    ```

10. To be sure, make sure the user we need (and the contents of the source database) do not already exist in our target database. The user that exists in the source database (but should not exist in the target database) is TOILETMAP, and the table the schema contains is called TOILETMAP_AUSTRALIA.

    First, check to see if the user exists in the target environment:
    
    ```text
    SQL> <copy>select table_name from dba_tables where owner='TOILETMAP';</copy>

    no rows selected
    ```
    
    The correct answer should be that no rows are available as the table has not been imported yet from the source database.

11. The second check, to be sure, see if the table exists in the source database:

    ```text
    SQL> <copy>select table_name from dba_tables@sourcedb where owner='TOILETMAP';</copy>

    TABLE_NAME
    --------------------------------------------------------------------------------
    TOILETMAP_AUSTRALIA

    ```
    
    This time the table should be visible as we are querying the source database.

 12. As a quick check, we determine how many records are in the remote table:

    ```text
    SQL> <copy>select count(*) from TOILETMAP.TOILETMAP_AUSTRALIA@sourcedb;</copy>

    COUNT(*)
    ----------
         23696
    ```

    The table and user exist in the source 19C database. They do not exist in the (target) PDB to which we are connected.

 13. We can now exit SQL*Plus on the target system and continue preparing the source system.

    ```text
    SQL> <copy>exit</copy>
    ```

## Task 2: Prepare the Source database ##

 To run the full transportable operation, we'll have to take all data tablespaces into read-only mode – the same procedure as we would do for a regular transportable tablespace operation. Once the tablespace (in this case, just the USERS tablespace) is in read-only mode, we can copy the file(s) to the target location. In our example, we only have one tablespace (USERS) that contains user data. If you execute an FTTS in another environment, make sure you identify all tablespaces!

1. Connect to the source 19c environment and start SQL*Plus as sysdba:

    ```text
    $ <copy>. oraenv</copy>
    ```
    ```text
    ORACLE_SID = [DB23AI] ? <copy>TTT</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```

2. We can now log in to the user sys as sysdba:

    ```text
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Tue Jun 25 15:00:39 2024
    Version 19.21.0.0.0

    Copyright (c) 1982, 2022, Oracle.  All rights reserved.

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.21.0.0.0
    ```

### Set tablespace to READ ONLY and determine datafiles ###

 Change the tablespace USERS (so basically all tablespaces that contain user data) to READ ONLY to prepare it for transportation to the target database. Remember, in this example, we only have data in the USERS tablespace. If you do this in another environment, determine all tablespaces applicable using dba_objects and dba_segments.

3. Set the tablespace to READ-ONLY

    ```text
    SQL> <copy>alter tablespace USERS READ ONLY;</copy>

    Tablespace altered.
    ```

4. We can now determine the data files that we need to copy to the target environment as part of the Transportable Tablespaces. We will only transport those tablespaces that contain user data:

    ```text
    SQL> <copy>select name 
         from v$datafile 
         where ts# in (select ts#
                       from v$tablespace
                       where name='USERS');</copy>

    NAME
    --------------------------------------------------------------------------------
    /u01/oradata/TTT/users01.dbf
    ```

5. Now that we have set the source tablespace to READ ONLY and know which data files we need to work with, we can copy or move the files to the target location. If you move the files, you do not need any additional disk space, but you also do not have a fall-back scenario if something goes wrong (by simply changing the source tablespace to READ WRITE again). Copying, therefore, takes more time and disk space but offers you an easy fall-back scenario.
     
    In our example, we will copy the files. Since the tablespace USERS has been changed to READ ONLY, we can safely copy the data files because no changes will be made to them.

    Please exit SQL*Plus and disconnect from the source database.
    ```text
    SQL> <copy>exit</copy>
    ```

## Task 3: Copy datafiles and import into 19c target PDB ##

1. First, we copy the files to the location we will use for the 23ai target PDB TTT01:

    ```text
    $ <copy>cp /u01/oradata/TTT/users01.dbf /u01/oradata/DB23AI/TTT01</copy>
    ```

Now, we can import the database metadata and data (already copied and ready in the data files for the tablespace USERS in the new location) by executing a Datapump command. The Datapump import will be run through the database link you created earlier, so there is no need for a file-based export or a dump file.

Data Pump will take care of everything (currently except XDB and AWR) you need from the system tablespaces and move views, synonyms, triggers, etc., over to the target database (in our case: TTT01). Data Pump can do this beginning from Oracle 11.2.0.3 on the source side but will require an Oracle 12c or higher database as a target. Data Pump will work cross-platform as well but might need RMAN to convert the files from big to little-endian or vice-versa.

2. First, we change our environment parameters back to 23ai:

    ```text
    $ <copy>. oraenv</copy>
    ```
    
    ```text
    ORACLE_SID = [TTT] ? <copy>DB23AI</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```

3. We can now start the actual import process.

    ```text
    $ <copy>impdp system/Welcome_123@//localhost:1521/TTT01 network_link=sourcedb \
            full=y transportable=always metrics=y exclude=statistics logfile=u01_dir:TTTtoTTT01.log \
            logtime=all transport_datafiles='/u01/oradata/DB23AI/TTT01/users01.dbf'</copy>

    Import: Release 23.0.0.0.0 - Production on Tue Jun 25 15:05:05 2024
    Version 23.5.0.24.06

    Copyright (c) 1982, 2024, Oracle and/or its affiliates.  All rights reserved.

    Connected to: Oracle Database 23ai Enterprise Edition Release 23.0.0.0.0 - Production
    25-JUN-24 15:05:10.351: Starting "SYSTEM"."SYS_IMPORT_FULL_01":  system/********@//localhost:1521/TTT01 network_link=sourcedb full=y transportable=always metrics=y exclude=statistics logfile=u01_dir:TTTtoTTT01.log logtime=all transport_datafiles=/u01/oradata/DB23AI/TTT01/users01.dbf 
    25-JUN-24 15:05:11.258: W-1 Startup on instance 1 took 1 seconds

    (etc)

    25-JUN-24 15:07:02.871: W-1      Completed 1 [internal] Unknown objects in 3 seconds
    25-JUN-24 15:07:04.152: W-1      Completed 1 DATABASE_EXPORT/EARLY_OPTIONS/VIEWS_AS_TABLES/TABLE_DATA objects in 0 seconds
    25-JUN-24 15:07:04.154: W-1      Completed 53 DATABASE_EXPORT/NORMAL_OPTIONS/TABLE_DATA objects in 5 seconds
    25-JUN-24 15:07:04.157: W-1      Completed 16 DATABASE_EXPORT/NORMAL_OPTIONS/VIEWS_AS_TABLES/TABLE_DATA objects in 5 seconds
    25-JUN-24 15:07:04.197: Job "SYSTEM"."SYS_IMPORT_FULL_01" completed with 9 error(s) at Tue Jun 25 15:07:04 2024 elapsed 0 00:01:56   
    ```

    Usually, you will find errors when using FTTS:

    ```text
    25-JUN-24 15:05:28.843: ORA-39083: Object type ON_USER_GRANT failed to create with error:
    ORA-31625: Schema GSMROOTUSER is needed to import this object, but is unaccessible
    ORA-01435: user does not exist

    Failing sql is:
     GRANT INHERIT PRIVILEGES ON USER "GSMROOTUSER" TO "PUBLIC"
    ```
    
    You need to check the log file to determine if the errors harm your environment. In our migration, the errors should only concern a few users who could not be created or do not exist.

## Task 4: Check the new upgraded target ##

The Data Pump process should have migrated the most crucial user in the database (TOILETMAP). We can check the target database to see if our table has been imported as it should:

1. Login to the target database

    ```text
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 23.0.0.0.0 - Production on Thu Jul 18 11:43:53 2024
    Version 23.5.0.24.06

    Copyright (c) 1982, 2024, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 23ai Enterprise Edition Release 23.0.0.0.0 - Production
    Version 23.5.0.24.06
    ```
    
2. Change the session environment to the PDB (container):

    ```text
    SQL> <copy>alter session set container=TTT01;</copy>

    Session altered.
    ```
3. Check if the table, which is so important, exists in the target database:

    ```text
    SQL> <copy>select table_name from dba_tables where owner='TOILETMAP';</copy>

    TABLE_NAME
    --------------------------------------------------------------------------------
    TOILETMAP_AUSTRALIA
    ```

4. We can also check the number of records in the table by executing the following command:

    ```text
    SQL> <copy>select count(*) from TOILETMAP.TOILETMAP_AUSTRALIA;</copy>

      COUNT(*)
    ----------
         23696
    ```

    In case you get a similar number as the example, the migration seems to be successful.

## Acknowledgements ##

- **Author** - Robert Pastijn, Database Product Management, PTS EMEA - July 2024
