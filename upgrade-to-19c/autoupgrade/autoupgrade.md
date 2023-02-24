# Upgrade using the Autoupgrade tool #

## Introduction ##

In this lab, we will leverage the Autoupgrade tool and upgrade an existing 12.1 CDB with 2 PDBs to 19c in a single command and configuration file.

Estimated time: 75 minutes (please note you can run other labs in this training in parallel to this lab to reduce waiting time)

### Objectives ###

- Startup the existing databases in the hands-on lab environment
- Create the Autoupgrade configuration file
- Run the Autoupgrade pre-check phase and look at the results
- Run the Autoupgrade deploy phase and watch the database being upgraded

### Prerequisites ###

- You have access to the Upgrade to a 19c Hands-on-Lab client image
- A new 19c database has been created in this image (previous lab)
- All databases in the image are running

When in doubt or need to start the databases, use the following steps:

1. Please log in as **oracle** user and execute the following command:

    ```
    $ <copy>. oraenv</copy>
    ```
2. Please enter the SID of the 19c database that you have created in the first lab. In this example, the SID is **`19C`**

    ```
    ORACLE_SID = [oracle] ? <copy>DB19C</copy>
    The Oracle base has been set to /u01/app/oracle
    ```
3. Now execute the command to start all databases listed in the `/etc/oratab` file:

    ```
    $ <copy>dbstart $ORACLE_HOME</copy>

    Processing Database instance "DB112": log file /u01/app/oracle/product/11.2.0/dbhome_112/rdbms/log/startup.log
    Processing Database instance "DB121C": log file /u01/app/oracle/product/12.1.0/dbhome_121/rdbms/log/startup.log
    Processing Database instance "DB122": log file /u01/app/oracle/product/12.2.0/dbhome_122/rdbms/log/startup.log
    Processing Database instance "DB18C": log file /u01/app/oracle/product/18.1.0/dbhome_18c/rdbms/log/startup.log
    Processing Database instance "DB19C": log file /u01/app/oracle/product/19.3.0/dbhome_19c/rdbms/log/startup.log
    ```
 
## Task 1: Prepare the Source database ##
We will use the preinstalled 12.1.0.2 database for this exercise (although we could have used the 11.2 database or any other database).

### Open all PDBS ###

