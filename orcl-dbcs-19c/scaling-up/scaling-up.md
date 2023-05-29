# Manage database service

## Introduction

Oracle Database technology used for the Oracle Base Database Service is the standard for scalability, robustness and enterprise strength. Virtual Machines with AMD Standard E4 Flex shape allow you to provision any number of OCPUs, up to a maximum of 64 OCPUs (128 vCPUs) and 1 TB of memory with a single Base Database Service. OCI Block Volume storage with higher performance provides the best throughput for workloads that have high IO requirements.

You can easily scale up and down resources for a DB system by using the console, REST APIs, CLI and SDKs.

>**Note** : The total storage attached to an instance will be a sum of available storage, reco storage, and software size. Available storage is selected by the customer, reco storage is automatically calculated based on available storage, and software size is a fixed size Oracle database cost.

Database Management service provide a unified console for cloud databases with lifecycle database management capabilities for monitoring, performance management, tuning, and administration. 
Last bu not least, Oracle Enterprise Manager Database Express, also referred to as EM Express, is a web-based tool for managing Oracle Database 19c. Built inside the database server, it offers support for basic administrative tasks.

Estimated Time: 40 minutes

### Objectives

In this lab you will:
* Change Database System Node shape for more CPU resources
* Scale-up storage volumes for more space
* Enable Database Management Services
* Enable Enterprise Manager Express web management tool

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service

## Task 1: Change shape for More CPUs

Please take a moment to watch the video below to learn how to perform the Database Lifecycle Task using the OCI Console, and then afterwards, follow the steps shown.

[Change the Shape of a VM DB System] (youtube:CkQ4UOYico)

1. Connect to your **PDB012** pluggable database as SYSDBA using SQL*Plus.

    ````bash
    <copy>
    sqlplus sys/<Strong Password>@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

2. Display the value of parameter **cpu_count**. Database Service is running currently on 2 CPUs.

    ````sql
    <copy>
    show parameter cpu_count
    </copy>

    NAME        TYPE      VALUE
    ----------- --------- --------------------
    cpu_count   integer   2
    ````

3. On Oracle cloud console, click on main menu **≡**, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System (or click DB System Details in the breadcrumb links).

4. On DB System Details page, click **Change shape** button. Select **Shape series: AMD**, VM.Standard.E4.Flex shape with **Number of OCPUs per node: 2**. Click **Change shape** to confirm.

5. Under Confirm shape change, click again **Change shape** to confirm.

6. DB System Status will change to Updating... Wait for Status to become Available (refresh page). Re-connect to your DB Node via SSH, and DB System database as SYSDBA using SQL*Plus.

    ````sql
    <copy>
    sqlplus sys/<Strong Password>@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

7. Display again the value of parameter **cpu_count**. Database Service is running now on 4 CPUs.

    ````sql
    <copy>
    show parameter cpu_count
    </copy>

    NAME        TYPE      VALUE
    ----------- --------- --------------------
    cpu_count   integer   4
    ````

8. Type **exit** command to close SQL*Plus.

    ````sql
    <copy>
    exit
    </copy>
    ````

## Task 2: Scale Up Storage Volumes

Please take a moment to watch the video below to learn how to perform the Database Lifecycle Task using the OCI Console, and then afterwards, follow the steps shown.

[Scale the Storage for VM DB System] (youtube:gPIPym5pt9M)

1. On DB System Information page review the allocated storage resources:

    - Available Data Storage: 256 GB
    - Total Storage Size: 712 GB

