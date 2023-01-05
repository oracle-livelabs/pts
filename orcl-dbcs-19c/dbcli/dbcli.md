# Oracle Database Command Line Interface (DBCLI)

## Introduction

The database CLI (dbcli) is a command line interface available on bare metal and virtual machine DB systems. After you connect to the DB system, you can use the database CLI to perform tasks such as creating Oracle database homes and databases.

Estimated Time: 45 minutes

### Objectives

In this lab you will:
* Get the latest new and updated DBCLI commands
* Retrieve your Base Database Service installation information
* Control your Base Database Service running status
* Manage pluggable databases
* Apply patches from command line

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service
* The database CLI commands must be run as the root user

## Task 1: DBCLI Update Command

Occasionally, new commands are added to the database CLI and other commands are updated to support new features. You can use the **cliadm update-dbcli** command to update the database CLI with the latest new and updated commands.

1. Connect to the Database node using SSH (Use Putty on Windows).

    ````
    <copy>
    ssh -C -i Downloads/ssh-key-XXXX-XX-XX.key opc@<DB Node Public IP Address>
    </copy>
    ````

2. All database CLI commands must be run as the **root** user. Use the substitute user command to start a session as **root** user.

    ````
    <copy>
    sudo su -
    </copy>
    ````

3. You can check the information about your DB System and verify the version for each component installed using the following command:

    ````
    <copy>
    dbcli describe-system -d
    </copy>

    DbSystem Information                                            
    ----------------------------------------------------------------
                         ID: 04697842-f4e0-4b5b-84a5-515e135ba7a7
                   Platform: Vmdb
            Data Disk Count: 0
             CPU Core Count: 1
                    Created: July 27, 2020 9:29:06 AM UTC

    System Information                                                
    ----------------------------------------------------------------
                       Name:
                Domain Name: sub07141037280.rehevcn.oraclevcn.com
                  Time Zone: UTC
                 DB Edition:
                DNS Servers:
                NTP Servers: 169.254.169.254

    Disk Group Information
    ----------------------------------------------------------------
    DG Name                   Redundancy                Percentage  
    ------------------------- ------------------------- ------------


    DcsCli Details                                                  
    ----------------------------------------------------------------
                    Version: 20.1.2.0.0-SNAPSHOT
                BuildNumber: jenkins-dcs-cli-20.1.2.0.0-4
                  GitNumber: 1e4b74d168ede09013e884aa694c8cd36caef3c5
                  BuildTime: 2020-03-19_0734 UTC

    DcsAgent Details                                                
    ----------------------------------------------------------------
                    Version: 20.3.1.0.0-SNAPSHOT
                BuildNumber: jenkins-dcs-agent-20.3.1.0.0-49
                  GitNumber: 97c738611d3f49c8770f30bf95860656a0e3b0d2
                  BuildTime: 2020-07-22_0640 UTC

    DcsAdmin Details                                                
    ----------------------------------------------------------------
                    Version: 20.1.2.0.0-SNAPSHOT
                BuildNumber: jenkins-dcs-admin-20.1.2.0.0-4
                  GitNumber: ea4ea7a58e251fd9fbce08807dc089f7224851aa
                  BuildTime: 2020-03-19_0750 UTC
    ````

4. Run the update command, and it will return the list of components that need to be updated. In this example, only DcsCli components will be updated. This command generates a job.

    ````
    <copy>
    cliadm update-dbcli
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  090ca6fa-05b9-404e-b53f-910be070dc89
                Description:  DcsCli patching
                     Status:  Created
                    Created:  July 29, 2020 1:37:34 PM UTC
                    Message:  Dcs cli will be updated
    ````

5. Verify the update job has finished successfully. Replace the attribute in the example with the Job ID from your update command response.

    ````
    <copy>
    dbcli describe-job -i 090ca6fa-05b9-404e-b53f-910be070dc89
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  090ca6fa-05b9-404e-b53f-910be070dc89
                Description:  DcsCli patching
                     Status:  Success
                    Created:  July 29, 2020 1:37:34 PM UTC
                   Progress:  100%
                    Message:  
    ````

