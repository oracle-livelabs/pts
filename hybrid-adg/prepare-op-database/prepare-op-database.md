# Prepare On Premise Database

## Introduction
In this lab, You will use a compute instance in the OCI to simulate the on-premise primary database. The Oracle 19c database has been installed and patched to 19.7.0. 

Estimated Lab Time: 40 minutes

### Objectives

-   Open the 1521 port for the on-premise database
-   Enable ssh connect for the oracle user
-   Enable TDE
-   Encrypt the data files
-   Enable the Network Encryption
-   Enable achivelog and flashback
-   Change redo log size and create standby log
-   Modify the init parameters for best practice

### Prerequisites

This lab assumes you have completed the following labs:

* Setup Primary Environment


## Task 1: Open the 1521 Port for the on-premise Database

1. Connect to the VM which you created before with **opc** user. Use putty tool (Windows) or command line (Mac, Linux).

     ```
     ssh -i labkey opc@xxx.xxx.xxx.xxx
     ```
  
2. Copy and run the following command to open the 1521 port in the VM.

     ```
     <copy>
     sudo firewall-cmd --zone=public --add-port=1521/tcp --permanent
     sudo firewall-cmd --reload
     sudo firewall-cmd --list-all
     </copy>
     ```


## Task 2: Enable ssh Connect for the Oracle User

1. Work as opc user, edit the ssh configure file.

     ```
     <copy>sudo vi /etc/ssh/sshd_config</copy>
     ```

2. Add the following lines in the file.

     ```
     <copy>AllowUsers oracle 
     AllowUsers opc</copy>
     ```

3. Restart the ssh service.

     ```
     <copy>sudo systemctl restart sshd.service</copy>
     ```



## Task 3: Enable TDE

Oracle MAA best practice recommends using Oracle Transparent Data Encryption (TDE) to encrypt both primary and standby databases to ensure all data is encrypted at-rest. Data can be converted during the migration process but it’s highly recommended to convert to TDE prior to migration to provide the most secure Data Guard environment. 

1. Switch to the **oracle** user.

     ```
     <copy>sudo su - oracle</copy>
     ```

   

2. Connect to the database.

     ```
     <copy>sqlplus / as sysdba</copy>
     ```

3. Set Wallet_ROOT static init parameter.

     ```
     <copy>alter system set wallet_root='/u01/app/oracle/product/19c/dbhome_1/wallet' scope=spfile;</copy>
     ```

4. Restart the database to enable the parameter.

     ```
     <copy>shutdown immediate
     startup</copy>
     ```
     
5. Set TDE_CONFIGURATION parameter to set the keystore type to file.

     ```
     <copy>alter system set tde_configuration="KEYSTORE_CONFIGURATION=FILE" scope=both;</copy>
     ```
     
     
     
5. Created a password-protected keystore.

     ```
     SQL> <copy>administer key management create keystore identified by "Ora_DB4U";</copy>
     
     keystore altered.
     ```
     
     
     
     
     
7. Check the keystone files. `ewallet.p12` is the password-protected keystore.

     ```
     SQL> <copy>!ls -l /u01/app/oracle/product/19c/dbhome_1/wallet/tde</copy>
     total 4
     -rw-------. 1 oracle dba 2555 Sep 25 05:23 ewallet.p12
     ```

     

8. Open the password-protected keystore.

     ```
     SQL> <copy>administer key management set keystore open force keystore identified by "Ora_DB4U" container=all;</copy>
     
     keystore altered.
     ```

     

9. Check current status of the wallet.

     ```
     SQL> <copy>select con_id, wallet_type, status from v$encryption_wallet;</copy>
     
         CON_ID WALLET_TYPE		STATUS
     ---------- -------------------- ------------------------------
     	 1 PASSWORD		OPEN_NO_MASTER_KEY
     	 2 PASSWORD		OPEN_NO_MASTER_KEY
     	 3 PASSWORD		OPEN_NO_MASTER_KEY
     ```

