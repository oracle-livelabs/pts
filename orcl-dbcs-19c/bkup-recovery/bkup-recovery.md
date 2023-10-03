# Back up and recover your data

## Introduction

Backing up your database is a key aspect of any Oracle database environment. There are multiple options available for storing and recovering your backups. You can use the backup and restore feature either within the Oracle Cloud Infrastructure Console, CLI or REST APIs, or manually set up and manage backups using dbcli or RMAN.

When you use the Console, you can create full backups or set up automatic incremental backups with a few clicks. Similarly, you can view your backups and restore your database using the last known good state, a point-in-time, or SCN (System Change Number). You can also create a new database from your backup in an existing or a new DB system.

Please take a moment to watch the video below to learn how to perform the Database Lifecycle Task using the OCI Console, and then afterwards, follow the steps shown.

[Configure Automatic Backups] (youtube:A258cuNZHfw)

Estimated Time: 30 minutes

### Objectives

In this lab you will:
* Create a full database backup
* Restore your Base Database Service from a backup
* Use automatic backups and clone from backup features
* Verify and then terminate your database clone created from backup to release resources

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service

## Task 1: Create a Full Database Backup

1. Connect to the DB System database instance specified by environment variables, if not already connected.

    ````bash
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

2. List all pluggable databases.

    ````sql
    <copy>
    show pdbs
    </copy>

        CON_ID CON_NAME			  OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
    	 2 PDB$SEED			  READ ONLY  NO
    	 3 PDB011			  READ WRITE NO
    	 4 PDB012			  READ WRITE NO
    ````

3. There are three pluggable databases now, one seed PDB (system-supplied template that the CDB can use to create new PDBs) and two user-created PDBs (application data). Exit SQL*Plus.

    ````sql
    <copy>
    exit
    </copy>
    ````

4. On Oracle cloud console, click on main menu **≡**, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System.

5. Click the database name link **WSDB** in the bottom table called Databases.

6. Review the backup called **Automatic Backup** in the bottom table called Backups. Click **Create Backup** button. Call it **'Manual-Backup'**, and click **Create Backup** to confirm. The new backup is added to the Backups table, having the State: Creating...

7. Access Work Requests table, and click **Create Database Backup**. Review all Resources: Log Messages (2), Error Messages (0), Associated Resources (2). Wait until this work request is 100% Complete (refresh page). Under Associated Resources, click **WSDB** database name link.

8. At this point you can see the **Manual-Backup** on Backups table is now Active.

## Task 2: Restore Database Service from Backup

Please take a moment to watch the video below to learn how to perform the Database Lifecycle Task using the OCI Console, and then afterwards, follow the steps shown.

[Restore a BaseDB Database from a Backup] (youtube:deQJ5N9k6eI)

1. Connect to the pluggable database PDB012 as HR user.

    ````bash
    <copy>
    sqlplus hr/<Strong Password>@db-host:1521/pdb012.$(domainname -d)
    </copy>
    ````

2. Drop table `EMPLOYEES`.

    ````bash
    <copy>
    drop table EMPLOYEES cascade constraints;
    COMMIT;
    </copy>
    ````

3. Write down the Started and Ended times for backup called **Manual Backup** in the bottom table called Backups - e.g. Started: 09:38:13 UTC, Ended: 09:56:36 UTC.

4. Up on Database Details page, click **Restore** button. Set field **Restore to the timestamp** to the previous possible value before your Manual Backup Started field - e.g. 09:30 UTC. Click **Restore Database** to confirm.

5. Access Work Requests table, and click **Restore Database** having Status: In Progress... Review all Resources: Log Messages (2), Error Messages (0), Associated Resources (1). Wait until this work request is 100% Complete (refresh page). Under Associated Resources, click **WSDB** database name link.

    >**Note** : PDB012 pluggable database may be in MOUNTED state after the restore. In this case, connect to the ROOT$CDB container database as SYSDBA and open it. Run `sqlplus / as sysdba` and `alter pluggable database all open;` via SSH connection.
    >**Note** : If Restore Database Work request fails, perform a Restore using **Restore to latest** option. You can check the RMAN logs in folder `/opt/oracle/dcs/log/db-host/rman/bkup/[Database unique name]/` for more information.

6. After checking that PDB012 pluggable database is open, connect again as HR user.

    ````bash
    <copy>
    sqlplus hr/<Strong Password>@db-host:1521/pdb012.$(domainname -d)
    </copy>
    ````

7. Select all rows in `EMPLOYEES` table.

    ````sql
    <copy>
    set linesize 130
    col EMPLOYEE_ID heading ID
    col FIRST_NAME for a10
    col LAST_NAME for a10
    col EMAIL for a8
    col PHONE_NUMBER for a16
    col COMMISSION_PCT heading PCT
    select * from EMPLOYEES;
    </copy>
    ````

