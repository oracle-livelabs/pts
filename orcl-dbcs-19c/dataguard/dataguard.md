# Data Guard physical standby database

## Introduction

In this lab you will learn how to use the cloud console to manage Oracle Data Guard associations in your DB System. An Oracle Data Guard implementation requires two DB systems, one containing the primary database and one containing the standby database. When you enable Oracle Data Guard for a virtual machine DB system database, a new DB system with the standby database is created and associated with the primary database.

Estimated Time: 45 minutes

### Objectives

In this lab you will:
* Deploy a Data Guard standby database for disaster recovery
* Test DR strategy by performing a switchover operation
* Enable Fast-Start Failover
* Change Data Guard protection mode configuration
* Pause and resume redo apply on standby
* Test Fast-Start Failover with Maximum Availability configuration

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service Enterprise Edition - Extreme Performance
* Both DB Systems must be in the same compartment.
* The DB Systems must be the same shape type.
* The database versions and editions must be identical.

## Task 1: Enable Data Guard

1. On Oracle cloud console, click on main menu ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DB** DB System.

2. Add to your notes the Availability Domain you see on the DB System Information page (e.g. IWcS:EU-FRANKFURT-1-AD-1).

3. On the DB System Details page, click the database name link **WSDB** in the bottom table called Databases.

4. Observe Data Guard - Status: Not enabled, on the Database Information page.

5. Click **Data Guard Associations** in the lower left menu. Click **Enable Data Guard**. Provide the following details:

    - Display name: WS-DBStb
    - Availability domain: AD2 (different from your DB System AD)
    - Select a shape: VM.Standard2.1
    - Virtual cloud network: LLXXXXX-VCN
    - Client Subnet: LLXXXXX-SUBNET-PUBLIC Public Subnet
    - Hostname prefix: db-hoststb
    - Protection mode: Maximum Performance
    - Password: Use the strong password written down in your notes.

6. Click **Enable Data Guard**.

7. Click ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Or use the breadcrumbs link **DB Systems**. Click **WS-DBStb** DB System. Status is Provisioning...

8. If you want to see more details, click **Work Requests** in the lower left menu. Check Operation Create Data Guard having status In Progress... Wait until your Standby DB System is Available. On **WS-DBStb** DB System details page, click **Nodes** in the lower left menu, and and copy Public IP Address and Private IP Address in your notes.

## Task 2: Connect to Standby DB System

1. Connect to the Standby DB System node using SSH (Use Putty on Windows).

    ````
    <copy>
    ssh -C -i Downloads/ssh-key-XXXX-XX-XX.key opc@<Standby Node Public IP Address>
    </copy>
    ````

2. All Oracle software components are installed with **oracle** OS user. Use the substitute user command to start a session as **oracle** user.

    ````
    <copy>
    sudo su - oracle
    </copy>
    ````

3. Set environment variables required by administration tools.

    ````
    <copy>
    export PATH=$PATH:/u01/app/oracle/product/19.0.0/dbhome_1/bin
    . oraenv
    </copy>
    ORACLE_SID = [oracle] ? WSDB
    The Oracle base has been set to /u01/app/oracle
    ````

3. The Data Guard command-line interface (DGMGRL) enables you to manage a Data Guard broker configuration and its databases directly from the command line, or from batch programs or scripts.

    ````
    <copy>
    dgmgrl
    </copy>
    ````

4. To run DGMGRL, you must have SYSDBA privileges. Log in as user SYSDG with the SYSDG administrative privilege to perform Data Guard operations. You can use this privilege with either Data Guard Broker or the DGMGRL command-line interface.

    ````
    <copy>
    CONNECT sysdg;
    </copy>
    Password: Use the strong password written down in your notes.
    Connected to "WSDB_fra2qq"
    Connected as SYSDBA.
    ````

5. The SHOW CONFIGURATION command displays a summary and status of the broker configuration.