2. Check file system disk space usage on the database node, using the **df** command. Flag **-h** is fo *human-readable* output. It uses unit suffixes: Byte, Kilobyte, Megabyte, and so on. Total Storage Size value on DB System Information is the sum of all these filesystems. Write down in your notes the value of **/dev/mapper/DATA_GRP-DATA** filesystem.

    ````bash
    <copy>
    df -h
    </copy>

    Filesystem                           Size  Used Avail Use% Mounted on
    devtmpfs                             7.2G     0  7.2G   0% /dev
    tmpfs                                7.3G     0  7.3G   0% /dev/shm
    tmpfs                                7.3G  193M  7.1G   3% /run
    tmpfs                                7.3G     0  7.3G   0% /sys/fs/cgroup
    /dev/mapper/VolGroupSys0-LogVolRoot   45G  8.7G   34G  21% /
    tmpfs                                7.3G  4.3M  7.3G   1% /tmp
    /dev/sda2                            1.4G  102M  1.2G   8% /boot
    /dev/sda1                            486M  9.7M  476M   2% /boot/efi
    /dev/mapper/DATA_GRP-DATA            252G   21G  219G   9% /u02
    /dev/mapper/RECO_GRP-RECO            252G   23G  217G  10% /u03
    /dev/mapper/BITS_GRP-BITS            197G   14G  174G   7% /u01
    tmpfs                                1.5G     0  1.5G   0% /run/user/101
    tmpfs                                1.5G     0  1.5G   0% /run/user/54322
    ````

3. On DB System Details page, click **Scale Storage Up** button. Set **Available Data Storage (GB): 512**, and click **Update**.

4. DB System Status will change to Updating... Wait for Status to become Available.

5. On Oracle cloud console, under DB System Information, review again the allocated storage resources:

    - Available Data Storage: 512 GB
    - Total Storage Size: 968 GB

6. Check again the file system disk space usage, and compare the value of **/dev/mapper/DATA_GRP-DATA** filesystem with the previous one.

    ````bash
    <copy>
    df -h
    </copy>

    Filesystem                           Size  Used Avail Use% Mounted on
    devtmpfs                             7.2G     0  7.2G   0% /dev
    tmpfs                                7.3G     0  7.3G   0% /dev/shm
    tmpfs                                7.3G  193M  7.1G   3% /run
    tmpfs                                7.3G     0  7.3G   0% /sys/fs/cgroup
    /dev/mapper/VolGroupSys0-LogVolRoot   45G  8.7G   34G  21% /
    tmpfs                                7.3G  4.3M  7.3G   1% /tmp
    /dev/sda2                            1.4G  102M  1.2G   8% /boot
    /dev/sda1                            486M  9.7M  476M   2% /boot/efi
    /dev/mapper/DATA_GRP-DATA            504G   21G  460G   5% /u02
    /dev/mapper/RECO_GRP-RECO            252G   23G  217G  10% /u03
    /dev/mapper/BITS_GRP-BITS            197G   14G  174G   7% /u01
    tmpfs                                1.5G     0  1.5G   0% /run/user/101
    tmpfs                                1.5G     0  1.5G   0% /run/user/54322
    ````

    >**Note** : You noticed the button on Oracle cloud console is called **Scale Storage Up**. Because you can always scale up, in other words increase, the database service storage, and never scale down, or decrease.


## Task 3: Enable Database Management Services

1. Use SQL*Plus to connect to your DB System database instance specified by environment variables.

    ````bash
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

2. Set required privileges for database monitoring user credentials.

    ````sql
    <copy>
    GRANT CREATE PROCEDURE TO dbsnmp;
    GRANT SELECT ANY DICTIONARY, SELECT_CATALOG_ROLE TO dbsnmp;
    GRANT ALTER SYSTEM TO dbsnmp;
    GRANT ADVISOR TO dbsnmp;
    GRANT EXECUTE ON DBMS_WORKLOAD_REPOSITORY TO dbsnmp;
    alter user dbsnmp identified by "<Strong Password>" account unlock;
    exit
    </copy>
    ````

3. Click on main menu **≡**, then **Observability & Management** > Database Management > **Administration**. Click **Private Endpoints** in the left side menu. Click **Create Private Endpoint**.

    - Name: WS_PE
    - Description: Database Management Private Endpoint
    - Subnet: Public Subnet LLXXXXX-VCN.