8. `HR.EMPLOYEES` table was recovered from the manual backup.

9. Type **exit** command tree times followed by Enter to close all sessions (SQL*Plus, oracle user, and SSH).

    ````
    <copy>
    exit
    </copy>

    exit

    exit
    ````

## Task 3: Automatic Backups and Clone from Backup

1. You are on database **WSDB** page. Under Database Information details, review Backup Retention Period: 30 Days, and Backup Schedule: Anytime.

2. Click **Configure Automatic Backups** button. Set the following values:

    - Backup retention period: 45 days
    - Backup scheduling (UTC): 12:00AM - 2:00AM

3. Click **Save Changes**. Database lifecycle state changes to Backup In Progress... Wait for Database to become Available. Under Database Information details, review again Backup Retention Period and Backup Schedule fields. New configuration is displayed:

    - Backup Retention Period: 45 Days
    - Backup Schedule: 12:00AM - 2:00AM UTC

4. Access Backups table at the bottom of the page, and next to Manual-Backup click **⋮** > **Create Database**. On the Create Database from Backup dialog, enter the following values:

    - Select **Create a new DB system** radio button
    - Name your DB system: WS-DBb
    - Change Shape: **VM.Standard.E4.Flex** with 1 core OCPU, 16 GB memory
    - Oracle Database software edition: Enterprise Edition Extreme Performance
    - Choose Storage Management Software: **Logical Volume Manager**
    - Upload SSH key files: Browse and select the public key file saved from the first DB System (ssh-key-XXXX-XX-XX.key.pub).
    - Choose a license type: Bring Your Own License (BYOL)
    - Virtual cloud network: LLXXXXX-VCN
    - Client Subnet: **LLXXXXX-SUBNET-PUBLIC Public Subnet**
    - Hostname prefix: **db-clone**
    - Database name: **WSDBB**
    - Password: Use the strong password written down in your notes.
    - Enter the source database's TDE wallet or RMAN password: Use the strong password written down in your notes.

5. Click **Create Database**. Status is Provisioning...

6. When it becomes Available (refresh page), click **Nodes** on the left menu, and copy Public IP Address in your notes.

## Task 4: Verify Database Clone Created from Backup

1. From your Compute node, connect to the new WS-DBb Database node using SSH (the one you just created from backup).

    ````bash
    <copy>
    ssh -C -i id_rsa opc@<DBb Node Private IP Address>
    </copy>
    ````

2. All Oracle software components are installed with **oracle** OS user. Use the substitute user command to start a session as **oracle** user.

    ````bash
    <copy>
    sudo su - oracle
    </copy>
    ````
3. You can connect to the database instance specified by environment variables.

    ````bash
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

4. List all pluggable databases. This database has three pluggable databases, one seed PDB (system-supplied template that the CDB can use to create new PDBs) and two user-created PDBs (application data). Pluggable database PDB012 existed when you took the Manual Backup you used to create this new database system.

    ````sql
    <copy>
    show pdbs
    </copy>

        CON_ID CON_NAME       OPEN MODE  RESTRICTED
    ---------- -------------- ---------- ----------
             2 PDB$SEED       READ ONLY  NO
             3 PDB011         READ WRITE NO
             4 PDB012         READ WRITE NO
    ````

5. Set current container connection to the pluggable database **PDB012**.

    ````sql
    <copy>
    alter session set container=PDB012;
    </copy>
    ````

6. Verify the application data stored in **HR** schema.

    ````sql
    <copy>
    set linesize 130
    col TABLE_NAME format a40

    select TABLE_NAME, NUM_ROWS from DBA_TABLES where OWNER='HR';
    </copy>

    TABLE_NAME            NUM_ROWS
    --------------------- --------
    REGIONS                      4
    LOCATIONS                   23
    DEPARTMENTS                 27
    JOBS                        19
    EMPLOYEES                  107
    JOB_HISTORY                 10
    COUNTRIES                   25

    7 rows selected.
    ````

7. Type **exit** command tree times followed by Enter to close all sessions (SQL*Plus, oracle user, and SSH).

    ````sql
    <copy>
    exit
    </copy>

    exit

    exit
    ````

## Task 5: Terminate New Database Service to Release Resources

1. On Oracle cloud console, click on main menu **≡**, then **Oracle Base Database** under Databases. Click **WS-DBb** DB System.

2. Click **More Actions** > **Terminate**.

3. Type in the DB System Name to confirm termination: **WS-DBb**.

4. Click **Terminate DB System**. Status becomes Terminating...

5. If you want to see more details, click **Work Requests** in the lower left menu. Click on **Terminate DB System** operation. Here you can see Log Messages, Error Messages, Associated Resources.

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022