6. The summary lists all members included in the broker configuration and other information pertaining to the broker configuration itself, including the fast-start failover status and the transport lag and apply lag of all standby databases. Write down in your notes the names of the two databases, Primary and Physical standby, and their role (e.g. `WSDB_fra3hb - Primary`, `WSDB_fra2qq - Physical standby`).

    >**Note** : If you receive an error message `ORA-16525: The Oracle Data Guard broker is not yet available. Configuration details cannot be determined by DGMGRL`, check the status of the WSDB Database on WS-DBStb DB System Details page under Databases list at the bottom. Also make sure Create Data Guard operation has completed on WS-DB DB System Details > Work Requests page. Or wait a couple of miutes, and run again the `SHOW CONFIGURATION` command.

    ````
    <copy>
    SHOW CONFIGURATION;
    </copy>

    Configuration - WSDB_fra3hb_WSDB_fra2qq

      Protection Mode: MaxPerformance
      Members:
      WSDB_fra3hb - Primary database
        WSDB_fra2qq - Physical standby database

    Fast-Start Failover:  Disabled

    Configuration Status:
    SUCCESS   (status updated 27 seconds ago)
    ````

7. The SHOW DATABASE command displays information, property values, or initialization parameter values of the specified database and its instances. Adding VERBOSE keyword to the command, it shows properties of the database in addition to the brief summary. This is the Primary database.

    ````
    <copy>
    SHOW DATABASE VERBOSE 'WSDB_fra3hb';
    </copy>

    Database - WSDB_fra3hb

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        WSDB

      Properties:
        DGConnectIdentifier             = 'WSDB_fra3hb'
        ObserverConnectIdentifier       = ''
        FastStartFailoverTarget         = ''
        PreferredObserverHosts          = ''
        LogShipping                     = 'ON'
        RedoRoutes                      = ''
        LogXptMode                      = 'ASYNC'
        DelayMins                       = '0'
        Binding                         = 'optional'
        MaxFailure                      = '0'
        ReopenSecs                      = '300'
        NetTimeout                      = '30'
        RedoCompression                 = 'DISABLE'
        PreferredApplyInstance          = ''
        ApplyInstanceTimeout            = '0'
        ApplyLagThreshold               = '30'
        TransportLagThreshold           = '30'
        TransportDisconnectedThreshold  = '30'
        ApplyParallel                   = 'AUTO'
        ApplyInstances                  = '0'
        StandbyFileManagement           = ''
        ArchiveLagTarget                = '0'
        LogArchiveMaxProcesses          = '0'
        LogArchiveMinSucceedDest        = '0'
        DataGuardSyncLatency            = '0'
        LogArchiveTrace                 = '0'
        LogArchiveFormat                = ''
        DbFileNameConvert               = ''
        LogFileNameConvert              = ''
        ArchiveLocation                 = ''
        AlternateLocation               = ''
        StandbyArchiveLocation          = ''
        StandbyAlternateLocation        = ''
        InconsistentProperties          = '(monitor)'
        InconsistentLogXptProps         = '(monitor)'
        LogXptStatus                    = '(monitor)'
        SendQEntries                    = '(monitor)'
        RecvQEntries                    = '(monitor)'
        HostName                        = 'dbs01h'
        StaticConnectIdentifier         = '(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=dbs01h)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=WSDB_fra3hb_DGMGRL.sub07141037280.rehevcn.oraclevcn.com)(INSTANCE_NAME=WSDB)(SERVER=DEDICATED)))'
        TopWaitEvents                   = '(monitor)'
        SidName                         = '(monitor)'

      Log file locations:
        Alert log               : /u01/app/oracle/diag/rdbms/WSDB_fra3hb/WSDB/trace/alert_WSDB.log
        Data Guard Broker log   : /u01/app/oracle/diag/rdbms/WSDB_fra3hb/WSDB/trace/drcWSDB.log

    Database Status:
    SUCCESS
    ````