1. First, we set the environment variables for the 12.1 source environment:
    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [oracle] ? <copy>DB121C</copy>
    The Oracle base remains unchanged with value /u01/app/oracle
    ```

2. We can now log into SQL*Plus as sys user in sysdba mode:
    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

    The upgrade commands will only upgrade databases (and Pluggable Databases) in OPEN mode during the upgrade process. Therefore please check that all PDBs are in OPEN mode before you start the upgrade.

3. Execute the following command to check if all PDBs are open
    ```
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 DB121C01                       MOUNTED
    ```

    The DB121C01 PDB is in MOUNTED mode. This means we need to open the PDB first before we can upgrade it.

4. If the DB121C01 PDB is in MOUNT mode, execute the following commands:
    ```
    SQL> <copy>alter pluggable database all open;</copy>

    Pluggable database altered.
    ```

    And check again to see if it worked:

    ```
    SQL> <copy>show pdbs</copy>

        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 DB121C01                       READ WRITE NO
    ```

5. You can now exit SQLPlus and continue on the operating system:

    ```
    SQL> <copy>exit</copy>

    Disconnected from Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production
    With the Partitioning, OLAP, Advanced Analytics and Real Application Testing options
    ```

## Task 2: The Autoupgrade tool ##

### Create the Auto Upgrade Config file ###
The Auto Upgrade tool is part of the 19c Oracle Home distribution. Previous versions (<= 18.4) will need a separate download and set up from MyOracle Support under note 2485457.1. In this example, we will only put one database into the configuration file, but you can add as many databases as needed.

1. First, we will create a directory on the operating system where we can store Autoupgrade related files (and log files):

    ```
    $  <copy>mkdir -p /u01/autoupgrade</copy>
    ```
    ```
    $ <copy>cd /u01/autoupgrade/</copy>
    ```

2. Now we can create a new configuration file for the Auto Upgrade tool. In this example, the "vi" tool is used. If you are not familiar with "vi", feel free to exchange the command with "gedit":

    ```
    $ <copy>vi DB121C.cfg</copy>
    ```

    If you are not familiar with the 'vi' tool, press the 'i' key to set vi to 'insert' mode.

    Make sure to paste the following lines to the new file:
    ```
    <copy>global.autoupg_log_dir=/u01/autoupgrade
    upg1.dbname=DB121C
    upg1.source_home=/u01/app/oracle/product/12.1.0/dbhome_121
    upg1.target_home=/u01/app/oracle/product/19.0.0/dbhome_193
    upg1.sid=DB121C
    upg1.log_dir=/u01/autoupgrade
    upg1.upgrade_node=localhost
    upg1.target_version=19.3
    upg1.run_utlrp=yes
    upg1.timezone_upg=yes
    upg1.restoration=no</copy>
    ```

    Save the file and close the editor. Using the 'vi' tool, you do this with the following key sequence: "(ESC):wq" and ENTER.

    Be aware that in the above example, we used the `upg1.restoration=no`. This means that we will **not be able to restore** the database if something goes wrong. This setting is only to be used in databases that are in NOARCHIVE mode or databases (like Standard Edition databases) that cannot have a guaranteed restore point (GRP).

    In our setup, we use it to speed up the upgrade process (since no archive log needs to be written) and to save disk space in our limited environment.

### Launch the Auto Upgrade tool pre-check phase ###

3. We can now launch the Auto upgrade tool. First, make sure you have the 19c environment variables setup:

    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [ORCL] ? <copy>DB19C</copy>
    The Oracle base remains unchanged with value /u01/app/oracle
    ```

4. Execute the tool by executing the following command:

    ```
    $ <copy>java -jar $ORACLE_HOME/rdbms/admin/autoupgrade.jar -config DB121C.cfg -mode analyze -noconsole</copy>

    AutoUpgrade tool launched with default options
    Processing config file ...
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 databases will be analyzed
    Job 100 completed
    ------------------- Final Summary --------------------
    Number of databases            [ 1 ]

    Jobs finished successfully     [1]
    Jobs failed                    [0]
    Jobs pending                   [0]
    ------------- JOBS FINISHED SUCCESSFULLY -------------
    Job 100 for DB121C
    ```

    In the parameter file, we specified the location for the log files, in this case `/u01/autoupgrade`. After running the command, the output stated a Job number (100). A new directory has been created in the logfile directory with this name; it contains all of the log files for this run. In the prechecks directory, the output of the prechecks are displayed in various formats:

5. Check the contents of the log directory

    ```
    $ <copy>cat /u01/autoupgrade/DB121C/100/prechecks/db121c_preupgrade.log</copy>

    [dbname]          [DB121C]
    ==========================================
    [container]          [CDB$ROOT]
    ==========================================
    [checkname]          CYCLE_NUMBER
    [stage]              PRECHECKS
    [fixup_available]    NO
    [runfix]             N/A
    [severity]           INFO
    [rule]               The number of PDBs upgraded in parallel and the number of
                         parallel processes per PDB can be adjusted as described in
                         Database Upgrade Guide.
    [broken rule]        Using default parallel upgrade options, this CDB with 2 PDBs will
                         first upgrade the CDB$ROOT, and then upgrade at most 2 PDBs at
                         a time using 2 parallel processes per PDB.
    [action]             No action needed.
    ----------------------------------------------------

    [checkname]          DICTIONARY_STATS
    [stage]              PRECHECKS
    [fixup_available]    YES
    [runfix]             YES
    [severity]           RECOMMEND
    [rule]               Dictionary statistics help the Oracle optimizer find efficient
                         SQL execution plans and are essential for proper upgrade timing.
                         Oracle recommends gathering dictionary statistics in the last 24
                         hours before database upgrade.<br><br>For information on managing
                         optimizer statistics, refer to the 12.1.0.2 Oracle Database SQL
                         Tuning Guide.
    [broken rule]        Dictionary statistics do not exist or are stale (not up-to-date).
    [action]             Gather stale data dictionary statistics prior to database upgrade
                         in off-peak time using:
                         EXECUTE DBMS_STATS.GATHER_DICTIONARY_STATS;
    ....
    ```

    If you get a 'file not found' or another error, please navigate manually to the /u01/autoupgrade/DB121C directory and check which subdirectories have been created. Navigate to the ```<jobnumber>/prechecks``` directory and do a ```cat db121c_preupgrade.log``` instead.

    In a typical upgrade situation, you can now check whether or not there are blocking issues concerning your upgrade. The step executed here is the same as running the preupgrade.jar manually or through the DBUA.

    In this hands-on lab, no changes are required so we can continue with the actual upgrade process.
 
