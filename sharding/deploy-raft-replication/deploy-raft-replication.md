# Deploy the Raft Replication

## Introduction

In this lab, you will provision a Globally Distributed Database with Raft replication. 

Estimated Lab Time: 60 minutes.

### Objectives

In this lab, you will perform the following steps:

-   Install the GSM Software in the gsmhost Compute Instance.
-   Configure the Catalog DB and Shard DB.
-   Deploy the GDD with Raft replication.

### Prerequisites

This lab assumes you have already completed the following:

- Setup environment to provision lab resource.

## Task 1: Configure GSM Host

1.   Connect to the GSM host.

     ```
     $ <copy>ssh -i labkey opc@xxx.xxx.xxx.xxx</copy>
     Activate the web console with: systemctl enable --now cockpit.socket
     
     Last login: Thu Aug  8 02:59:55 2024 from xxx.xxx.xxx.xxx
     [opc@gsmhost ~]$ 
     ```

     

2.   Stop and disable the firewall.

     ```
     [opc@gsmhost ~]$ <copy>sudo systemctl stop firewalld</copy>
     [opc@gsmhost ~]$ <copy>sudo systemctl disable firewalld</copy>
     ```

     

3.   Edit the hosts file

     ```
     [opc@gsmhost ~]$ <copy>sudo vi /etc/hosts</copy>
     ```

     Copy an paste the following entries into the host file

     ```
     <copy>10.0.0.20 gsmhost.subnet1.primaryvcn.oraclevcn.com gsmhost
     10.0.0.10 shardhost0.subnet1.primaryvcn.oraclevcn.com shardhost0
     10.0.0.11 shardhost1.subnet1.primaryvcn.oraclevcn.com shardhost1
     10.0.0.12 shardhost2.subnet1.primaryvcn.oraclevcn.com shardhost2
     10.0.0.13 shardhost3.subnet1.primaryvcn.oraclevcn.com shardhost3</copy>
     ```

     

3.   Install the Oracle Database Preinstallation RPM.

     ```
     [opc@gsmhost ~]$ <copy>sudo dnf -y install oracle-database-preinstall-23ai</copy>
     ```

     

4.   Create a directory for oracle installation

     ```
     [opc@gsmhost ~]$ <copy>sudo mkdir /u01</copy>
     [opc@gsmhost ~]$ <copy>sudo chmod 777 /u01</copy>
     ```

     

5.   Sudo to the oracle user

     ```
     [opc@gsmhost ~]$ <copy>sudo su - oracle</copy>
     ```

     