8. Show the brief summary of the Physical stadnby database.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra2qq';
    </copy>

    Database - WSDB_fra2qq

      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 7 seconds ago)
      Apply Lag:          9 seconds (computed 7 seconds ago)
      Average Apply Rate: 0 Byte/s
      Real Time Query:    ON
      Instance(s):
        WSDB

    Database Status:
    SUCCESS
    ````

9. The SHOW FAST_START FAILOVER command displays all fast-start failover related information.

    ````
    <copy>
    SHOW FAST_START FAILOVER;
    </copy>

    Fast-Start Failover:  Disabled

      Protection Mode:    MaxPerformance
      Lag Limit:          30 seconds

      Threshold:          30 seconds
      Active Target:      (none)
      Potential Targets:  (none)
      Observer:           (none)
      Shutdown Primary:   TRUE
      Auto-reinstate:     TRUE
      Observer Reconnect: (none)
      Observer Override:  FALSE

    Configurable Failover Conditions
      Health Conditions:
        Corrupted Controlfile          YES
        Corrupted Dictionary           YES
        Inaccessible Logfile            NO
        Stuck Archiver                  NO
        Datafile Write Errors          YES

      Oracle Error Conditions:
        (none)
    ````

10. Exit DGMGRL.

    ````
    <copy>
    EXIT
    </copy>
    ````

## Task 3: Perform Switchover Operation

1. Click ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DB** DB System.

2. On the DB System Details page, click the database name link **WSDB** in the bottom table called Databases.

3. Click **Data Guard Associations** in the lower left menu. Observe Peer DB System and it's details like Peer Role, Shape, Availability Domain. Click right menu **⋮** > **Switchover**. Enter the database admin password: Use the strong password written down in your notes.

4. Status will change to Updating... Click **Work Requests** in the lower left menu, and the Operation name link. Here you can see Log Messages, Error Messages, Associated Resources.

5. You can use the breadcrumbs links in the upper section of the page to navigate to superior levels: Overview > Bare Metal, VM and Exadata > DB Systems > DB System Details > Database Home Details > Database Details. Click **Database Details**, wait for Status to become Available.

6. Launch DGMGRL.

    ````
    <copy>
    dgmgrl
    </copy>
    ````

7. Log in as user SYSDG with the SYSDG administrative privilege.

    ````
    <copy>
    CONNECT sysdg;
    </copy>
    Password: Use the strong password written down in your notes.
    Connected to "WSDB_fra2qq"
    Connected as SYSDBA.
    ````

8. Show the current configuration. Observe the roles of the two databases are swapped.

    ````
    <copy>
    SHOW CONFIGURATION;
    </copy>

    Configuration - WSDB_fra3hb_WSDB_fra2qq

      Protection Mode: MaxPerformance
      Members:
      WSDB_fra2qq - Primary database
        WSDB_fra3hb - Physical standby database

    Fast-Start Failover:  Disabled

    Configuration Status:
    SUCCESS   (status updated 56 seconds ago)
    ````

9. View the Primary database information.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra2qq';
    </copy>

    Database - WSDB_fra2qq

      Role:               PRIMARY
      Intended State:     TRANSPORT-ON
      Instance(s):
        WSDB

    Database Status:
    SUCCESS
    ````

## Task 4: Enable Fast-Start Failover

Fast-start failover allows the broker to automatically fail over to a previously chosen standby database in the event of loss of the primary database. Fast-start failover quickly and reliably fails over the target standby database to the primary database role, without requiring you to perform any manual steps to invoke the failover. Fast-start failover can be used only in a broker configuration and can be configured only through DGMGRL or Enterprise Manager Cloud Control.

1. Use DGMGRL to enable fast-start failover.

    ````
    <copy>
    ENABLE FAST_START FAILOVER;
    </copy>
    Enabled in Potential Data Loss Mode.
    ````