### Execute the full upgrade using Auto Upgrade ###

6. To continue with the full upgrade of the database(s) in the config file, run the same command but this time with the 'mode=deploy' option.

    ```
    $ <copy>java -jar $ORACLE_HOME/rdbms/admin/autoupgrade.jar -config DB121C.cfg -mode deploy</copy>

    Autoupgrade tool launched with default options
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 databases will be processed
    Type' help' to list console commands

    upg>
    ```
7. The tool will now upgrade the requested databases in the background. You can request the status by executing the 'lsj' command:

    ```
    upg> <copy>lsj</copy>
    ```

    The following is an example output:

    ```
    <copy> </copy>
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    |JOB#|DB NAME|    STAGE|OPERATION| STATUS|    START TIME|END TIME| UPDATED|          MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    | 101| DB121C|PRECHECKS|PREPARING|RUNNING|19/04/19 11:51|     N/A|11:51:09|Remaining 198/246|
    +----+-------+---------+---------+-------+--------------+--------+--------+-----------------+
    ```

    Using the command prompt, you can do many things to control your upgrade. If there is any failure, you can correct the failures, restart the job, or restore the environment to its original state. On the operating system, you can check the running of the upgrade as well.

8. To get a more detailed status of the job, you can use the `status` command with the job number of your upgrade. Example:

    ```
    upg> <copy>status -job 101</copy>
    Progress
    -----------------------------------
    Start time:      19/04/19 12:10
    Elapsed (min):   15
    End time:        N/A
    Last update:     2019-04-19T12:10:09.421
    Stage:           DBUPGRADE
    Operation:       EXECUTING
    Status:          RUNNING
    Pending stages:  4
    Stage summary:
        SETUP             <1 min
        PREUPGRADE        <1 min
        PRECHECKS         <1 min
        PREFIXUPS         <1 min
        DRAIN             <1 min
        DBUPGRADE         14 min (IN PROGRESS)

    Job Logs Locations
    -----------------------------------
    Logs Base:    /u01/autoupgrade/DB121C
    Job logs:     /u01/autoupgrade/DB121C/101
    Stage logs:   /u01/autoupgrade/DB121C/101/dbupgrade
    TimeZone:     /u01/autoupgrade/DB121C/temp

    Additional information
    -----------------------------------
    Details:
    [Upgrading] is [37%] completed for [db121c-cdb$root]
                    +---------+---------------+
                    |CONTAINER|     PERCENTAGE|
                    +---------+---------------+
                    | CDB$ROOT|  UPGRADE [37%]|
                    | PDB$SEED|UPGRADE PENDING|
                    | DB121C01|UPGRADE PENDING|
                    +---------+---------------+

    Error Details:
    None
    ```

    The actual upgrade will be done using the standard tools for upgrading databases. You can see this in the operating system once the `lsj` command indicates that the actual upgrade has started.