6.   Download the DB23ai GSM installation file from the [Oracle Database 23ai Download for Linux x86-64 Page](https://www.oracle.com/database/technologies/oracle23ai-linux-downloads.html), or using the following url:

     ```
     <copy>wget https://objectstorage.ap-seoul-1.oraclecloud.com/p/BcWt-6XN2rvE98lV73Hux8jkVqK2iwjiQY-Yxc0d9yBGvdqUBirp-qCCJhlCCC73/n/oraclepartnersas/b/DB19c-GSM/o/LINUX.X64_235000_gsm.zip</copy>
     ```

     

7.   Unzip the file.

     ```
     [oracle@gsmhost ~]$ <copy>unzip LINUX.X64_235000_gsm.zip</copy>
     ```

     

8.   Edit the `./gsm/response/gsm_install.rsp` file. Specify the variables like following.

     ```
     ###############################################################################
     ## Copyright(c) Oracle Corporation 1998,2024. All rights reserved.           ##
     ##                                                                           ##
     ## Specify values for the variables listed below to customize                ##
     ## your installation.                                                        ##
     ##                                                                           ##
     ## Each variable is associated with a comment. The comment                   ##
     ## can help to populate the variables with the appropriate                   ##
     ## values.							             ##
     ##                                                                           ##
     ###############################################################################
     
     #-------------------------------------------------------------------------------
     # Do not change the following system generated value. 
     #-------------------------------------------------------------------------------
     oracle.install.responseFileVersion=/oracle/install/rspfmt_gsminstall_response_schema_v23.0.0
     
     #-------------------------------------------------------------------------------
     # Unix group to be set for the inventory directory.  
     #-------------------------------------------------------------------------------
     UNIX_GROUP_NAME=oinstall
     #-------------------------------------------------------------------------------
     # Inventory location.
     #-------------------------------------------------------------------------------
     INVENTORY_LOCATION=/u01/app/oraInventory
     #-------------------------------------------------------------------------------
     # Complete path of the Oracle Home  
     #-------------------------------------------------------------------------------
     ORACLE_HOME=/u01/app/oracle/product/23.0.0/gsmhome_1
     #-------------------------------------------------------------------------------
     # Complete path of the Oracle Base. 
     #-------------------------------------------------------------------------------
     ORACLE_BASE=/u01/app/oracle
     ```

     

9.   Create the gsm home directory

     ```
     [oracle@gsmhost ~]$ <copy>mkdir -p /u01/app/oracle/product/23.0.0/gsmhome_1</copy>
     ```
     
     
     
9.    Install GSM

     ```
     [oracle@gsmhost ~]$ <copy>./gsm/runInstaller -silent -responseFile /home/oracle/gsm/response/gsm_install.rsp -showProgress</copy>
     ```
     
     Output like this:
     
     ```
     Starting Oracle Universal Installer...
     
     Checking Temp space: must be greater than 551 MB.   Actual 21829 MB    Passed
     Preparing to launch Oracle Universal Installer from /tmp/OraInstall2024-08-08_05-03-41AM. Please wait ...[oracle@gsmhost ~]$ The response file for this session can be found at:
      /u01/app/oracle/product/23.0.0/gsmhome_1/install/response/gsm_2024-08-08_05-03-41AM.rsp
     
     You can find the log of this install session at:
      /tmp/OraInstall2024-08-08_05-03-41AM/installActions2024-08-08_05-03-41AM.log
     
     Prepare in progress.
     ..................................................   8% Done.
     
     Prepare successful.
     
     Copy files in progress.
     ..................................................   20% Done.
     ..................................................   25% Done.
     ..................................................   30% Done.
     ..................................................   36% Done.
     ..................................................   41% Done.
     ..................................................   47% Done.
     ..................................................   55% Done.
     ..................................................   60% Done.
     ..................................................   65% Done.
     ..................................................   70% Done.
     ..................................................   75% Done.
     ..............................
     Copy files successful.
     
     Link binaries in progress.
     ..........
     Link binaries successful.
     
     Setup files in progress.
     ..................................................   80% Done.
     ..............................
     Setup files successful.
     
     Setup Inventory in progress.
     
     Setup Inventory successful.
     
     Finish Setup in progress.
     ..........
     Finish Setup successful.
     The installation of Oracle Distributed Service and Load Management was successful.
     Please check '/u01/app/oraInventory/logs/silentInstall2024-08-08_05-03-41AM.log' for more details.
     
     Setup Oracle Base in progress.
     
     Setup Oracle Base successful.
     ..................................................   95% Done.
     
     As a root user, run the following script(s):
     	1. /u01/app/oraInventory/orainstRoot.sh
     	2. /u01/app/oracle/product/23.0.0/gsmhome_1/root.sh
     
     
     
     Successfully Setup Software.
     ..................................................   100% Done.
     The log of this install session can be found at:
      /u01/app/oraInventory/logs/installActions2024-08-08_05-03-41AM.log
     ```
     
     
     
10.   Click **Enter** when finish. Exit to **opc** user first, then switch to **root** user and run the scripts

      ```
      [root@gsmhost ~]# <copy>/u01/app/oraInventory/orainstRoot.sh</copy>
      [root@gsmhost ~]# <copy>/u01/app/oracle/product/23.0.0/gsmhome_1/root.sh</copy>
      ```

      

11.   Switch back to **oracle** user, edit the `.bash_profile`, add the following environment variables.

      ```
      <copy>export ORACLE_BASE=/u01/app/oracle
      export ORACLE_HOME=/u01/app/oracle/product/23.0.0/gsmhome_1
      export LD_LIBRARY_PATH=$ORACLE_HOME/lib
      export PATH=$ORACLE_HOME/bin:$PATH</copy>
      ```

      

12.   Active the variables.

      ```
      [oracle@gsmhost ~]$ <copy>source .bash_profile</copy>
      ```

      

15.   Exit from the terminal.

## Task 2: Execute Prep Scripts for Oracle Sharding on Catalog Host

**Remember we use shardhost0 as catalog host.**

1.   Upload your private key to the gsmhost.

     ```
     <copy>scp -i <your_private_key> <your_private_key> opc@<gsmhost_public_ip>:~</copy>
     ```

     

2.   Connect to the gsmhost first

     ```
     <copy>ssh -i <your_private_key> opc@<gsmhost_public_ip></copy>
     ```

     

3.   from **opc** user, connec to the catalog host, 

     ```
     [opc@gsmhost ~]$ ssh -i labkey opc@shardhost0
     The authenticity of host 'shardhost0 (10.0.0.10)' can't be established.
     ECDSA key fingerprint is SHA256:nUgw525hsLNOOoW277E5j35wxfblNHk2CXqN0RPt7VU.
     Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
     Warning: Permanently added 'shardhost0,10.0.0.10' (ECDSA) to the list of known hosts.
     Last login: Tue Jun  4 05:47:51 2024 from 144.25.17.122
     [opc@shardhost0 ~]$ 
     ```

     

4.   Edit the hosts file

     ```
     [opc@shardhost0 ~]$ <copy>sudo vi /etc/hosts</copy>
     ```

     Copy an paste the following entries into the host file

     ```
     <copy>10.0.0.20 gsmhost.subnet1.primaryvcn.oraclevcn.com gsmhost
     10.0.0.10 shardhost0.subnet1.primaryvcn.oraclevcn.com shardhost0
     10.0.0.11 shardhost1.subnet1.primaryvcn.oraclevcn.com shardhost1
     10.0.0.12 shardhost2.subnet1.primaryvcn.oraclevcn.com shardhost2
     10.0.0.13 shardhost3.subnet1.primaryvcn.oraclevcn.com shardhost3</copy>
     ```

     

5.   Then switch to **oracle** user

     ```
     [opc@shardhost0 ~]$ <copy>sudo su - oracle</copy>
     Last login: Thu Aug  8 05:35:06 UTC 2024
     [oracle@shardhost0 ~]$
     ```

     

6.   Connect to oracle database as sysdba

     ```
     [oracle@shardhost0 ~]$ <copy>sqlplus / as sysdba</copy>
     
     SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Thu Aug 8 05:30:55 2024
     Version 23.5.0.24.07
     
     Copyright (c) 1982, 2024, Oracle.  All rights reserved.
     
     
     Connected to:
     Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
     Version 23.5.0.24.07
     
     SQL> 
     ```

     

7.   Initialization parameter adjustments for CDB

     ```
     <copy>alter system set open_links=16 scope=spfile;
     alter system set open_links_per_instance=16 scope=spfile;
     alter system set db_files=1024 scope=spfile;
     alter system set standby_file_management=auto scope=both;
     alter user gsmcatuser account unlock;
     alter user gsmcatuser identified by WelcomePTS_2024#;
     alter database flashback on;
     alter system set global_names=false scope=both;
     alter system set db_domain='' scope=spfile;</copy>
     ```

     

8.   Restart database to activate the parameters.

     ```
     <copy>shutdown immediate;
     startup;</copy>
     ```
     
     

8.   PDB configuration settings

     ```
     <copy>alter session set container=shard0;
     alter user gsmcatuser account unlock;
     create user mysdbadmin identified by WelcomePTS_2024#;
     grant gsmadmin_role to mysdbadmin;</copy>
     ```

     

10.   Exit and back to the gsmhost **opc** user.

## Task 3: Execute Prep Scripts for Oracle Globally Distributed Database on each shard

**Note: You need to connect to each shard to execute the following commands to prepare shards**

1.   From opc user on gsmhost, connect to the shardhost1(shardhost2, shardhost3)

     ```
     [opc@gsmhost ~]$ <copy>ssh -i <your_private_key> opc@shardhost1</copy>
     The authenticity of host 'shardhost1 (10.0.0.11)' can't be established.
     ECDSA key fingerprint is SHA256:lTvAqA49V0GXl1zCmhNbL6zAkMn+dJmIgUUZevrx6+Q.
     Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
     Warning: Permanently added 'shardhost1,10.0.0.11' (ECDSA) to the list of known hosts.
     Last failed login: Thu Aug  8 05:42:11 UTC 2024 from 170.64.146.217 on ssh:notty
     There were 2 failed login attempts since the last successful login.
     Last login: Tue Jun  4 05:47:51 2024 from 144.25.17.122
     [opc@shardhost1 ~]$ 
     ```

     

2.   Edit the hosts file

     ```
     [opc@shardhost1 ~]$ <copy>sudo vi /etc/hosts</copy>
     ```

     Copy an paste the following entries into the host file

     ```
     <copy>10.0.0.20 gsmhost.subnet1.primaryvcn.oraclevcn.com gsmhost
     10.0.0.10 shardhost0.subnet1.primaryvcn.oraclevcn.com shardhost0
     10.0.0.11 shardhost1.subnet1.primaryvcn.oraclevcn.com shardhost1
     10.0.0.12 shardhost2.subnet1.primaryvcn.oraclevcn.com shardhost2
     10.0.0.13 shardhost3.subnet1.primaryvcn.oraclevcn.com shardhost3</copy>
     ```

     

3.   Switch to oracle user

     ```
     [opc@shardhost1 ~]$ <copy>sudo su - oracle</copy>
     Last login: Thu Aug  8 05:54:07 UTC 2024
     [oracle@shardhost1 ~]$ 
     ```

     

4.   Connect to oracle database as sysdba

     ```
     [oracle@shardhost1 ~]$ <copy>sqlplus / as sysdba</copy>
     
     SQL*Plus: Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Thu Aug 8 05:56:04 2024
     Version 23.5.0.24.07
     
     Copyright (c) 1982, 2024, Oracle.  All rights reserved.
     
     
     Connected to:
     Oracle Database 23ai EE Extreme Perf Release 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
     Version 23.5.0.24.07
     
     SQL> 
     ```

     

5.   Initialization parameters adjustment for CDB

     ```
     <copy>alter system set open_links=16 scope=spfile;
     alter system set open_links_per_instance=16 scope=spfile;
     alter system set db_files=1024 scope=spfile;
     alter system set standby_file_management=auto scope=both;
     alter user gsmrootuser account unlock;
     alter user gsmrootuser identified by WelcomePTS_2024#;
     grant SYSDG, SYSBACKUP to gsmrootuser;
     create or replace directory DATA_PUMP_DIR as '/u02/app/oracle/oradata';
     grant read, write on directory DATA_PUMP_DIR to gsmadmin_internal;
     alter user gsmuser account unlock;
     alter user gsmuser identified by WelcomePTS_2024#;
     alter database flashback on;
     alter system set global_names=false scope=both;
     alter system set db_domain='' scope=spfile;</copy>
     ```

     

6.   Restart database to activate the parameters.

     ```
     <copy>shutdown immediate;
     startup;</copy>
     ```
     
     
     
6.   Switch to shard pdb(**Note**: the pdb name is different in each shard)

     ```
     <copy>alter session set container=shard1;</copy>
     ```
     
     
     
7.   Unlock and grant privileges to gsm user  for PDB.

     ```
     <copy>alter user gsmuser account unlock;
     grant SYSDG, SYSBACKUP to gsmuser;
     grant read, write on directory DATA_PUMP_DIR to gsmadmin_internal;</copy>
     ```
     
     
     
7.   Validate shard in the pub, make sure it does not return any errors.

     ```
     <copy>set serveroutput on
     exec DBMS_GSM_FIX.VALIDATESHARD;</copy>
     ```

     output like the followiing, you can ignore the dg_broker_start error and the db_file_name_convert warning.

     ```
     INFO: Data Guard shard validation requested.
     INFO: Database role is PRIMARY.
     INFO: Database name is SDB1.
     INFO: Database unique name is sdb1_workshop.
     INFO: Database ID is 1911777054.
     INFO: Database open mode is READ WRITE.
     INFO: Database in archivelog mode.
     INFO: Flashback is on.
     INFO: Force logging is on.
     INFO: Database platform is Linux x86 64-bit.
     INFO: Database character set is AL32UTF8. This value must match the character
     set of the catalog database.
     INFO: 'compatible' initialization parameter validated successfully.
     INFO: Database is a multitenant container database.
     INFO: Current container is SHARD1.
     INFO: Database is using a server parameter file (spfile).
     INFO: db_create_file_dest set to: '/u02/app/oracle/oradata/sdb1_workshop/'
     INFO: db_recovery_file_dest set to: '/u03/app/oracle/fast_recovery_area'
     INFO: db_files=1024. Must be greater than the number of chunks and/or
     tablespaces to be created in the shard.
     ERROR: dg_broker_start set to FALSE.
     INFO: remote_login_passwordfile set to EXCLUSIVE.
     WARNING: db_file_name_convert is not set.
     INFO: standby_file_management is set to AUTO.
     INFO: GSMUSER account validated successfully.
     INFO: DATA_PUMP_DIR is
     '/u02/app/oracle/oradata/1D0EC70D2AC226C2E0632307F40A1660'.
     
     PL/SQL procedure successfully completed.
     ```

     

8.   Exit and back to gsmhost.

11.   Repeat Task 3 steps to configure other shards(shard2 and shard3).

      

## Task 4: Deploy Sharded Database with GDSCTL

1.   Back to the gsmhost **opc** user and switch to **oracle** user

     ```
     [opc@gsmhost ~]$ <copy>sudo su - oracle</copy>
     Last login: Thu Aug  8 06:21:24 GMT 2024 on pts/0
     [oracle@gsmhost ~]$
     ```

     

2.   Start gdsctl

     ```
     [oracle@gsmhost ~]$ <copy>gdsctl</copy>
     GDSCTL: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on Thu Aug 08 06:27:57 GMT 2024
     
     Copyright (c) 2011, 2024, Oracle.  All rights reserved.
     
     Welcome to GDSCTL, type "help" for information.
     
     Warning:  GSM  is not set automatically because gsm.ora does not contain GSM entries. Use "set  gsm" command to set GSM for the session.
     Current GSM is set to GSMORA
     GDSCTL> 
     ```

     

3.   Create shard catalog, the `-repl NATIVE` for native Raft replication.

     ```
     <copy>create shardcatalog -database shardhost0:1521/shard0 -user mysdbadmin/WelcomePTS_2024# -repl native -repfactor 3 -chunks 18</copy>
     ```

     

4.   Connect to catalog database:

     ```
     <copy>connect mysdbadmin/WelcomePTS_2024#@shardhost0:1521/shard0</copy>
     ```

     

5.   Add GSM named sharddirector1

     ```
     <copy>add gsm -gsm sharddirector1 -catalog shardhost0:1521/shard0 -pwd WelcomePTS_2024#</copy>
     ```

     

6.   Start GSM and set default gsm.

     ```
     <copy>start gsm -gsm sharddirector1
     status gsm -gsm sharddirector1</copy>
     ```
     
     ouput like this：
     
     ```
     GDSCTL> start gsm -gsm sharddirector1
     GSM is started successfully
     GDSCTL> status gsm -gsm sharddirector1
     Alias                     SHARDDIRECTOR1
     Version                   23.0.0.0.0
     Start Date                10-AUG-2024 00:48:33
     Trace Level               off
     Listener Log File         /u01/app/oracle/diag/gsm/gsmhost/sharddirector1/alert/log.xml
     Listener Trace File       /u01/app/oracle/diag/gsm/gsmhost/sharddirector1/trace/ora_115550_139810404772800.trc
     Endpoint summary          (ADDRESS=(HOST=gsmhost.subnet1.primaryvcn.oraclevcn.com)(PORT=1522)(PROTOCOL=tcp))
     GSMOCI Version            4.0.191114
     Mastership                Y
     Connected to GDS catalog  Y
     Process Id                115553
     Number of reconnections   0
     Pending tasks.     Total  0
     Tasks in  process. Total  0
     Regional Mastership       TRUE
     Total messages published  0
     Time Zone                 +00:00
     Orphaned Buddy Regions:   
          None
     GDS region                regionora
     ```
     
     
     
7.   Add invited nodes

     ```
     <copy>add invitednode shardhost0
     add invitednode shardhost1
     add invitednode shardhost2
     add invitednode shardhost3
     add invitednode shardhost1.subnet1.primaryvcn.oraclevcn.com
     add invitednode shardhost2.subnet1.primaryvcn.oraclevcn.com
     add invitednode shardhost3.subnet1.primaryvcn.oraclevcn.com</copy>
     ```

     

8.   List invited nodes

     ```
     <copy>config vncr</copy>
     ```

     The output like this:

     ```
     GDSCTL> config vncr
     Name                          Group ID                      
     ----                          --------                      
     shardhost0                                                  
     shardhost0.subnet1.primaryvcn                               
     .oraclevcn.com                                              
     
     shardhost1                                                  
     shardhost1.subnet1.primaryvcn                               
     .oraclevcn.com                                              
     
     shardhost2                                                  
     shardhost2.subnet1.primaryvcn                               
     .oraclevcn.com                                              
     
     shardhost3                                                  
     shardhost3.subnet1.primaryvcn                               
     .oraclevcn.com
     ```

     

9.   Add the 3 CDBs which shard belong to.

     ```
     <copy>add cdb -connect shardhost1:1521/sdb1_workshop -pwd WelcomePTS_2024#
     add cdb -connect shardhost2:1521/sdb2_workshop -pwd WelcomePTS_2024#
     add cdb -connect shardhost3:1521/sdb3_workshop -pwd WelcomePTS_2024#</copy>
     ```

     The output like this:

     ```
     GDSCTL> add cdb -connect shardhost1:1521/sdb1_workshop -pwd WelcomePTS_2024#
     DB Unique Name: sdb1_workshop
     The operation completed successfully
     GDSCTL> add cdb -connect shardhost2:1521/sdb2_workshop -pwd WelcomePTS_2024#
     DB Unique Name: sdb2_workshop
     The operation completed successfully
     GDSCTL> add cdb -connect shardhost3:1521/sdb3_workshop -pwd WelcomePTS_2024#
     DB Unique Name: sdb3_workshop
     The operation completed successfully
     ```
     
     
     
10.   Add the 3 shard pdbs

      ```
      <copy>add shard -connect shardhost1:1521/shard1 -pwd WelcomePTS_2024# -cdb sdb1_workshop
      add shard -connect shardhost2:1521/shard2 -pwd WelcomePTS_2024# -cdb sdb2_workshop
      add shard -connect shardhost3:1521/shard3 -pwd WelcomePTS_2024# -cdb sdb3_workshop</copy>
      ```

      The output like this:

      ```
      INFO: Raft replication shard validation requested.
      INFO: Database role is PRIMARY.
      INFO: Database name is SDB1.
      INFO: Database unique name is sdb1_workshop.
      INFO: Database ID is 1911882514.
      INFO: Database open mode is READ WRITE.
      INFO: Database in archivelog mode.
      INFO: Flashback is on.
      INFO: Force logging is on.
      INFO: Database platform is Linux x86 64-bit.
      INFO: Database character set is AL32UTF8. This value must match the character set of the catalog database.
      INFO: 'compatible' initialization parameter validated successfully.
      INFO: Database is a multitenant container database.
      INFO: Current container is SHARD1.
      INFO: Database is using a server parameter file (spfile).
      INFO: db_create_file_dest set to: '/u02/app/oracle/oradata/sdb1_workshop/'
      INFO: db_recovery_file_dest set to: '/u03/app/oracle/fast_recovery_area'
      INFO: db_files=1024. Must be greater than the number of chunks and/or tablespaces to be created in the shard.
      INFO: remote_login_passwordfile set to EXCLUSIVE.
      WARNING: db_file_name_convert is not set.
      INFO: filesystemio_options set to setall.
      INFO: GSMUSER account validated successfully.
      INFO: DATA_PUMP_DIR is '/u02/app/oracle/oradata/1D0EC70D2AC226C2E0632307F40A1660'.
      DB Unique Name: sdb1_workshop_shard1
      The operation completed successfully
      ```

      

12.   Check the shard configure

      ```
      <copy>config shard</copy>
      ```

      The output like this:

      ```
      GDSCTL> config shard
      Name                Shard Group         Status    State       Region    Availability 
      ----                -----------         ------    -----       ------    ------------ 
      sdb1_workshop_shard shardspaceora_regio U         none        regionora -            
      1                   nora                                                             
      
      sdb2_workshop_shard shardspaceora_regio U         none        regionora -            
      2                   nora                                                             
      
      sdb3_workshop_shard shardspaceora_regio U         none        regionora -            
      3                   nora                                                             
      ```

      

13.   Deploy the shard. You can check the log in this directory if there are some problems: `$ORACLE_BASE/diag/gsm/gsmhost/sharddirector1/trace`

      ```
      <copy>deploy</copy>
      ```

      The output like this:

      ```
      GDSCTL> deploy
      deploy: examining configuration...
      deploy: shards configured successfully
      The operation completed successfully
      ```

      

13.   Check the shard status

      ```
      GDSCTL> <copy>config shard</copy>
      Catalog connection is established
      Name                Shard Group         Status    State       Region    Availability 
      ----                -----------         ------    -----       ------    ------------ 
      sdb1_workshop_shard shardspaceora_regio Ok        Deployed    regionora ONLINE       
      1                   nora                                                             
      
      sdb2_workshop_shard shardspaceora_regio Ok        Deployed    regionora ONLINE       
      2                   nora                                                             
      
      sdb3_workshop_shard shardspaceora_regio Ok        Deployed    regionora ONLINE       
      3                   nora                                                         
      ```

      

14.   Check the status of RU. You can see there are 6 RUs, 1 Leader and 2 Followers for each RU.

      ```
      GDSCTL> <copy>status ru</copy>
      Replication units
      ------------------------
      Database                      RU#  Role      Term Log Index Status       
      --------                      ---  ----      ---- --------- ------       
      sdb2_workshop_shard2          1    Follower  1    1         Ok           
      sdb2_workshop_shard2          2    Leader    2    2         Ok           
      sdb2_workshop_shard2          3    Follower  2    2         Ok           
      sdb2_workshop_shard2          4    Follower  1    1         Ok           
      sdb2_workshop_shard2          5    Leader    2    2         Ok           
      sdb2_workshop_shard2          6    Follower  2    2         Ok           
      sdb1_workshop_shard1          1    Leader    1    1         Ok           
      sdb1_workshop_shard1          2    Follower  2    2         Ok           
      sdb1_workshop_shard1          3    Follower  2    2         Ok           
      sdb1_workshop_shard1          4    Leader    1    1         Ok           
      sdb1_workshop_shard1          5    Follower  2    2         Ok           
      sdb1_workshop_shard1          6    Follower  2    2         Ok           
      sdb3_workshop_shard3          1    Follower  1    1         Ok           
      sdb3_workshop_shard3          2    Follower  2    2         Ok           
      sdb3_workshop_shard3          3    Leader    2    2         Ok           
      sdb3_workshop_shard3          4    Follower  1    1         Ok           
      sdb3_workshop_shard3          5    Follower  2    2         Ok           
      sdb3_workshop_shard3          6    Leader    2    2         Ok   
      ```

      

15.   Create Global Services

      ```
      <copy>add service -service oltp_ro_svc -preferred_all
      add service -service oltp_rw_svc -preferred_all</copy>
      ```

      

16.   Start services

      ```
      <copy>start service -service oltp_ro_svc
      start service -service oltp_rw_svc</copy>
      ```

      

17.   Check the status of the services

      ```
      <copy>config service</copy>
      ```

      The result like this:

      ```
      GDSCTL> config service
      Name           Network name                  Pool           Started Preferred all 
      ----           ------------                  ----           ------- ------------- 
      oltp_ro_svc    oltp_ro_svc.orasdb.oradbcloud orasdb         Yes     Yes           
      oltp_rw_svc    oltp_rw_svc.orasdb.oradbcloud orasdb         Yes     Yes   
      ```

      

18.   Exit to the **oracle** user

      ```
      GDSCTL> <copy>exit</copy>
      [oracle@gsmhost ~]$
      ```
      
      
      
18.   Check the status of the listener.

      ```
      [oracle@gsmhost ~]$ <copy>lsnrctl status sharddirector1</copy>
      
      LSNRCTL for Linux: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems on 10-AUG-2024 13:49:59
      
      Copyright (c) 1991, 2024, Oracle.  All rights reserved.
      
      Connecting to (DESCRIPTION=(ADDRESS=(HOST=gsmhost.subnet1.primaryvcn.oraclevcn.com)(PORT=1522)(PROTOCOL=tcp))(CONNECT_DATA=(SERVICE_NAME=GDS$CATALOG.oradbcloud)))
      STATUS of the LISTENER
      ------------------------
      Alias                     SHARDDIRECTOR1
      Version                   TNSLSNR for Linux: Version 23.0.0.0.0 - for Oracle Cloud and Engineered Systems
      Start Date                10-AUG-2024 13:20:44
      Uptime                    0 days 0 hr. 29 min. 14 sec
      Trace Level               off
      Security                  ON: Local OS Authentication
      SNMP                      OFF
      Listener Parameter File   /u01/app/oracle/product/23.0.0/gsmhome_1/network/admin/gsm.ora
      Listener Log File         /u01/app/oracle/diag/gsm/gsmhost/sharddirector1/alert/log.xml
      Listening Endpoints Summary...
        (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=gsmhost.subnet1.primaryvcn.oraclevcn.com)(PORT=1522)))
      Services Summary...
      Service "GDS$CATALOG.oradbcloud" has 1 instance(s).
        Instance "catalog", status READY, has 1 handler(s) for this service...
      Service "GDS$COORDINATOR.oradbcloud" has 1 instance(s).
        Instance "catalog", status READY, has 1 handler(s) for this service...
      Service "_MONITOR" has 1 instance(s).
        Instance "SHARDDIRECTOR1", status READY, has 1 handler(s) for this service...
      Service "_PINGER" has 1 instance(s).
        Instance "SHARDDIRECTOR1", status READY, has 1 handler(s) for this service...
      Service "oltp_ro_svc.orasdb.oradbcloud" has 3 instance(s).
        Instance "orasdb%1", status READY, has 1 handler(s) for this service...
        Instance "orasdb%11", status READY, has 1 handler(s) for this service...
        Instance "orasdb%21", status READY, has 1 handler(s) for this service...
      Service "oltp_rw_svc.orasdb.oradbcloud" has 3 instance(s).
        Instance "orasdb%1", status READY, has 1 handler(s) for this service...
        Instance "orasdb%11", status READY, has 1 handler(s) for this service...
        Instance "orasdb%21", status READY, has 1 handler(s) for this service...
      The command completed successfully
      ```

      

Now the Raft replication environment is ready.

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Minqiao Wang, Oracle SE
* **Contributor** - Satyabrata Mishra, Database Product Management
* **Last Updated By/Date** - Sep 2024 