7. Create master key.

     ```
     SQL> <copy>administer key management set key identified by "Ora_DB4U" with backup using 'backup' container=all;</copy>
     
     keystore altered.
     
     SQL>
     ```

8. Verify the keystore, you can see the wallet is opened by password.

     ```
     SQL> <copy>select con_id, wallet_type, status from v$encryption_wallet;</copy>
     
         CON_ID WALLET_TYPE		STATUS
     ---------- -------------------- ------------------------------
     	 1 PASSWORD		OPEN
     	 2 PASSWORD		OPEN
     	 3 PASSWORD		OPEN
     ```
     
9. Make the Keystore Auto-Login.

     ```
     SQL> <copy>administer key management create auto_login keystore from keystore identified by "Ora_DB4U";</copy>
     
     keystore altered.
     ```
     
10. To start using the auto-login keystore, we should close the password-protected keystore.

     ```
     SQL> <copy>administer key management set keystore close identified by "Ora_DB4U" container=all;</copy>
     
     keystore altered.
     ```
    
11. Verify the keystore again, now you can see the wallet is configure to autologin.

    ```
    SQL> <copy>select con_id, wallet_type, status from v$encryption_wallet;</copy>
    
        CON_ID WALLET_TYPE		STATUS
    ---------- -------------------- ------------------------------
    	 1 AUTOLOGIN		OPEN
    	 2 AUTOLOGIN		OPEN
    	 3 AUTOLOGIN		OPEN
    ```
    
    
    
11. We can check what files we have now. In which, `ewallet.p12` is the password-protected keystore,  `cwallet.sso` is the auto-login keystore and ```ewallet_*_backup.p12``` is the keystore backup file.

     ```
     SQL> !ls -l /u01/app/oracle/product/19c/dbhome_1/wallet/tde
     total 20
     -rw-------. 1 oracle dba 5512 Sep 25 07:31 cwallet.sso
     -rw-------. 1 oracle dba 2555 Sep 25 07:30 ewallet_2023092507301183_backup.p12
     -rw-------. 1 oracle dba 5467 Sep 25 07:30 ewallet.p12
     ```



## Task 4: Encrypt the Data Files

According to the best practice, you should encrypt all the data files. In this lab, we only encrypt the **USERS** tablespace in the pdb.

1. Connect to the orclpdb, check the encrypt status of the tablespace.

     ```
     SQL> <copy>alter session set container=orclpdb;</copy>
     
     Session altered.
     
     SQL> <copy>select tablespace_name, encrypted from dba_tablespaces;</copy>
     
     TABLESPACE_NAME 	       ENC
     ------------------------------ ---
     SYSTEM			       NO
     SYSAUX			       NO
     UNDOTBS1		       NO
     TEMP			       NO
     USERS			       NO
     ```

2. Run the command to encrypt the USERS tablespace online, then check the status. You can see the USERS tablespace has already encrypted.

     ```
     SQL> <copy>alter tablespace users encryption online encrypt;</copy>
     
     Tablespace altered.
     
     SQL> <copy>select tablespace_name, encrypted from dba_tablespaces;</copy>
     
     TABLESPACE_NAME 	       ENC
     ------------------------------ ---
     SYSTEM			       NO
     SYSAUX			       NO
     UNDOTBS1		       NO
     TEMP			       NO
     USERS			       YES
     ```



## Task 5: Enable the Network Encryption

VPN connection or Oracle Net encryption is also required for encryption-in-flight for any other database payload (e.g. data file or redo headers) that are not encrypted by TDE. In this lab, you use public internet to connect between on-premise and the cloud, so you need to enable the network encryption.

1. Work as oracle user, connect to the database as sysdba.

     ```
     <copy>connect / as sysdba</copy>
     ```

   