2. Because our Protection Mode is MaxPerformance and LogXptMode database property is ASYNC, Fast-Start Failover is Enabled in Potential Data Loss Mode.

    >**Note** : Enabling fast-start failover in a configuration operating in maximum performance mode provides better overall performance on the primary database because redo data is sent asynchronously to the target standby database. Note that this does not guarantee no data will be lost.

    ````
    <copy>
    SHOW FAST_START FAILOVER;
    </copy>

    Fast-Start Failover: Enabled in Potential Data Loss Mode

      Protection Mode:    MaxPerformance
      Lag Limit:          30 seconds

      Threshold:          30 seconds
      Active Target:      WSDB_fra3hb
      Potential Targets:  "WSDB_fra3hb"
        WSDB_fra3hb valid
      Observer:           (none)
      Shutdown Primary:   TRUE
      Auto-reinstate:     TRUE
      Observer Reconnect: (none)
      Observer Override:  FALSE

    Configurable Failover Conditions
      Health Conditions:
        Corrupted Controlfile          YES
        Corrupted Dictionary           YES
        Inaccessible Logfile            NO
        Stuck Archiver                  NO
        Datafile Write Errors          YES

      Oracle Error Conditions:
        (none)
    ````

3. By default, the fast-start failover target for the Primary database is the Physical standby database.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra2qq' FastStartFailoverTarget;
    </copy>
      FastStartFailoverTarget = 'WSDB_fra3hb'
    ````

4. And vice versa.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra3hb' FastStartFailoverTarget;
    </copy>
      FastStartFailoverTarget = 'WSDB_fra2qq'
    ````

## Task 5: Change Protection Mode

Oracle Data Guard provides three protection modes: maximum availability, maximum performance, and maximum protection.

Maximum Performance mode provides the highest level of data protection that is possible without affecting the performance of a primary database. This is accomplished by allowing transactions to commit as soon as all redo data generated by those transactions has been written to the online log. Redo data is also written to one or more standby databases, but this is done asynchronously with respect to transaction commitment, so primary database performance is unaffected by the time required to transmit redo data and receive acknowledgment from a standby database.

Maximum Availability mode provides the highest level of data protection that is possible without compromising the availability of a primary database. Under normal operations, transactions do not commit until all redo data needed to recover those transactions has been written to the online redo log AND based on user configuration, one of the following is true:
- redo has been received at the standby, I/O to the standby redo log has been initiated, and acknowledgement sent back to primary;
- redo has been received and written to standby redo log at the standby and acknowledgement sent back to primary.

1. Use DGMGRL to disable fast-start failover.

    ````
    <copy>
    DISABLE FAST_START FAILOVER;
    </copy>
    Disabled.
    ````

2. Configure the redo transport service to SYNC on Primary database.

    ````
    <copy>
    EDIT DATABASE 'WSDB_fra2qq' SET PROPERTY LogXptMode='SYNC';
    </copy>
    Property "logxptmode" updated
    ````

3. Configure also the redo transport service to SYNC on Physical standby database.

    ````
    <copy>
    EDIT DATABASE 'WSDB_fra3hb' SET PROPERTY LogXptMode='SYNC';
    </copy>
    Property "logxptmode" updated
    ````

4. Upgrade the broker configuration to the MAXAVAILABILITY protection mode.

    ````
    <copy>
    EDIT CONFIGURATION SET PROTECTION MODE AS MaxAvailability;
    </copy>
    Succeeded.
    ````

5. Display the configuration information. If this command is executed immediately, it will display a warning message. The information was not fully updated, and you need to wait a few seconds to verify the configuration.

    ````
    <copy>
    SHOW CONFIGURATION;
    </copy>

    Configuration - WSDB_fra3hb_WSDB_fra2qq

      Protection Mode: MaxAvailability
      Members:
      WSDB_fra2qq - Primary database
        Warning: ORA-16629: database reports a different protection level from the protection mode

        WSDB_fra3hb - Physical standby database

    Fast-Start Failover:  Disabled

    Configuration Status:
    WARNING   (status updated 54 seconds ago)
    ````