6. Re-execute the dbcli describe-system command to see the updated component version.

    ````
    <copy>
    dbcli describe-system -d
    </copy>

    ...
    DcsCli Details                                                  
    ----------------------------------------------------------------
                    Version: 20.3.1.0.0-SNAPSHOT
                BuildNumber: jenkins-dcs-cli-20.3.1.0.0-8
                  GitNumber: 850d069ade0c7c9b712811f327e7d3ad87078077
                  BuildTime: 2020-07-01_1545 UTC

    ...
    ````

7. Another way to verify components on a DB System is to use **rpm** package management command.

    ````
    <copy>
    rpm -qa | grep dcs
    </copy>

    dcs-cli-20.3.1.0.0_200716.0711-1.x86_64
    dcs-admin-20.1.2.0.0_200408.0952-1.x86_64
    dcs-agent-20.3.1.0.0_200716.0711-49.x86_64
    ````

## Task 2: Retrieve Database Installation Information

With dbcli you can retrieve all the information about a database installation on a DB System.

1. Use the describe component command to show the installed and available patch versions for the server, storage, and/or database home components in the DB System. Notice, in this example, there is a patch available for the database installation.

    ````
    <copy>
    dbcli describe-component
    </copy>

    System Version  
    ---------------
    20.3.1.0.0

    Component                                Installed Version    Available Version   
    ---------------------------------------- -------------------- --------------------
    DB                                        19.7.0.0.0            19.8.0.0
    ````

2. Use the list database homes command to display a list of Oracle Home directories installed on this DB System.

    ````
    <copy>
    dbcli list-dbhomes
    </copy>

    ID                                       Name                 DB Version                               Home Location                                 Status    
    ---------------------------------------- -------------------- ---------------------------------------- --------------------------------------------- ----------
    bee69ef5-2a12-4d87-a694-4f540ff777e9     OraDB19000_home1     19.7.0.0.0                               /u01/app/oracle/product/19.0.0/dbhome_1       Configured
    ````

3. Use the list database storages command to list the database storage in the DB System. Notice the storage on this DB System is of type Logical Volume Manager (LVM).

    ````
    <copy>
    dbcli list-dbstorages
    </copy>

    ID                                       Type   DBUnique Name        Status    
    ---------------------------------------- ------ -------------------- ----------
    cb07c003-edf2-4d2c-9bb7-980df0d1c5d5     Lvm    WSDB_fra14j        Configured
    ````

4. You can use the list databases command to list all databases on the DB system, and additional information.

    ````
    <copy>
    dbcli list-databases
    </copy>

    ID                                       DB Name    DB Type  DB Version           CDB        Class    Shape    Storage    Status        DbHomeID                                
    ---------------------------------------- ---------- -------- -------------------- ---------- -------- -------- ---------- ------------ ----------------------------------------
    512eb207-b4ff-4145-83e6-0212e08d8f3e     WSDB     Si       19.7.0.0.0           true       Oltp              LVM        Configured   bee69ef5-2a12-4d87-a694-4f540ff777e9
    ````

5. Use the list backup configs command to list all the backup configurations in the DB system.

    ````
    <copy>
    dbcli list-backupconfigs
    </copy>

    ID                                       Name                 RecoveryWindow   CrosscheckEnabled   BackupDestination   
    ---------------------------------------- -------------------- ---------------- ------------------- --------------------
    e9c1158e-55d9-43b1-afce-8fdc81f5720e     bEgRSXwq9R3Bd9iEk1pz_BC 45               true                ObjectStore   
    ````

6. Use the describe backup config command to show details about a specific backup configuration. Use your backup configuration ID.

    ````
    <copy>
    dbcli describe-backupconfig -i e9c1158e-55d9-43b1-afce-8fdc81f5720e
    </copy>

    Backup Config details                                             
    ----------------------------------------------------------------
                         ID: e9c1158e-55d9-43b1-afce-8fdc81f5720e
                       Name: bEgRSXwq9R3Bd9iEk1pz_BC
          CrosscheckEnabled: true
             RecoveryWindow: 45
          BackupDestination: ObjectStore
             BackupLocation: bEgRSXwq9R3Bd9iEk1pz
              ObjectStoreId: c31983b7-82a3-4e43-b887-71567d0365a5
                CreatedTime: July 27, 2020 9:49:23 AM UTC
                UpdatedTime: July 27, 2020 4:10:24 PM UTC
           LocationAffinity:
                RecoveryTag:
    ````