2. Check the network service banner before encryption.

     ```
     SQL> <copy>set linesize 120</copy>
     SQL> <copy>col network_service_banner for a85</copy>
     SQL> <copy>select i.network_service_banner from v$session_connect_info i, v$session s where s.sid=i.sid and s.serial# = i.serial# and s.username = 'SYS';</copy>
     
     NETWORK_SERVICE_BANNER
     -------------------------------------------------------------------------------------
     Oracle Bequeath NT Protocol Adapter for Linux: Version 19.0.0.0.0 - Production
     Authentication service for Linux: Version 19.0.0.0.0 - Production
     Encryption service for Linux: Version 19.0.0.0.0 - Production
     Crypto-checksumming service for Linux: Version 19.0.0.0.0 - Production
     
     SQL> <copy>exit</copy>
     Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
     Version 19.10.0.0.0
     [oracle@primary ~]$
     ```

3. Edit the sqlnet.ora file.

     ```
     <copy>vi $ORACLE_HOME/network/admin/sqlnet.ora</copy>
     ```

     Add following lines in the sqlnet.ora, save and exit.

     ```
     <copy>
     SQLNET.ENCRYPTION_SERVER=REQUIRED
     SQLNET.CRYPTO_CHECKSUM_SERVER=REQUIRED
     SQLNET.ENCRYPTION_TYPES_SERVER=(AES256,AES192,AES128)
     SQLNET.CRYPTO_CHECKSUM_TYPES_SERVER=(SHA1)
     SQLNET.ENCRYPTION_CLIENT=REQUIRED
     SQLNET.CRYPTO_CHECKSUM_CLIENT=REQUIRED
     SQLNET.ENCRYPTION_TYPES_CLIENT=(AES256,AES192,AES128)
     SQLNET.CRYPTO_CHECKSUM_TYPES_CLIENT=(SHA1)
     </copy>
     ```



4. Check the network service banner again, the network encryption is enable now.

     ```
     [oracle@workshop ~]$ <copy>sqlplus / as sysdba</copy>
     
     SQL*Plus: Release 19.0.0.0.0 - Production on Fri Jan 31 03:51:46 2020
     Version 19.10.0.0.0
     
     Copyright (c) 1982, 2019, Oracle.  All rights reserved.
     
     
     Connected to:
     Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
     Version 19.10.0.0.0
     
     SQL> <copy>set linesize 120</copy>
     SQL> <copy>col network_service_banner for a85</copy>
     SQL> <copy>select i.network_service_banner from v$session_connect_info i, v$session s where s.sid=i.sid and s.serial# = i.serial# and s.username = 'SYS';</copy>
     
     NETWORK_SERVICE_BANNER
     -------------------------------------------------------------------------------------
     Oracle Bequeath NT Protocol Adapter for Linux: Version 19.0.0.0.0 - Production
     Authentication service for Linux: Version 19.0.0.0.0 - Production
     Encryption service for Linux: Version 19.0.0.0.0 - Production
     AES256 Encryption service adapter for Linux: Version 19.0.0.0.0 - Production
     Crypto-checksumming service for Linux: Version 19.0.0.0.0 - Production
     SHA1 Crypto-checksumming service adapter for Linux: Version 19.0.0.0.0 - Production
     
     6 rows selected.
     
     SQL> 
     ```



## Task 6: Enable Achivelog and Flashback

1. Check the achivelog mode, you can find it's disable now.

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

3. Check the status again, it's enable now.

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



## Task 7: Change Redo Log Size and Create Standby Log

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

3. Switch the logfile several times.

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


## Task 8: Modify the Init Parameters for Best Practice

1.   Modify some init parameters for best practice.

     ```
     SQL> <copy>alter system set STANDBY_FILE_MANAGEMENT=AUTO scope=both;</copy>
         
     System altered.
         
     SQL> <copy>alter system set DB_LOST_WRITE_PROTECT=TYPICAL scope=both;</copy>
         
     System altered.
         
     SQL> <copy>alter system set FAST_START_MTTR_TARGET=300 scope=both;</copy>
         
     System altered.
         
     SQL> <copy>exit;</copy>
     ```

     ​      

You may proceed to the next lab.

## Acknowledgements
* **Author** - Minqiao Wang, Oracle China
* **Last Updated By/Date** - Minqiao Wang, Sep 2023

