# Upgrade using the Autoupgrade tool #

## Introduction ##

In this lab, we will leverage the Autoupgrade tool and upgrade 3 databases using 3 different methods from a single call to the autoupgrade tool. 

Estimated time: 75 minutes (please note you can run other labs in this training in parallel to this lab to reduce waiting time)

### Objectives ###

- Startup the existing databases in the hands-on lab environment
- Create the Autoupgrade configuration file
- Run the Autoupgrade pre-check phase and look at the results
- Run the Autoupgrade deploy phase and watch the database being upgraded

### Prerequisites ###

- You have access to the Upgrade to a 23ai Hands-on-Lab Livelabs environment
- A new 23ai Oracle Home and database have been created (previous lab)
- All databases in the image are running

When in doubt or need to start the databases, use the following steps:

1. Please log in as **oracle** user and execute the following command:

    ```
    $ <copy>. oraenv</copy>
    ```
2. Please enter the SID of the 23ai database that you have created in the first lab. In this example, the SID is **`DB23AI`**

    ```
    ORACLE_SID = [oracle] ? <copy>DB23AI</copy>
    The Oracle base has been set to /u01/oracle
    ```
3. Now execute the `dbstart` command to start all databases listed in the `/etc/oratab` file:

    ```
    $ <copy>dbstart $ORACLE_HOME</copy>

    Processing Database instance "AAA": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "BBB": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "CCC": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "RRR": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "TTT": log file /u01/oracle/product/19/dbhome/rdbms/log/startup.log
    Processing Database instance "DB23AI": log file /u01/oracle/product/23/dbhome/rdbms/log/startup.log    ```

### Your source databases ###

In this lab we will migrate 3 databases from 19c to 23ai. Below is the setup of the three databases:

<style> table {font-family: arial, sans-serif;        font-size: 11px;        border-collapse: collapse; } td, th { border: 1px solid #dddddd;          text-align: left;          padding: 8px; } tr:nth-child(even) { background-color: #dddddd; }</style>

<table>
<tr> <th>Name</th>   <th>Type</th>   <th>PDB(s)</th><th>Scenario</th>
</tr><tr><td>AAA</td><td>non-CDB</td><td>n/a</td>   <td>non-CDB to PDB in 23ai home</td>
</tr><tr><td>BBB</td><td>CDB</td>    <td>BBB01</td> <td>Upgrade CDB + PDB</td>
</tr><tr><td>CCC</td><td>CDB</td>    <td>CCC01</td> <td>Unplug from teh 19c CDB, plug into existing 23ai and upgrade</td>
</tr></table>

## Task 1: Prepare Source databases ##
We will use the preinstalled 19c databases for this exercise. Autoupgrade supports upgrading 19c and 21c databases to 23ai so we could have used an 21c database as well.

### Open all Pluggable databases in container database BBB ###

The autoupgrade and other scripts will only upgrade a pluggable database when it is open. First step is to make sure that in our CDBs BBB and CCC the pluggable database(s) are in open state. We do not have to do this for the AAA database as this database is a non-CDB environment and has been started by the dbstart script.

1. Set the environment variable to database BBB and open all pluggable databases:
 
    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [oracle] ? <copy>BBB</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```
2. Login as sysdba
    
    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

3. First check if the PDBs are already open using the following command:
    
    ```
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 BBB01                          MOUNTED
    ```

    The PDB$SEED will always be in READ ONLY mode and the BBB01 pluggable database is in MOUNTED mode (which means closed). This means we need to open the PDB first before we can upgrade it.


4.  If the BBB01 PDB is in MOUNT mode, execute the following commands:
    
    ```
    SQL> <copy>alter pluggable database all open;</copy>

    Pluggable database altered.
    ```

    You can now check again to see if it worked:

    ```
    SQL> <copy>show pdbs</copy>

        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 BBB01                          READ WRITE NO
    ```
    
5.  You can now exit SQL*Plus

    ```
    SQL> <copy>exit</copy>
    
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.21.0.0.0
    ```

6. Do the same for the CCC database that we will use during this lab. Set the environment variable to database BBB and open all pluggable databases:
 
    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [oracle] ? <copy>CCC</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```
7. Login as sysdba
    
    ```
    $ <copy>sqlplus / as sysdba</copy>
    ```

8. First check if the PDBs are already open using the following command:
    
    ```
    SQL> <copy>show pdbs</copy>
    
        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 CCC01                          MOUNTED
    ```

    The PDB$SEED will always be in READ ONLY mode and the CCC01 pluggable database is in MOUNTED mode (which means closed). This means we need to open the PDB first before we can upgrade it.


9.  If the CCC01 PDB is in MOUNT mode, execute the following commands:
    
    ```
    SQL> <copy>alter pluggable database all open;</copy>

    Pluggable database altered.
    ```

    You can now check again to see if it worked:

    ```
    SQL> <copy>show pdbs</copy>

        CON_ID CON_NAME                       OPEN MODE  RESTRICTED
    ---------- ------------------------------ ---------- ----------
             2 PDB$SEED                       READ ONLY  NO
             3 CCC01                          READ WRITE NO
    ```

10. You can now exit SQLPlus and continue on the operating system:

     ```
    SQL> <copy>exit</copy>
    
    Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
    Version 19.21.0.0.0
    ```

## Task 2: The Autoupgrade tool ##
The Auto Upgrade tool is part of the 23ai Oracle Home distribution. Previous versions (<= 18.4) will need a separate download and set-up from MyOracle Support under note 2485457.1. In this example we will put 3 different upgrade scenarios in a single configuration file but you can also use autoupgrade for 1 or many more migrations at the same time.


### Prepare the environment for autoupgrade ###


1. First, we will create a directory on the operating system where we can store Autoupgrade related files (and log files):

    ```
    $  <copy>mkdir -p /u01/autoupgrade</copy>
    ```
    ```
    $ <copy>cd /u01/autoupgrade</copy>
    ```
    In a regular environment, you would now download the latest version of the autoupgrade tool. In this environment, the latest version is in the /source directory. Copy this latest version to the /u01/autoupgrade directory:
    
    ```
    $ <copy>cp /source/autoupgrade* /u01/autoupgrade/autoupgrade.jar
    ```

### Create the Auto Upgrade Config file for database AAA ###

2. Now we can create a new configuration file for the Auto Upgrade tool. In this example, the "vi" tool is used. If you are not familiar with "vi", feel free to exchange the command with "gedit":

    ```
    $ <copy>vi autoupgrade.cfg</copy>
    ```

    If you are unfamiliar with the 'vi' tool, press the 'i' key to set it to 'insert' mode.

    Make sure to paste the following lines to the new file:
    
    ```
    <copy>global.autoupg_log_dir=/u01/autoupgrade/log
    global.log_dir=/u01/autoupgrade/log
    global.restoration=no

    aaa.sid=AAA
    aaa.source_home=/u01/oracle/product/19/dbhome
    aaa.target_home=/u01/oracle/product/23/dbhome
    aaa.target_cdb=DB23AI
    </copy>
    ```

    In this configuration file, we set a number of global parameters that will apply to all upgrade configurations in this file. The first two lines specify where the logging should be written.

    Be aware that in the above example, we used the `global.restoration=no`. This means that we will **not be able to restore** any database if something goes wrong. This setting is only to be used in databases that are in NOARCHIVE mode or databases (like Standard Edition databases) that cannot have a guaranteed restore point (GRP). In a production situation where archive logging is enabled, this parameter should be removed. In our setup, we use it to speed up the upgrade process (since no archive log needs to be written) and to save disk space in our limited environment.

3.  Add the parameters for the database BBB

    For this scenario, we will upgrade both the CDB and the PDBs from 19c to 23ai. This will take longer because first the CDB needs to be upgraded before the PDBs can be upgraded (in parallel). Add the following parameters to the autoupgrade.cfg file:
    
    ```
    <copy>
    bbb.dbname=BBB
    bbb.sid=BBB
    bbb.source_home=/u01/oracle/product/19/dbhome
    bbb.target_home=/u01/oracle/product/23/dbhome
    </copy>
    ```
    
    In this list of parameters for database BBB we are not specifying a target CDB. As a result, the autoupgrade tool will upgrade both the CDB and the PDBs.
    
4. Add the parameters for the database CCC

    In this scenario, we want autoupgrade to unplug the database from the 19c database, plug it into the existing DB23AI CDB and upgrade it. For this, add the following lines to the autoupgrade.cfg file:
    
    ```
    <copy>
    ccc.sid=CCC
    ccc.pdbs=CCC01
    ccc.source_home=/u01/oracle/product/19/dbhome
    ccc.target_home=/u01/oracle/product/23/dbhome
    ccc.target_cdb=DB23AI
    </copy>
    ```

    Save the file and close the editor. Using the 'vi' tool, you do this with the following key sequence: "(ESC):wq" and ENTER.    

### Launch the Auto Upgrade tool pre-check phase ###

3. We can now launch the Auto upgrade tool. First, make sure you have the 23ai environment variables setup as we have copied the latest version of the autoupgrade tool in this Oracle Home:

    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [ORCL] ? <copy>DB23AI</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```

4. Execute the tool by executing the following command:

    ```
    $ <copy>$ORACLE_HOME/jdk/bin/java -jar /u01/autoupgrade/autoupgrade.jar -config autoupgrade.cfg -mode analyze -noconsole</copy>

    AutoUpgrade 24.4.240426 launched with default internal options
    Processing config file ...
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 CDB(s) plus 3 PDB(s) and 1 Non-CDB(s) will be analyzed
    Job 100 database aaa
    Job 101 database ccc
    Job 102 database bbb
    Job 100 completed
    Job 101 completed
    Job 102 completed
    ------------------- Final Summary --------------------
    Number of databases            [ 3 ]

    Jobs finished                  [3]
    Jobs failed                    [0]

    Please check the summary report at:
    /u01/autoupgrade/log/cfgtoollogs/upgrade/auto/status/status.html
    /u01/autoupgrade/log/cfgtoollogs/upgrade/auto/status/status.log
    ```

5. Check the overall status of the jobs

    In the output the Autoupgrade tool provided, you can see the location of a summary report. It is available both in HTML format and in text format. Using the following command, you can view the output of the overall status in your Chrome browser:
    
    ```
    $ <copy>google-chrome /u01/autoupgrade/log/cfgtoollogs/upgrade/auto/status/status.html &</copy>
    ```
    
    If you are working from a non-graphical environment, the same information is available in the log file indicated.
    
    After you have checked that there are no issues, close the Chrome browser to continue,
    
6. Checking the individual pre-upgrade check logfiles

    Every database in the configuration file received a job number. In the general location for the logfiles for autoupgrade, subdirectories have been created for each database that contains the output for that particular database, split per job number.
    
    For example, database AAA has received jobnumber 100. In the directory `/u01/autoupgrade/log/AAA/100` you will find the output of any individual step during the execution of the job. At this moment, because we only ran the pre-upgrade step, the contents are mostly technical and are only needed, mostly by support, if there is an issue during the execution.
     
### Execute the full upgrade using Auto Upgrade ###

6. To continue with the full upgrade of the database(s) in the config file, run the same command but this time with the 'mode=deploy' option.

    ```
    $ <copy>java -jar /u01/autoupgrade/autoupgrade.jar -config autoupgrade.cfg -mode deploy</copy>

    AutoUpgrade 24.4.240426 launched with default internal options
    Processing config file ...
    +--------------------------------+
    | Starting AutoUpgrade execution |
    +--------------------------------+
    1 CDB(s) plus 3 PDB(s) and 1 Non-CDB(s) will be processed
    Type 'help' to list console commands
    upg> 
    ```
    
7. The tool will now upgrade the requested databases in the background. You can request the status by executing the 'lsj' command:

    ```
    upg> <copy>lsj</copy>

    +----+-------+----------+---------+-------+----------+--------+--------------------+
    |Job#|DB_NAME|     STAGE|OPERATION| STATUS|START_TIME| UPDATED|             MESSAGE|
    +----+-------+----------+---------+-------+----------+--------+--------------------+
    | 103|    AAA| DBUPGRADE|EXECUTING|RUNNING|  12:37:20|  2s ago|     82%Upgraded AAA|
    | 104|    CCC| DBUPGRADE|EXECUTING|RUNNING|  12:37:20| 53s ago|     53%Upgraded CCC|
    | 105|    BBB| DBUPGRADE|EXECUTING|RUNNING|  12:37:20|113s ago|77%Upgraded CDB$ROOT|
    +----+-------+----------+---------+-------+----------+--------+--------------------+
    Total jobs 3
    ```

    Using the command prompt, you can control your upgrade in many ways. For example, if the upgrade fails, you can correct the issue and restart the job, or restore the environment to its original state. Of course, you can also check the status of your upgrade(s).
    
8. To show which commands can be used, use the `help` command:

   ```
   $ <copy>help</copy>
   
       exit                            // To close and exit
    help                            // Displays help
    lsj [<option>] [-a <number>]    // list jobs by status up to n elements.
    	-f                Filter by finished jobs.
    	-r                Filter by running jobs.
	    -e                Filter by jobs with errors.
	    -p                Filter by jobs being prepared.
	    -n <number>       Display up to n jobs.
	    -a <number>       Repeats the command (in <number> seconds).
    lsr                             // Displays the restoration queue
    lsa                             // Displays the stop queue
    tasks                           // Displays the tasks running
    clear                           // Clears the terminal
    resume -job <number> [-ignore_errors=<ORA-#####,ORA-#####>] // Restarts a job with option to ignore errors
    status [<option>] [-a <number>] // Summary of current execution
    	-config                     Show Config Information
    	-job <number>               Summary of a given job
    	-job <number> -c <dbname>   Show details of container
    	-a [<number>]               Repeats the command (in <number> seconds).
    restore -job <number>           // Restores the database to its state prior to the upgrade
    restore all_failed              // Restores all failed jobs to their previous states prior to the upgrade
    logs                            // Displays all the log locations
    stop -job <number>              // Stops the specified job
    h[ist]                          // Displays the command line history
    /[<number>]                     // Executes the command specified from the history. The default is     the last command
    meta                            // Displays Internal latch count
    hwinfo                          // Displays additional information
    fxlist -job <number> [<option>]                // FixUps summary
    	-c <dbname>                                  Container specific FixUps
    	-c <dbname> alter <check> run <yes|no|skip>  Update Run Configuration
    ```

9. To get the overall status of the running jobs, you can use the `status` command. It will show the status of all upgrades that are currently running and refresh the screen every 15 seconds:

    ```
    upg> <copy>status -a 15</copy>

    Config

    	User configuration file    [/u01/autoupgrade/autoupgrade.cfg]
    	General logs location      [/u01/autoupgrade/log/cfgtoollogs/upgrade/auto]
     	Mode                       [DEPLOY]
    Jobs Summary

	    Total databases in configuration file [5]
	    Total Non-CDB being processed         [0]
	    Total Containers being processed      [5]

	    Jobs finished successfully            [0]
	    Jobs finished/stopped                 [0]
	    Jobs in progress                      [3]

    Progress
	    +---+---------------------------------------------------------+
	    |Job|                                                 Progress|
	    +---+---------------------------------------------------------+
	    |103|[||||||||||||||||||||||                            ] 42 %|
	    |104|[||||||||||||||||||||||                            ] 42 %|
	    |105|[|||||||||||||                                     ] 25 %|
	    +---+---------------------------------------------------------+

    The command status is running every 15 seconds. PRESS ENTER TO EXIT
    ```

10. Showing detailed output

    If you want to see more detailed output for a job, specify the job number in the status command. 
    
    First press \<ENTER\> to exit the refreshing status command. Then execute the following command to see detailed status for job number 103:
    
    ```
    $ <copy>status -job 103</copy>
    
    Details

        Job No           103
        Oracle SID       AAA
        Start Time       24/06/21 12:37:20
        Elapsed (min):   13
        End time:        N/A

    Logfiles

        Logs Base:    /u01/autoupgrade/log/AAA
        Job logs:     /u01/autoupgrade/log/AAA/103
        Stage logs:   /u01/autoupgrade/log/AAA/103/dbupgrade
        TimeZone:     /u01/autoupgrade/log/AAA/temp
        Remote Dirs:  

    Stages
        SETUP            <1 min
        PREUPGRADE       <1 min
        PRECHECKS        <1 min
        PREFIXUPS        1 min
        DRAIN            <1 min
        DBUPGRADE        ~11 min (RUNNING)
        NONCDBTOPDB     
        POSTCHECKS      
        POSTFIXUPS      
        POSTUPGRADE     
        SYSUPDATES      

    Stage-Progress Per Container

	    +--------+---------+
	    |Database|DBUPGRADE|
	    +--------+---------+
	    |     AAA|    41 % |
	    +--------+---------+
    ```

10. If you want to look at the output of the individual stages, you can check the location indicated in the 'Stage Logs'. An example of the contents is below:

    ```
    $ <copy>ls -l /u01/autoupgrade/log/AAA/103/dbupgrade</copy>
    
    total 74860
    -rw-r----- 1 oracle oinstall    33772 Jun 21 12:39 phase.log
    -rw-r----- 1 oracle oinstall        0 Jun 21 12:39 autoupgrade20240621123720aaa.log
    -rw-r----- 1 oracle oinstall      496 Jun 21 12:39 catupgrd20240621123720aaa_catcon_28437.lst
    -rw-r----- 1 oracle oinstall      153 Jun 21 12:56 catupgrd20240621123720aaa_catcon_kill_sess_28437_ALL.sql
    -rw-r----- 1 oracle oinstall 19927386 Jun 21 12:56 catupgrd20240621123720aaa1.log
    -rw-r----- 1 oracle oinstall 38575982 Jun 21 12:56 catupgrd20240621123720aaa0.log
    ```

11. In this lab, we are performing multiple upgrades simultaneously. Some upgrades require upgrading multiple databases (CDB + 2 PDBs), while others only require unplugging/plugging a PDB and upgrading it. 

    In the status page of autoupgrade, you will therefore see that some progress is higher after a while than others:
    
    ```
   	+---+---------------------------------------------------------+
	|Job|                                                 Progress|
	+---+---------------------------------------------------------+
	|103|[||||||||||||||||||||||                            ] 42 %|
	|104|[||||||||||||||||||||||||||||||||||||||            ] 75 %|
	|105|[||||||||||||||||||||||                            ] 42 %|
	+---+---------------------------------------------------------+
    ```
    
    After a while (about 30 minutes) you might even see `Job 104 completed` on the screen, which is reflected in the progress bar overview under the status command like this:
    
    ```
    +---+----------------------------------------------------------+
	|Job|                                                  Progress|
	+---+----------------------------------------------------------+
	|103| [||||||||||||||||||||||                            ] 42 %|
	|104|[|||||||||||||||||||||||||||||||||||||||||||||||||||] 100%|
	|105| [||||||||||||||||||||||                            ] 42 %|
	+---+----------------------------------------------------------+
    ```
    
    After about 45 minutes, job 103 will be finished. Job 105 will take the longest.
    **The whole upgrade using the options chosen in this lab takes about 90 minutes**
    
    <style> table {font-family: arial, sans-serif;        font-size: 11px;        border-collapse: collapse; } td, th { border: 1px solid #dddddd;          text-align: left;          padding: 8px; } tr:nth-child(even) { background-color: #dddddd; }</style>

<table>
<tr> <th>Name</th>   <th>Type</th>    <th>PDB(s)</th><th>Scenario</th><th>Average Upgrade Time</th></tr>
<tr> <td>AAA</td>    <td>non-CDB</td><td>n/a</td>   <td>non-CDB to PDB in 23ai home</td>
</tr><tr><td>BBB</td><td>CDB</td>    <td>BBB01</td> <td>Upgrade CDB + PDB</td>
</tr><tr><td>CCC</td><td>CDB</td>    <td>CCC01</td> <td>Unplug from teh 19c CDB, plug into existing 23ai and upgrade</td>
</tr></table>

    You can continue with other labs or let the instructor know you are waiting for the upgrade to finish.

11.    After a while, you will see that the upgrade has finished:


    ```
    ------------------- Final Summary --------------------
    Number of databases            [ 3 ]

    Jobs finished                  [3]
    Jobs failed                    [0]
    Jobs restored                  [0]
    Jobs pending                   [0]


    Please check the summary report at:
    /u01/autoupgrade/log/cfgtoollogs/upgrade/auto/status/status.html
    /u01/autoupgrade/log/cfgtoollogs/upgrade/auto/status/status.log
    ```

    All databases (CDBs and PDBs) are now upgraded to 23ai.

===== OLD ======

## Task 3: Check target databases ##

1. To check your target DB23AI database, you can execute the following:

    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [DB23AI] ? <copy>DB23AI</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```
    ```
    $ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - Production on Fri Jun 21 14:22:17 2024
    Version 23.5.0.24.06

    Copyright (c) 1982, 2024, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 23ai Enterprise Edition Release 23.0.0.0.0 - Production
    Version 23.5.0.24.06
    ```
    The 23ai database was already running. More interesting are the PDBs that are now active in the CDB:
    
    ```
    SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME       OPEN MODE RESTRICTED
    ------ ------------ ----------- ----------
	      2 PDB$SEED      READ ONLY  NO
	      3 PDB23AI01       MOUNTED
	      4 CCC01        READ WRITE  NO
	      5 AAA          READ WRITE  NO
    ```
    For database AAA, we plugged a non-CDB into the DB23AI CDB so this database is displayed as AAA for its CON_NAME (=PDB name). The scenario for database CCC was that we would unplug the CCC01 Pluggable database and plug it into the DB23AI CDB. In the overview you can see that both database are plugged in and that there are no restrictions. Basically, the upgrade was a succes.
    
2. We can now check the database scenario (BBB) where we upgraded both the CDB and its PDBs to the new version:

    First, exit SQL*Plus:
    
    ```
    SQL> <copy>exit</copy>
    
    Disconnected from Oracle Database 23ai Enterprise Edition Release 23.0.0.0.0 - Production
    Version 23.5.0.24.06
    ```
    
    We can change the SID to database BBB:
    
    ```
    $ <copy>. oraenv</copy>
    ```
    ```
    ORACLE_SID = [DB23AI] ? <copy>BBB</copy>
    The Oracle base remains unchanged with value /u01/oracle
    ```
    ```
    $ <copy>sqlplus / as sysdba</copy>
    
    SQL*Plus: Release 23.0.0.0.0 - Production on Fri Jun 21 14:22:17 2024
    Version 23.5.0.24.06

    Copyright (c) 1982, 2024, Oracle.  All rights reserved.


    Connected to:
    Oracle Database 23ai Enterprise Edition Release 23.0.0.0.0 - Production
    Version 23.5.0.24.06
    ```

    Check the version of the database by querying the `v$instance` view:

    ```
    SQL> <copy>select version from v$instance;</copy>

    VERSION
    -----------------
    23.0.0.0.0
    ```
    
    Show the pluggable databases running in the CDB:
    
    ```
    SQL> <copy>show pdbs</copy>

    CON_ID CON_NAME   OPEN MODE   RESTRICTED
    ------ ---------- ----------- -----------
         2 PDB$SEED   READ ONLY   NO
         3 BBB01      READ WRITE  NO
    ```
    

    The autoupgrade tool was successful. If you want, you can check the log files for details regarding this upgrade.

You may now **proceed to the next lab**.

## Acknowledgements ##

- **Author** - Robert Pastijn, DB Dev Product Management, PTS EMEA - July 2024
