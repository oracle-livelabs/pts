# Application data management and administration

## Introduction

Oracle Enterprise Manager Database Express, also referred to as EM Express, is a web-based tool for managing Oracle Database 19c. Built inside the database server, it offers support for basic administrative tasks.

Oracle Database sample schemas are based on a fictitious sample company that sells goods through various channels. The company operates worldwide to fill orders for products. It has several divisions, each of which is represented by a sample database schema. Schema Human Resources (HR) represents Division Human Resources and tracks information about the company employees and facilities. Schema Sales History (SH) represents Division Sales and tracks business statistics to facilitate business decisions.

This lab explains how to

Estimated Time: 45 minutes

### Objectives

In this lab you will:
* Enable Enterprise Manager Express web management tool
* Create a new Pluggable Database in the existing Root Container
* Install Oracle Database sample schemas

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service

## Task 1: Enterprise Manager Express

>**Note** : After provisioning the DB System, Database State will be Backup In Progress... for a few minutes. This task doesn't affect database availability.

1. Connect to the database instance specified by environment variables.

    ````
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

2. Unlock **xdb** database user account.

    ````
    <copy>
    alter user xdb account unlock;
    </copy>
    ````

3. Enable Oracle Enterprise Manager Database Express (EM Express) clients to use a single port (called a global port), for the session rather than using a port dedicated to the PDB.

    ````
    <copy>
    exec dbms_xdb_config.SetGlobalPortEnabled(TRUE);
    </copy>
    ````

4. Open the web browser on your computer, and navigate to **https://localhost:5500/em**.

    >**Note** : You will receive an alert message in your browser about the security certificate not being valid. For Firefox, click **Advanced** and **Accept the Risk and Continue**. For Chrome, navigate to chrome://flags/#allow-insecure-localhost, and enable **Allow invalid certificates for resources loaded from localhost**.

5. Use the following credentials:

    - Username: system
    - Password: DatabaseCloud#22_
    - Container Name: CDB$ROOT for the Container Database, or PDB011 for the Pluggable Database. Try both.

6. Explore Enterprise Manager Express console, and see what this tool has to offer.


## Task 2: Create a Pluggable Database

1. Connect to your DB System database using SQL*Plus, if not connected already.

    ````
    <copy>
    sqlplus / as sysdba
    </copy>
    ````

2. List pluggable databases.

    ````
    <copy>
    show pdbs
    </copy>
    ````

3. Create a new pluggable database called **PDB012**. Click on main menu ≡, then **Bare Metal, VM, and Exadata** under Oracle Database. Click **WS-DB** DB System.

4. Click the database name link **WSDB** in the bottom table called Databases. Click Pluggable Databases in the left menu at the bottom o the page. Click Create Pluggable Database.

    - Enter PDB Name: PDB012
    - Unlock my PDB Admin account
    - PDB Admin password: DatabaseCloud#22_
    - TDE wallet password of database: DatabaseCloud#22_

5. Wait until Create Pluggable Database operation is Complete (refresh page). Click on Database Details in the breadcrumb links at the top of the page. Click Pluggable Databases in the left menu at the bottom o the page. PDB012 is Available.

6. List again pluggable databases in SQL*Plus to confirm the new pluggable database is there.

    ````
    <copy>
    show pdbs
    </copy>
    ````

7. Connect to the new pluggable database.

    ````
    <copy>
    conn sys/DatabaseCloud#22_@db-host:1521/pdb012.<Host Domain Name> as sysdba
    </copy>
    ````

8. Display the current container name.

    ````
    <copy>
    show con_name
    </copy>
    ````

9. List all users in PDB012.

    ````
    <copy>
    select username from all_users order by 1;
    </copy>
    ````

10. This pluggable database doesn't have Oracle Sample Schemas either.


## Task 3: Install HR Sample Schema

1. List all tablespaces in PDB012.

    ````
    <copy>
    select name from v$tablespace;
    </copy>
    ````