9. First check if the autoupgrade process has started with the actual upgrade of the database:

    ```
    upg> <copy>lsj</copy>
    ```

    Wait until the 'STAGE' column of the lsj command displays the status 'DBUPGRADE', which takes about 6 minutes. The output should be similar to this:

    ```
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    |JOB#|DB NAME|    STAGE|OPERATION| STATUS|    START TIME|END TIME| UPDATED|MESSAGE|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    | 101| DB121C|DBUPGRADE|EXECUTING|RUNNING|19/04/19 12:06|     N/A|12:05:51|Running|
    +----+-------+---------+---------+-------+--------------+--------+--------+-------+
    ```

10. You can open a second terminal window (do not close the running autoupgrade tool) that the standard tools are being used by the autoupgrade tool for the upgrade:

    ```
    $ <copy>ps -ef | grep perl</copy>

    oracle   17211 11951  0 10:13 pts/4    00:00:01 /u01/app/oracle/product/19.0.0/dbhome_193/perl/bin/perl /u01/app/oracle/product/19.0.0/dbhome_193/rdbms/admin/catctl.pl -A -l /u01/autoupgrade/100/dbupgrade -i 20190321101158db112 -d /u01/app/oracle/product/19.0.0/dbhome_193/rdbms/admin catupgrd.sql
    ```

    The output will be similar to the example, but only if the actual upgrade step is running. There will be no output during the precheck or prefixup steps. In case of no output, make sure the 'lsj' command still shows a running process and execute the ps -ef command again.

11. The logfiles in the `/u01/autoupgrade/DB121C/<job#>` directory show you the progress as well, for example:

    ```
    $ <copy>cd /u01/autoupgrade/DB121C/101/dbupgrade</copy>
    ```
    ```
    $ <copy>tail -f autoupgrade_*.log</copy>(Press TAB).log

    2019-04-17 12:44:23.670 INFO Finished - Utilities.autoReadFileToAry
    2019-04-17 12:44:23.670 INFO Finished - Utilities.getPhaseNo
    2019-04-17 12:44:23.672 INFO [Upgrading] is [92%] completed for [db121c-pdb$seed]
    2019-04-17 12:47:23.747 INFO [Upgrading] is [92%] completed for [db121c-pdb$seed]
    +---------+---------------------------------------+
    |CONTAINER|                             PERCENTAGE|
    +---------+---------------------------------------+
    | CDB$ROOT|SUCCESSFULLY UPGRADED [db121c-cdb$root]|
    | PDB$SEED|                          UPGRADE [92%]|
    | DB121C01|                          UPGRADE [92%]|
    +---------+---------------------------------------+
    ```

    **The whole upgrade using the options chosen in this lab takes about 120 minutes**

    You can continue with other labs or let the instructor know you are waiting for the upgrade to finish.

    After a while, you will see that the upgrade has finished:

    ```
    $ <copy>tail -f autoupgrade_*.log</copy>

    +-------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 databases will be processed

    Job 101 for DB121C FINISHED
    ```

    Your database is now upgraded to 19c (with all PDBs as well).

## Task 3: Check target database ##

1. To check your target database, you can execute the following:

    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [DB19C] ? <copy>DB121C</copy>
    The Oracle base remains unchanged with value /u01/app/oracle
    ```
    ```
    $ <copy>sqlplus / as sysdba</copy>

    SQL*Plus: Release 19.0.0.0.0 - Production on Fri Mar 22 16:38:53 2019
    Version 19.3.0.0.0

    Copyright (c) 1982, 2019, Oracle.  All rights reserved.

    Connected to:
    Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.3.0.0.0
    ```

    Although we just set the environment variables for the SID DB121C, the SQL*Plus output already shows that the Autoupgrade tool has changed the `\etc\oratab` file and updated the home for the DB121C database (which is now the 19c database)

2. Check the version of the database by querying the `v$instance` view:

    ```
    SQL> <copy>select version from v$instance;</copy>

    VERSION
    -----------------
    19.0.0.0.0
    ```
    The autoupgrade tool was successful. You can check the log files for details regarding this upgrade if you want to.

You may now **proceed to the next lab**.

## Acknowledgements ##

- **Author** - Robert Pastijn, DB Dev Product Management, PTS EMEA - April 2020
- **Last updated** - Robert Pastijn, Database Product Development, PTS EMEA - February 2023
