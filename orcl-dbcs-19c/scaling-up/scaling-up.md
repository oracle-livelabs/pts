# Performance, scalability and elasticity

## Introduction

Oracle Database technology used for the Database Cloud Service is the standard for scalability, robustness and enterprise strength. Virtual Machine VM.Standard2 Shapes provide a virtual machine DB system database provisioned on X7 machines, with six VM options available, having 1 to 24 CPU cores and 15 GB to 320 GB memory. You can scale up or down the number of OCPUs on the instance by changing the shape the DB System is running on.

Oracle Database on virtual machines uses remote block storage, and enables scaling storage from 256 GB to 40 TB, with no downtime when scaling up storage. You specify a storage size when you launch the DB system, and you can scale up the storage as needed at any time. You can easily scale up storage for a DB system by using the console, REST APIs, CLI and SDKs.

>**Note** : The total storage attached to an instance will be a sum of available storage, reco storage, and software size. Available storage is selected by the customer, reco storage is automatically calculated based on available storage, and software size is a fixed size Oracle database cost.

Estimated Time: 25 minutes


## Task 1: Change Shape for More CPUs

1. Connect to your PDB012 pluggable database as SYSDBA using SQL*Plus.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

2. Display the value of parameter **cpu_count**. Database Service is running currently on 2 CPUs.

    ````
    <copy>
    show parameter cpu_count
    </copy>

    NAME        TYPE      VALUE
    ----------- --------- --------------------
    cpu_count   integer   2
    ````

3. On Oracle cloud console, click on hamburger menu ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DB** DB System (or click DB System Details in the breadcrumb links).

4. On DB System Details page, click **Change Shape** button. Select VM.Standard2.2 shape. Click **Change Shape** to confirm.

5. Read the warning: *Changing shapes stops a running DB System and restarts it on the selected shape. Are you sure you want to change the shape from VM.Standard2.1 to VM.Standard2.2?* Click again **Change Shape** to confirm.

6. DB System Status will change to Updating... Wait for Status to become Available (refresh page). Re-connect to your DB Node via SSH, and DB System database as SYSDBA using SQL*Plus.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

7. Display again the value of parameter **cpu_count**. Database Service is running now on 4 CPUs.

    ````
    <copy>
    show parameter cpu_count
    </copy>

    NAME        TYPE      VALUE
    ----------- --------- --------------------
    cpu_count   integer   4
    ````

8. After restarting the DB System on a new shape, your pluggable database is in mounted state. Open pluggable database PDB012.

    ````
    <copy>
    alter pluggable database PDB012 open;
    </copy>
    ````

9. Type **exit** command to close SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

## Task 2: Scale Up Storage Volumes

1. On DB System Information page review the allocated storage resources:

    - Available Data Storage: 256 GB
    - Total Storage Size: 712 GB

2. Check file system disk space usage on the database node, using the **df** command. Flag **-h** is fo *human-readable* output. It uses unit suffixes: Byte, Kilobyte, Megabyte, and so on. Total Storage Size value on DB System Information is the sum of all these filesystems. Write down in your notes the value of **/dev/mapper/DATA_GRP-DATA** filesystem.

    ````
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

3. On DB System Details page, click **Scale Storage Up** button. Set Available Data Storage (GB): 512, and click **Update**.

4. DB System Status will change to Updating... Wait for Status to become Available.

5. On Oracle cloud console, under DB System Information, review again the allocated storage resources:

    - Available Data Storage: 512 GB
    - Total Storage Size: 968 GB

6. Check again the file system disk space usage, and compare the value of **/dev/mapper/DATA_GRP-DATA** filesystem with the previous one.

    ````
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

    ````
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

2. Set required privileges for database monitoring user credentials.

    ````
    <copy>
    GRANT CREATE PROCEDURE TO dbsnmp;
    GRANT SELECT ANY DICTIONARY, SELECT_CATALOG_ROLE TO dbsnmp;
    GRANT ALTER SYSTEM TO dbsnmp;
    GRANT ADVISOR TO dbsnmp;
    GRANT EXECUTE ON DBMS_WORKLOAD_REPOSITORY TO dbsnmp;
    alter user dbsnmp identified by "DatabaseCloud#22_" account unlock;
    exit
    </copy>
    ````

3. Click on main menu ≡, then Observability & Management > Database Management > Administration. Click Private Endpoints in the left side menu. Click Create Private Endpoint.

    - Name: WS_PE
    - Description: Database Management Private Endpoint

4. Click on main menu ≡, then Identity & Security > Vault. Click Create Vault.

    - Name: WS-Vault

5. When Vault is Active (refresh page), click on it. Under Master Encryption Keys, click Create Key.

    - Protection Mode: Software
    - Name: WS-Key

6. When Master Encryption Key is Enabled (refresh page), click Secrets on the left menu. Click Create Secret.

    - Name: WS-Secret
    - Description: Database Management Password
    - Encryption Key: WS-Key
    - Secret Contents: DatabaseCloud#22_

7. When Secret is Active (refresh page), click on main menu ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DB** DB System.

8. Click the database name link **WSDB** in the bottom table called Databases.

9. On Database Information page, under Associated Services, see Database Management status Not Enabled. Click Enable.

    - Database User Name: DBSNMP

10. Leave the rest of the fileds with the default values, and click Enable Database Management.

11. Database Status will change to Updating. Wait for Status to become Available (refresh page). Click Metrics on the left side menu. Now you can see all performance metrics, because Database Management status is Full.

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

See an issue? Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.