6. After a minute, display again the configuration information. As you can see, the protection mode was updated.

    ````
    <copy>
    SHOW CONFIGURATION;
    </copy>

    Configuration - WSDB_fra3hb_WSDB_fra2qq

      Protection Mode: MaxAvailability
      Members:
      WSDB_fra2qq - Primary database
        WSDB_fra3hb - Physical standby database

    Fast-Start Failover:  Disabled

    Configuration Status:
    SUCCESS   (status updated 56 seconds ago)
    ````

## Task 6: Stop Redo Apply on Standby

1. It is possible to temporarily stop the Redo Apply on a Physical standby database. To change the state of the standby database to APPLY-OFF, enter the EDIT DATABASE command as shown in the following line.

    ````
    <copy>
    EDIT DATABASE 'WSDB_fra3hb' SET STATE='APPLY-OFF';
    </copy>
    Succeeded.
    ````

2. Use SHOW DATABASE command to display information, property values, or initialization parameter values of the Physical standby database. Redo data is still being received when you put the physical standby database in the APPLY-OFF state. But redo data is not applied, and you will notice the increasing values of Apply Lag. Also Average Apply Rate has an unknown value.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra3hb';
    </copy>

    Database - WSDB_fra3hb

      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-OFF
      Transport Lag:      0 seconds (computed 1 second ago)
      Apply Lag:          1 minute 57 seconds (computed 1 second ago)
      Average Apply Rate: (unknown)
      Real Time Query:    OFF
      Instance(s):
        WSDB

    Database Status:
    SUCCESS
    ````
3. Use again the EDIT DATABASE command to change the state of the Physical standby database, so it resumes the apply of redo data.

    ````
    <copy>
    EDIT DATABASE 'WSDB_fra3hb' SET STATE='APPLY-ON';
    </copy>
    Succeeded.
    ````

4. Verify the APPLY-ON state and Apply Lag that has to be as low as possible, ideally 0. Check the Average Apply Rate.

    ````
    <copy>
    SHOW DATABASE 'WSDB_fra3hb';
    </copy>

    Database - WSDB_fra3hb

      Role:               PHYSICAL STANDBY
      Intended State:     APPLY-ON
      Transport Lag:      0 seconds (computed 1 second ago)
      Apply Lag:          0 seconds (computed 1 second ago)
      Average Apply Rate: 8.00 KByte/s
      Real Time Query:    ON
      Instance(s):
        WSDB

    Database Status:
    SUCCESS
    ````

5. Exit DGMGRL.

    ````
    <copy>
    EXIT
    </copy>
    ````

## Task 7: Test Fast-Start Failover with Maximum Availability

1. On Oracle cloud console, click ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DBStb** DB System.

2. On the DB System Details page, click the database name link **WSDB** in the bottom table called Databases.

3. Click **Data Guard Associations** in the lower left menu. Click **⋮** > **Switchover**. Enter the database admin password: Use the strong password written down in your notes. Wait for the status to become Available.

4. Launch DGMGRL.

    ````
    <copy>
    dgmgrl
    </copy>
    ````

5. Log in as user SYSDG with the SYSDG administrative privilege.

    ````
    <copy>
    CONNECT sysdg;
    </copy>
    Password: Use the strong password written down in your notes.
    Connected to "WSDB_fra2qq"
    Connected as SYSDBA.
    ````

6. Now, with MAXAVAILABILITY protection mode, let's test again enabling fast-start failover. This time it is enabled in Zero Data Loss Mode.

    ````
    <copy>
    ENABLE FAST_START FAILOVER;
    </copy>
    Enabled in Zero Data Loss Mode.
    ````

7. Type **exit** command tree times followed by Enter to close all sessions (DGMGRL, oracle user, and SSH).

    ````
    <copy>
    EXIT
    </copy>

    exit

    exit
    ````

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