## Task 3: Control Database Running Status

With dbcli you can control the running status of a database on a DB System.

1. Display the running status of the database. Use the database ID returned by the list databases command. Current status should be **running**.

    ````
    <copy>
    dbcli get-databasestatus -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    Database Status                          Running Status                   Node Name           
    ---------------------------------------- -------------------------------- ------------------
    Open                                     running                          db-host   
    ````

2. Stop the database running on this DB System. Use your database ID for the command. This command generates a job.

    ````
    <copy>
    dbcli stop-database -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    {
      "jobId" : "5985b8a5-a5d0-48c9-99ce-413fc48f05d4",
      "status" : "Created",
      "message" : null,
      "reports" : [ ],
      "createTimestamp" : "July 30, 2020 09:38:03 AM UTC",
      "resourceList" : [ ],
      "description" : "Database shutdown of DB with ID: 512eb207-b4ff-4145-83e6-0212e08d8f3e",
      "updatedTime" : "July 30, 2020 09:38:03 AM UTC",
      "percentageProgress" : "0%"
    }
    ````

3. Verify the stop database job has finished successfully. Use your job ID for the stop database response.

    ````
    <copy>
    dbcli describe-job -i 5985b8a5-a5d0-48c9-99ce-413fc48f05d4
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  5985b8a5-a5d0-48c9-99ce-413fc48f05d4
                Description:  Database shutdown of DB with ID: 512eb207-b4ff-4145-83e6-0212e08d8f3e
                     Status:  Success
                    Created:  July 30, 2020 9:38:03 AM UTC
                   Progress:  100%
                    Message:  

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    shutting down database                                                   July 30, 2020 9:38:03 AM UTC        July 30, 2020 9:38:29 AM UTC        Success   
    ````

4. Display again the running status of the database. This time it's **not running**.

    ````
    <copy>
    dbcli get-databasestatus -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    Database Status                          Running Status                   Node Name           
    ---------------------------------------- -------------------------------- --------------------
    Closed                                   not running                      db-host             
    ````

5. Start the database on this DB System. Use your database ID for the command. This command generates a job.

    ````
    <copy>
    dbcli start-database -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    {
      "jobId" : "d25a505e-6554-4d5a-abf7-5eeef1b427df",
      "status" : "Created",
      "message" : null,
      "reports" : [ ],
      "createTimestamp" : "July 30, 2020 09:40:59 AM UTC",
      "resourceList" : [ ],
      "description" : "Database startup of DB with ID: 512eb207-b4ff-4145-83e6-0212e08d8f3e",
      "updatedTime" : "July 30, 2020 09:40:59 AM UTC",
      "percentageProgress" : "0%"
    }
    ````

6. Verify the stop database job has finished successfully. Use your job ID for the stop database response. Also display again the running status of the database. Use your database ID returned by the list databases command. This time it should be **running**.

    ````
    <copy>
    dbcli get-databasestatus -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    Database Status                          Running Status                   Node Name           
    ---------------------------------------- -------------------------------- ------------------
    Open                                     running                          db-host             
    ````

## Task 4: Manage Pluggable Databases

With dbcli command you can manage pluggable databases on the container database from a DB System, performing tasks like create, clone, delete, plug, unplug, and more.

1. Use the list PDBs command to show all pluggable databases from a database. Use your database ID returned by the list databases command.

    ````
    <copy>
    dbcli list-pdbs -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    ID                                       PDB Name             CDB Name             Status              
    ---------------------------------------- -------------------- -------------------- --------------------
    52fa1489-2a1c-47d4-9124-9a2f40fc7ce0     PDB011               WSDB               Configured           
    90e6109a-ba96-47da-b09e-bb54223fb5a6     PDB012               WSDB               Configured           
    ````