2. List all datafiles.

    ````
    <copy>
    select name from v$datafile;
    </copy>
    ````

3. Createa a new tablespace for applications.

    ````
    <copy>
    CREATE TABLESPACE apps;
    </copy>

    Tablespace created.
    ````

4. List all tablespaces to confirm the new tablespace was created.

    ````
    <copy>
    select name from v$tablespace;
    </copy>
    ````

5. List all datafiles and see the corresponding files.

    ````
    <copy>
    select name from v$datafile;
    </copy>
    ````

6. Exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

7. Download Oracle Sample Schemas installation package from GitHub.

    ````
    <copy>
    wget https://github.com/oracle/db-sample-schemas/archive/v19c.zip
    </copy>
    ````

8. Unzip the archive.

    ````
    <copy>
    unzip v19c.zip
    </copy>
    ````

9. Open the unzipped folder.

    ````
    <copy>
    cd db-sample-schemas-19c
    </copy>
    ````

10. Run this Perl command to replace `__SUB__CWD__` tag in all scripts with your current working directory, so all embedded paths to match your working directory path.

    ````
    <copy>
    perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat
    </copy>
    ````

11. Go back to the parent folder (this should be /home/opc).

    ````
    <copy>
    cd ..
    </copy>
    ````

12. Create a new folder for logs.

    ````
    <copy>
    mkdir logs
    </copy>
    ````

13. Connect to the **PDB012** pluggable database.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

14. Run the HR schema installation script. For more information about [Oracle Database Sample Schemas](https://github.com/oracle/db-sample-schemas) installation process, please follow the link. Make sure to replace **Host Domain Name** with the actual value.

    ````
    <copy>
    @db-sample-schemas-19c/human_resources/hr_main.sql DatabaseCloud#22_ USERS TEMP DatabaseCloud#22_ /home/oracle/logs/ db-host:1521/pdb012.<Host Domain Name>
    </copy>
    ````

## Task 4: Verify HR Sample Schema

1. Display current user. If all steps were followed, the current user should be **HR**.

    ````
    <copy>
    show user
    </copy>
    ````

2. Select tables from **HR** schema and their row numbers.

    ````
    <copy>
    set linesize 130
    col TABLE_NAME for a25
    select TABLE_NAME, NUM_ROWS from USER_TABLES;
    </copy>
    ````

3. Some SQL*Plus formatting.

    ````
    <copy>
    col EMPLOYEE_ID heading ID
    col FIRST_NAME for a10
    col LAST_NAME for a10
    col EMAIL for a8
    col PHONE_NUMBER for a16
    col COMMISSION_PCT heading PCT
    </copy>
    ````

4. Select all rows from the **HR.EMPLOYEES** table.

    ````
    <copy>
    select * from EMPLOYEES;
    </copy>
    ````

5. If everything is fine, exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

## Task 5: Install SH Sample Schema

1. Connect to the **PDB012** pluggable database.

    ````
    <copy>
    sqlplus sys/DatabaseCloud#22_@db-host:1521/pdb012.$(domainname -d) as sysdba
    </copy>
    ````

2. Run the SH schema installation script. Make sure to replace **Host Domain Name** with the actual value.

    ````
    <copy>
    @db-sample-schemas-19c/sales_history/sh_main.sql DatabaseCloud#22_ USERS TEMP DatabaseCloud#22_ /home/oracle/db-sample-schemas-19c/sales_history/ /home/oracle/logs/ v3 db-host:1521/pdb012.<Host Domain Name>
    </copy>
    ````

3. Display current user. If all steps were followed, the current user should be **SH**.

    ````
    <copy>
    show user
    </copy>
    ````

4. Select tables from **SH** schema and their row numbers.

    ````
    <copy>
    set linesize 130
    col TABLE_NAME for a28
    select TABLE_NAME, NUM_ROWS from USER_TABLES;
    </copy>
    ````

5. If everything is fine, exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