4. Click on main menu **≡**, then **Identity & Security** > **Vault**. Click **Create Vault**.

    - Name: WS-Vault

5. When Vault is Active (refresh page), click on it. Under **Master Encryption Keys**, click **Create Key**.

    - Protection Mode: Software
    - Name: WS-Key

6. When Master Encryption Key is Enabled (refresh page), click **Secrets** on the left menu. Click **Create Secret**.

    - Name: WS-Secret
    - Description: Database Management Password
    - Encryption Key: WS-Key
    - Secret Contents: Use the strong password written down in your notes.

7. When Secret is Active (refresh page), click on main menu **≡**, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System.

8. Click the database name link **WSDB** in the bottom table called Databases.

9. On Database Information page, under Associated Services, see **Database Management** status Not Enabled. Click **Enable**.

    - Database User Name: DBSNMP
    - Secret: WS-Secret

10. Leave the rest of the fields with the default values, and click **Enable Database Management**.

11. Database Status will change to Updating. Wait for Status to become Available (refresh page). Click **Metrics** on the left side menu. Now you can see all performance metrics, because Database Management status is Full.


## Task 4: Enterprise Manager Express

1. On Oracle cloud console, click on main menu **≡**, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System (or click DB System Details in the breadcrumb links).

2. On DB System Details page, click the database name link **WSDB** in the bottom table called Databases.

3. Wait for Backup In Progress task to finish. Review the backup called **Automatic Backup** in the bottom table called Backups. Make sure it has Active State and a valid Ended timestamp.

4. Connect to the database instance specified by environment variables.

    ````bash
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

5. Unlock **xdb** database user account.

    ````sql
    <copy>
    alter user xdb account unlock;
    </copy>
    ````

6. Enable Oracle Enterprise Manager Database Express (EM Express) clients to use a single port (called a global port), for the session rather than using a port dedicated to the PDB.

    ````sql
    <copy>
    exec dbms_xdb_config.SetGlobalPortEnabled(TRUE);
    </copy>
    ````

7. Install the default XDB wallet in the default XDB wallet directory

    ````sql
    <copy>
    exec dbms_xdb_admin.installdefaultwallet;
    </copy>
    ````

8. Disable the encrypted HTTPS port for Enterprise Manager Express.

    ````sql
    <copy>
    exec dbms_xdb_config.sethttpsport(0);
    </copy>
    ````

9. Enable the HTTP (unencrypted) port for Enterprise Manager Express.

    ````sql
    <copy>
    exec dbms_xdb_config.sethttpport(5500);
    </copy>
    ````

10. Open the web browser on your computer, and navigate to **http://localhost:5500/em**. It shows a 'Bad Request' error message because EM Express cannot use unencrypted HTTP protocol because of the security risks.

    ![Bad Request](./images/bad-request.png)

11. Disable the HTTP port for Enterprise Manager Express.

    ````sql
    <copy>
    exec dbms_xdb_config.sethttpport(0);
    </copy>
    ````

12. Set the HTTPS port for Enterprise Manager Express. HTTPS uses TLS (SSL) to encrypt all trafic and is more secure.

    ````sql
    <copy>
    exec dbms_xdb_config.sethttpsport(5500);
    </copy>
    ````

13. Open the web browser on your computer, and navigate to **https://localhost:5500/em**.

    >**Note** : You will receive an alert message in your browser about the security certificate not being valid. For Firefox, click **Advanced** and **Accept the Risk and Continue**. For Chrome, navigate to chrome://flags/#allow-insecure-localhost, and enable **Allow invalid certificates for resources loaded from localhost**.

    ![Potential security risk](./images/potential-security-risk.png)

    ![Connection is not private](./images/connection-not-private.png)

14. Use the following credentials:

    - Username: **system**
    - Password: Use the strong password written down in your notes.
    - Container Name: **CDB$ROOT** for the Container Database, or **PDB011** for the Pluggable Database. Try both.

15. Explore Enterprise Manager Express console, and see what this tool has to offer.

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022