2. Get more details about pluggable databases with the describe PDBs command.

    ````
    <copy>
    dbcli describe-pdb -i 512eb207-b4ff-4145-83e6-0212e08d8f3e -n PDB011
    </copy>

    ID                                       PDB Name             CDB Name             Open Mode            Restricted Mode      Database Instance Name
    ---------------------------------------- -------------------- -------------------- -------------------- -------------------- --------------------
    52fa1489-2a1c-47d4-9124-9a2f40fc7ce0     PDB011               WSDB               READ WRITE           NO                   WSDB              
    ````

3. Create a new pluggable database, name it **pdb013**. Provide a password for the Admin user, and the password of the Transparent Data Encryption Wallet when asked. Use the strong password written down in your notes for both passwords. A new job is generated.

    ````
    <copy>
    dbcli create-pdb -i 512eb207-b4ff-4145-83e6-0212e08d8f3e -n pdb013 -p -tp
    </copy>

    Admin password of the PDB to be created:
    TDE Wallet Password of the CDB:

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  62ee73cc-e353-4e4b-90f0-f752cd5df6ec
                Description:  Create Pluggable Database :PDB013 in database:WSDB
                     Status:  Created
                    Created:  July 30, 2020 10:14:04 AM UTC
                   Progress:  0%
                    Message:  
    ````

4. Verify the create PDB job has started, and the current progress. Use your job ID for this command. Verify the current status and progress of the job.

    ````
    <copy>
    dbcli describe-job -i 62ee73cc-e353-4e4b-90f0-f752cd5df6ec
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  62ee73cc-e353-4e4b-90f0-f752cd5df6ec
                Description:  Create Pluggable Database :PDB013 in database:WSDB
                     Status:  Running
                    Created:  July 30, 2020 10:14:04 AM UTC
                   Progress:  5%
                    Message:  

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    Create pluggable Database:pdb013                                         July 30, 2020 10:14:06 AM UTC       July 30, 2020 10:14:06 AM UTC       Running   
    ````

5. Repeat the previous command to check if the create PDB job has finished successfully.

    ````
    <copy>
    dbcli describe-job -i 62ee73cc-e353-4e4b-90f0-f752cd5df6ec
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  62ee73cc-e353-4e4b-90f0-f752cd5df6ec
                Description:  Create Pluggable Database :PDB013 in database:WSDB
                     Status:  Success
                    Created:  July 30, 2020 10:14:04 AM UTC
                   Progress:  100%
                    Message:  

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    Create pluggable Database:pdb013                                         July 30, 2020 10:14:06 AM UTC       July 30, 2020 10:15:47 AM UTC       Success   
    Configure init params                                                    July 30, 2020 10:15:47 AM UTC       July 30, 2020 10:15:48 AM UTC       Success   
    ````

6. Use again the list PDBs command to show all pluggable databases, and verify the new pluggable database **PDB013** is in the list.

    ````
    <copy>
    dbcli list-pdbs -i 512eb207-b4ff-4145-83e6-0212e08d8f3e
    </copy>

    ID                                       PDB Name             CDB Name             Status              
    ---------------------------------------- -------------------- -------------------- -----------------
    52fa1489-2a1c-47d4-9124-9a2f40fc7ce0     PDB011               WSDB               Configured
    90e6109a-ba96-47da-b09e-bb54223fb5a6     PDB012               WSDB               Configured                      
    5531cec9-0dcf-4d2a-b536-eb87db31c677     PDB013               WSDB               Configured           
    ````

7. Type **exit** command two times followed by Enter to close all sessions (root user, and SSH).

    ````
    <copy>
    exit
    </copy>

    exit
    ````

## Task 5: Apply Patches from Command Line

You can apply patches and updates with dbcli command. Our primary database should is (or will be) patched using the cloud console. For this exercise, we use the standby database.

1. Connect to the Standby DB System node using SSH (Use Putty on Windows).

    ````
    <copy>
    ssh -C -i Downloads/ssh-key-XXXX-XX-XX.key opc@<Standby Node Public IP Address>
    </copy>
    ````

2. Use the substitute user command to start a session as **root** user.

    ````
    <copy>
    sudo su -
    </copy>
    ````

3. Run the update command, and it will return the list of components that need to be updated. In this example, only DcsCli components will be updated. This command generates a job.

    ````
    <copy>
    cliadm update-dbcli
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  b97b8200-1f26-4747-8ae7-1165d925fee2
                Description:  DcsCli patching
                     Status:  Created
                    Created:  August 1, 2020 1:15:44 PM UTC
                    Message:  Dcs cli will be updated
    ````

4. Check if the dbcli update job has finished successfully. Use your job ID.

    ````
    <copy>
    dbcli describe-job -i b97b8200-1f26-4747-8ae7-1165d925fee2
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  b97b8200-1f26-4747-8ae7-1165d925fee2
                Description:  DcsCli patching
                    Status:  Success
                    Created:  August 1, 2020 1:15:44 PM UTC
                   Progress:  100%
                    Message:  
    ````

5. Use the describe component command to show the installed and available patch versions for the server, storage, and/or database home components in the DB system. We will focus on the database component. In this example, the installed version is 19.7, and there is a new version available, 19.8.

    ````
    <copy>
    dbcli describe-component
    </copy>

    System Version  
    ---------------
    20.2.1.2.0

    Component                                Installed Version    Available Version   
    ---------------------------------------- -------------------- --------------------
    DB                                        19.7.0.0.0            19.8.0.0            
    ````

6. Use the describe latest patch command show the latest patches applicable to the DB system and available in Oracle Cloud Infrastructure Object Storage. In this example, we have version 19.8 available, and ready to be applied.

    ````
    <copy>
    dbcli describe-latestpatch
    </copy>

    componentType   availableVersion    
    --------------- --------------------
    db              11.2.0.4.200714     
    db              12.2.0.1.200714     
    db              12.1.0.2.200714     
    db              18.11.0.0.0         
    db              19.8.0.0.0  
    ````

7. Show the latest patches applicable to the operating system. At this point, there are no OS patches available.

    ````
    <copy>
    dbcli get-availableospatches
    </copy>

    Update Available     Reboot Required     
    -------------------- --------------------
    No                   No        
    ````

    >**Note** : If there are OS patches available, you can run the OS update with the following commands:
    >
    >Pre-update check.
    >````
    dbcli update-server -c os -p
    >````
    >OS update.
    >````
    dbcli update-server -c os
    >````
    >Reboot DB System Node.

8. Use the update server command to apply patches to the server components in the DB system. In case of a DB System using Oracle Grid Infrastructure (OGI), this command updates OGI components.

    ````
    <copy>
    dbcli update-server
    </copy>

    {
      "jobId" : "82bc7072-b963-4618-a030-1c7a521ece51",
      "status" : "Created",
      "message" : null,
      "reports" : [ ],
      "createTimestamp" : "August 01, 2020 13:18:35 PM UTC",
      "resourceList" : [ ],
      "description" : "Server Patching",
      "updatedTime" : "August 01, 2020 13:18:35 PM UTC",
      "percentageProgress" : "0%"
    }
    ````

9. Verify the server update job has finished successfully. Use your job ID.

    ````
    <copy>
    dbcli describe-job -i 82bc7072-b963-4618-a030-1c7a521ece51
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  82bc7072-b963-4618-a030-1c7a521ece51
                Description:  Server Patching
                     Status:  Success
                    Created:  August 1, 2020 1:18:35 PM UTC
                   Progress:  100%
                    Message:  

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    Pre-operations for Server Patching                                       August 1, 2020 1:18:35 PM UTC       August 1, 2020 1:18:36 PM UTC       Success   
    Server Patching                                                          August 1, 2020 1:18:36 PM UTC       August 1, 2020 1:18:36 PM UTC       Success   
    ````

10. Use again the list database homes command to display the list of Oracle Home directories, and confirm their current version, 19.7 in this case.

    ````
    <copy>
    dbcli list-dbhomes
    </copy>

    ID                                       Name                 DB Version                               Home Location                                 Status    
    ---------------------------------------- -------------------- ---------------------------------------- --------------------------------------------- ----------
    bee69ef5-2a12-4d87-a694-4f540ff777e9     OraDB19000_home1     19.7.0.0.0                               /u01/app/oracle/product/19.0.0/dbhome_1       Configured
    ````

11. Use the update database home command to apply the available database bundle patch (DBBP) to the database home. Use your database home ID.

    ````
    <copy>
    dbcli update-dbhome -i bee69ef5-2a12-4d87-a694-4f540ff777e9
    </copy>

    {
      "jobId" : "7add2699-e7f2-4170-9fd1-94a1bab50e07",
      "status" : "Created",
      "message" : null,
      "reports" : [ ],
      "createTimestamp" : "August 01, 2020 13:20:18 PM UTC",
      "resourceList" : [ ],
      "description" : "DB Home Patching: Home Id is bee69ef5-2a12-4d87-a694-4f540ff777e9",
      "updatedTime" : "August 01, 2020 13:20:18 PM UTC",
      "percentageProgress" : "0%"
    }
    ````

12. Verify the database home update job has started, and the current status.

    ````
    <copy>
    dbcli describe-job -i 7add2699-e7f2-4170-9fd1-94a1bab50e07
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  7add2699-e7f2-4170-9fd1-94a1bab50e07
                Description:  DB Home Patching: Home Id is bee69ef5-2a12-4d87-a694-4f540ff777e9
                     Status:  Running
                    Created:  August 1, 2020 1:20:18 PM UTC
                   Progress:  20%
                    Message:  

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    Pre-Operations for DbHome Patching                                       August 1, 2020 1:20:18 PM UTC       August 1, 2020 1:20:37 PM UTC       Success   
    DbHome Patching                                                          August 1, 2020 1:20:37 PM UTC       August 1, 2020 1:20:37 PM UTC       Running
    ````

13. Repeat the previous command to verify the database home update job has finished successfully. Make sure it gets to 100% progress and all tasks have Success status.

    ````
    <copy>
    dbcli describe-job -i 7add2699-e7f2-4170-9fd1-94a1bab50e07
    </copy>

    Job details                                                      
    ----------------------------------------------------------------
                         ID:  7add2699-e7f2-4170-9fd1-94a1bab50e07
                Description:  DB Home Patching: Home Id is bee69ef5-2a12-4d87-a694-4f540ff777e9
                     Status:  SuccessWithWarning
                    Created:  August 1, 2020 1:20:18 PM UTC
                   Progress:  100%
                    Message:  WARNING::Failed to run Utlrp script

    Task Name                                                                Start Time                          End Time                            Status    
    ------------------------------------------------------------------------ ----------------------------------- ----------------------------------- ----------
    Pre-Operations for DbHome Patching                                       August 1, 2020 1:20:18 PM UTC       August 1, 2020 1:20:37 PM UTC       Success   
    DbHome Patching                                                          August 1, 2020 1:20:37 PM UTC       August 1, 2020 1:50:09 PM UTC       Success   
    Post-Operations for DbHome Patching                                      August 1, 2020 1:50:09 PM UTC       August 1, 2020 2:04:21 PM UTC       Success
    ````

14. Use again the list database homes command to display the list of Oracle Home directories, and confirm the current version is updated to 19.8 in this case.

    ````
    <copy>
    dbcli list-dbhomes
    </copy>

    ID                                       Name                 DB Version                               Home Location                                 Status    
    ---------------------------------------- -------------------- ---------------------------------------- --------------------------------------------- ----------
    bee69ef5-2a12-4d87-a694-4f540ff777e9     OraDB19000_home1     19.8.0.0.0                               /u01/app/oracle/product/19.0.0/dbhome_1       Configured
    ````

15. Use one more time the describe component command to show the installed and available patch versions for the server, storage, and/or database home components in the DB system. We will focus on the database component. After applying the patch, the installed version is 19.8, and it is up-to-date.

    ````
    <copy>
    dbcli describe-component
    </copy>
    System Version  
    ---------------
    20.2.1.2.0

    Component                                Installed Version    Available Version   
    ---------------------------------------- -------------------- --------------------
    DB                                        19.8.0.0.0            up-to-date  
    ````

16. Type **exit** command two times followed by Enter to close all sessions (root user, and SSH).

    ````
    <copy>
    exit
    </copy>

    exit
    ````

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
