# Deploy cloning configuration

## Introduction

This lab will give you a basic understanding of the bidirectional cloning methods and cross container operations that can be used to replicate data between sites and generate reports. Data in local pluggable databases can be updated, and data from read-only refreshable clones can be included in reports. Read-only clones can be used in read/write mode for testing purposes, and re-created when finished because it's not possible to turn them back into refreshable read-only clone mode.

Estimated Time: 60 minutes

### Objectives

In this lab you will:
* Create a refreshable clone for the application PDB
* Change refresh mode configuration for the clone
* Perform cross-container operations on application PDBs
* Implement bidirectional application data cloning between sites

### Prerequisites

This lab assumes you have:
* Completed all preparation tasks in previous lab
* Basic understanding of the Oracle Base Database Service
* Basic Oracle Database administration experience

## Task 1: Deploy refreshable clone

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @refreshable.sql
    </copy>
    ````

3. This is the SQL script refreshable.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21A container database on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Clone DBS21B_PDB1 from Site B as refreshable DBS21B_PDB1C in DBS21A on Site A.
    create pluggable database DBS21B_PDB1C from DBS21B_PDB1@dbs21b refresh mode manual keystore identified by "STRONG_PASS";

    -- List PDBs on Site A.
    show pdbs

    -- Show refresh settings for PDBs on Site A.
    select PDB_NAME, REFRESH_MODE, REFRESH_INTERVAL, LAST_REFRESH_SCN from dba_pdbs;

    -- Open refreshable clone DBS21B_PDB1C in read-only mode.
    alter pluggable database DBS21B_PDB1C open read only;

    -- List PDBs again.
    show pdbs

    -- Connect to refreshable clone DBS21B_PDB1C on Site A as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21b_pdb1c.DOMAIN_NAME

    -- Select all records in application table.
    SELECT * FROM people;

    -- Connect to DBS21B source PDB1 on Site B as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/dbs21b_pdb1.DOMAIN_NAME

    -- Insert two new rows in application table.
    INSERT INTO people (id, given_name, family_name, title, birth_date)
      WITH names AS (
        select 8, 'Mario',    'Milano', 'Sr',  date'1991-02-15'  from dual union all
        select 9, 'Macarena', 'Madrid', 'Sra', NULL              from dual )
      SELECT * FROM names;

    -- Commit new inserts.
    commit;

    -- Verify all nine rows in application table.
    SELECT * FROM people;

    -- Connect to refreshable clone DBS21B_PDB1C on Site A as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21b_pdb1c.DOMAIN_NAME

    -- Check all rows in application table. When open in read-only mode, clone cannot be refreshed.
    SELECT * FROM people;

    -- Connect to DBS21A container on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Close refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Manually refresh clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C refresh;

    -- Open again in read-only mode refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C open read only;

    -- Connect to refreshable clone DBS21B_PDB1C on Site A as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21b_pdb1c.DOMAIN_NAME

    -- Select all records in application table.
    SELECT * FROM people;
    </copy>
    ````

## Task 2: Configure auto-refresh mode

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @autorefresh.sql
    </copy>
    ````

3. This is the SQL script autorefresh.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21A cotainer on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Show pluggable databases.
    show pdbs

    -- Close refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Change the refresh mode to automatic every two minutes.
    alter pluggable database DBS21B_PDB1C refresh mode every 2 minutes;

    -- List all pluggable databases and refresh configuration to verify changes.
    select PDB_NAME, REFRESH_MODE, REFRESH_INTERVAL, LAST_REFRESH_SCN from dba_pdbs;

    -- Open refreshable clone DBS21B_PDB1C in read-only mode.
    alter pluggable database DBS21B_PDB1C open read only;

    -- Connect to source pluggable database DBS21B PDB1 on Site B as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/dbs21b_pdb1.DOMAIN_NAME

    -- Insert a new record in the source pluggable database application table.
    INSERT INTO people (id, given_name, family_name, title, birth_date)
      WITH names AS (
        select 10, 'Antonio',  'Olivas', 'Dr',  date'1983-12-31'  from dual )
      SELECT * FROM names;

    -- Commit inserted record.
    commit;

    -- Select all records to confirm the new row.
    SELECT * FROM people;

    -- Connect to refreshable clone DBS21B_PDB1C in DBS21A container on Site A as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21b_pdb1c.DOMAIN_NAME

    -- Select all records from application table. Clone needs to be closed in order to be refreshed.
    SELECT * FROM people;

    -- Connect to DBS21A container on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Close refreshable clone.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Wait for two minutes for auto-refresh to start.
    exec DBMS_LOCK.sleep(120);

    -- Now open the refreshable clone again in read-only mode.
    alter pluggable database DBS21B_PDB1C open read only;

    -- Connect to refreshable clone DBS21B_PDB1C on Site A as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21b_pdb1c.DOMAIN_NAME

    -- Select all rows from application table. The new record should be in the results.
    SELECT * FROM people;
    </copy>
    ````

## Task 3: Create global application user

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @globalmanager.sql
    </copy>
    ````

3. This is the SQL script globalmanager.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21A container on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Create a new application user to access data across all pluggable databases, including refreshable clones.
    create user C##GLOBALMGR identified by "STRONG_PASS" quota unlimited on USERS container=ALL;

    -- Grant required privileges to the global application manager.
    grant create session, create table, create view, create synonym to C##GLOBALMGR container=ALL;

    -- Connect to pluggable database DBS21A_PDB1 on Site A as local application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21a_pdb1.DOMAIN_NAME

    -- Grant privileges on application data to the global application user.
    grant select, insert, update, delete on PEOPLE to C##GLOBALMGR;

    -- Connect to the other container database DBS21B on Site B as SYSDBA.
    conn sys/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME as sysdba

    -- Create same global application user.
    create user C##GLOBALMGR identified by "STRONG_PASS" quota unlimited on USERS container=ALL;

    -- Grant privileges to the global application user.
    grant create session, create table, create view, create synonym to C##GLOBALMGR container=ALL;

    -- Connect to the source pluggable database DBS21B_PDB1 on Site B as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/dbs21b_pdb1.DOMAIN_NAME

    -- Grant privileges on application data to the global application user.
    grant select, insert, update, delete on PEOPLE to C##GLOBALMGR;

    -- Connect to container DBS21A on Site A as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME

    -- Create a table with the same structure as the application data table.
    CREATE TABLE people_syn (
      id          INTEGER NOT NULL PRIMARY KEY,
      given_name  VARCHAR2(12) NOT NULL,
      family_name VARCHAR2(12) NOT NULL,
      title       VARCHAR2(6),
      birth_date  DATE );

    -- Connect to pluggable database DBS21A_PDB1 on Site A as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21A_PRIVATE:1521/dbs21a_pdb1.DOMAIN_NAME

    -- Create a synomym that points to the application data table.
    CREATE SYNONYM C##GLOBALMGR.people_syn FOR PEOPLEMGR.people;

    -- Create the same global objects in the other container DBS21B on Site B.
    conn C##GLOBALMGR/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME

    -- Create the table in the container database as global application user.
    CREATE TABLE people_syn (
      id          INTEGER NOT NULL PRIMARY KEY,
      given_name  VARCHAR2(12) NOT NULL,
      family_name VARCHAR2(12) NOT NULL,
      title       VARCHAR2(6),
      birth_date  DATE );

    -- Connect to the pluggable database DBS21B_PDB1 on Site B as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21B_PRIVATE:1521/dbs21b_pdb1.DOMAIN_NAME

    -- Create the synonym of the application data table.
    CREATE SYNONYM C##GLOBALMGR.people_syn FOR PEOPLEMGR.people;
    </copy>
    ````

## Task 4: Perform cross containers operations

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @crosspdbs.sql
    </copy>
    ````

3. This is the SQL script crosspdbs.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21A container on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Close refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Wait for two minutes until it is refreshed automatically.
    exec DBMS_LOCK.sleep(120);

    -- Open back the refreshable clone DBS21B_PDB1C in read-only mode.
    alter pluggable database DBS21B_PDB1C open read only;

    -- Connect to DBS21A container database on Site A as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME

    -- Select application records across all containers and pluggable database metadata about each record.
    SELECT con_id, id, given_name, family_name, title, birth_date FROM CONTAINERS(people_syn) ORDER BY con_id, id;

    -- Connect to DBS21B_PDB1 source pluggable database on Site B as application user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/dbs21b_pdb1.DOMAIN_NAME

    -- Insert two more records in application table.
    INSERT INTO people (id, given_name, family_name, title, birth_date)
      WITH names AS (
        select 11, 'Cezar',    'Cortez',   'Sr',  date'1993-09-10'  from dual union all
        select 12, 'Margarita','Martinez', 'Sra', NULL              from dual )
      SELECT * FROM names;

    -- Commit the two new rows.
    commit;

    -- Connect to DBS21A container database on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Close refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Wait for two minutes for the automatic refresh of the clone.
    exec DBMS_LOCK.sleep(120);

    -- Open back the refreshable clone DBS21B_PDB1C in read-only mode.
    alter pluggable database DBS21B_PDB1C open read only;

    -- Connect to DBS21A container database on Site A as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME

    -- Select all application records across all pluggable databases to verify the two new rows have been included.
    SELECT con_id, id, given_name, family_name, title, birth_date FROM CONTAINERS(people_syn) ORDER BY con_id, id;
    </copy>
    ````

## Task 5: Implement two-way site cloning

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @roundtrip.sql
    </copy>
    ````

3. This is the SQL script roundtrip.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21B container database on Site B as SYSDBA.
    conn sys/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME as sysdba

    -- Create refreshable clone DBS21A_PDB1C on Site B from DBS21A_PDB1 pluggable database on Site A.
    create pluggable database DBS21A_PDB1C from DBS21A_PDB1@dbs21a refresh mode every 2 minutes keystore identified by "STRONG_PASS";

    -- List all pluggable databases on Site B.
    show pdbs

    -- Select pluggable databases with refresh settings on Site B.
    select PDB_NAME, REFRESH_MODE, REFRESH_INTERVAL, LAST_REFRESH_SCN from dba_pdbs;

    -- Open refreshable clone DBS21A_PDB1C on Site B in read-only mode.
    alter pluggable database DBS21A_PDB1C open read only;

    -- List one more time pluggable databases on Site B.
    show pdbs

    -- Connect to DBS21B container on Site B as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME

    -- Select application records across all pluggable databases to return data from Site A and Site B.
    -- Maybe you noticed pluggable database IDs (con_id) are not the same on Site B as the ones on Site A.
    SELECT con_id, id, given_name, family_name, title, birth_date FROM CONTAINERS(people_syn) ORDER BY con_id, id;

    -- Connect to DBS21B container database on Site B as SYSDBA.
    conn sys/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME as sysdba

    -- Grant global application user privileges to retrieve pluggable database IDs.
    grant select on V_$PDBS to C##GLOBALMGR container=ALL;
    alter user C##GLOBALMGR set container_data=ALL for sys.V_$PDBS container=CURRENT;

    -- Connect to DBS21B container on Site B as global application user.
    conn C##GLOBALMGR/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME

    -- Global application user can retrieve pluggable database information including ID.
    select CON_ID, NAME, OPEN_MODE from V$PDBS;

    -- Next you will open the refreshable clone DBS21B_PDB1C on Site A in read/write mode.
    -- Connect to DBS21A container database on Site A as SYSDBA.
    conn sys/STRONG_PASS@DBS21A_PRIVATE:1521/DBS21A_DB_NAME.DOMAIN_NAME as sysdba

    -- Show all pluggable databases on Site A.
    show pdbs

    -- Close read-only refreshable clone DBS21B_PDB1C on Site A.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- First you have to stop refresh mode on DBS21B_PDB1C clone.
    alter pluggable database DBS21B_PDB1C refresh mode none;

    -- Open refreshable clone DBS21B_PDB1C on Site A in read/write mode.
    alter pluggable database DBS21B_PDB1C open read write;

    -- Show all pluggable databases on Site A and check open mode.
    show pdbs

    -- It is not possible to close a refreshable clone that has been open in read/write to re-enable the refresh mode.
    -- Close the read/write former refreshable clone DBS21B_PDB1C.
    alter pluggable database DBS21B_PDB1C close immediate;

    -- Re-enable the manual refresh mode on former refreshable clone DBS21B_PDB1C.
    -- It returns: RA-65261: pluggable database DBS21B_PDB1C not enabled for refresh
    alter pluggable database DBS21B_PDB1C refresh mode manual;
    </copy>
    ````

## Task 6: Provide read/write clones to developers

It is not possible to close a refreshable clone that has been open in read/write to re-enable the refresh mode. And for development and testing environments we need read/write PDBs that can be maintained updated from the production environment. In this case, we can use manual or automatic (Snapshot Carousel) snapshots created from the refreshable clone, and open them in read/write for developers and testing engineers.

1. Start SQL*Plus.

    ````bash
    <copy>
    sqlplus /nolog
    </copy>
    ````

2. Execute the SQL script with all the commands for this task.

    ````sql
    <copy>
    @snapshots.sql
    </copy>
    ````

3. This is the SQL script snapshots.sql, you don't need to copy and execute it from here.

    ````sql
    <copy>
    -- Connect to DBS21B container database on Site B as SYSDBA.
    conn sys/STRONG_PASS@DBS21B_PRIVATE:1521/DBS21B_DB_NAME.DOMAIN_NAME as sysdba

    -- List PDBs on Site B.
    show pdbs

    -- Create auto refreshable clone PDB1A_SNCL0 on Site B with Snapshot Carousel every 24 hours from DBS21A_PDB1 pluggable database on Site A.
    create pluggable database PDB1A_SNCL0 from DBS21A_PDB1@dbs21a refresh mode every 2 minutes SNAPSHOT MODE EVERY 24 HOURS keystore identified by "STRONG_PASS";

    -- List all pluggable databases on Site B.
    show pdbs

    col PDB_NAME for A12
    col SNAPSHOT_MODE for A15
    col PROPERTY_NAME for A20
    col PROPERTY_VALUE for A15
    col DESCRIPTION for A50

    -- Verify snapshot pluggable databases on Site B.
    select CON_ID, PDB_NAME, SNAPSHOT_MODE, SNAPSHOT_INTERVAL from CDB_PDBS order by 1;

    -- Check maximum number of snapshots for pluggable databases on Site B.
    select pr.CON_ID, p.PDB_NAME, pr.PROPERTY_NAME, pr.PROPERTY_VALUE, pr.DESCRIPTION
    from CDB_PROPERTIES pr join CDB_PDBS p on pr.CON_ID = p.CON_ID
    where pr.PROPERTY_NAME = 'MAX_PDB_SNAPSHOTS' order by pr.PROPERTY_NAME;

    -- Switch to pluggable database PDB1A_SNCL0.
    alter session set container=PDB1A_SNCL0;

    -- Open refreshable clone PDB1A_SNCL0 in read-only mode.
    alter pluggable database PDB1A_SNCL0 open read only;

    -- Create a snapshot with a system generated snapshot name.
    alter pluggable database snapshot;

    -- Create a snapshot with a user-defined snapshot name.
    alter pluggable database snapshot MY_SNAPSHOT;

    -- Switch to the root container database.
    alter session set container=CDB$ROOT;

    col CON_NAME for a10
    col SNAPSHOT_NAME for a30
    col SNAPSHOT_SCN for 9999999
    col FULL_SNAPSHOT_PATH for a50

    -- Verify pluggable database snapshot details on Site B.
    select CON_ID, CON_NAME, SNAPSHOT_NAME, SNAPSHOT_SCN, FULL_SNAPSHOT_PATH
    from cdb_pdb_snapshots order by CON_ID, SNAPSHOT_SCN;

    -- Use snapshots from the PDB1A_SNCL0 Snapshot Carousel to create pluggable databases for development and testing.

    -- List all pluggable databases on Site B.
    show pdbs

    -- Create pluggable database PDB_SYSSN on Site B from PDB1A_SNCL0 snapshot with system generated snapshot name.
    create pluggable database PDB_SYSSN from PDB1A_SNCL0 using snapshot SYSTEM_GENERATED_SNAPSHOT_NAME keystore identified by "STRONG_PASS";

    -- Create pluggable database PDB_USRSN on Site B from PDB1A_SNCL0 snapshot with user-defined snapshot name.
    create pluggable database PDB_USRSN from PDB1A_SNCL0 using snapshot MY_SNAPSHOT keystore identified by "STRONG_PASS";

    -- List all pluggable databases on Site B.
    show pdbs

    -- Open pluggable database PDB_SYSSN in read/write mode for development.
    alter pluggable database PDB_SYSSN open;

    -- Open pluggable database PDB_USRSN in read/write mode for testing.
    alter pluggable database PDB_USRSN open;

    -- Verify pluggable databases PDB_SYSSN and PDB_USRSN are open on Site B.
    show pdbs

    -- Connect to PDB_SYSSN pluggable database on Site B as developer user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/PDB_SYSSN.DOMAIN_NAME

    -- Verify new records in application table.
    SELECT * FROM people;

    -- Insert two new records into application table.
    INSERT INTO people (id, given_name, family_name, title, birth_date)
      WITH names AS (
        select 8, 'Carlos',   'Sierra',   'Mr',    date'1993-05-23'    from dual union all
        select 9, 'Juan',     'Palma',    'Dr',    NULL                from dual )
      SELECT * FROM names;

    -- Commit these two rows.
    commit;

    -- Verify new records in application table.
    SELECT * FROM people;

    -- Connect to PDB_USRSN pluggable database on Site B as testing user.
    conn PEOPLEMGR/STRONG_PASS@DBS21B_PRIVATE:1521/PDB_USRSN.DOMAIN_NAME

    -- Verify new records in application table.
    SELECT * FROM people;

    -- Insert two new records into application table.
    INSERT INTO people (id, given_name, family_name, title, birth_date)
      WITH names AS (
        select 8, 'Valeria',  'Tomaso',   'Mrs',   date'1984-11-29'    from dual union all
        select 9, 'Corina',   'Campesi',  'Miss',  date'1978-02-06'    from dual )
      SELECT * FROM names;

    -- Commit these two rows.
    commit;

    -- Verify new records in application table.
    SELECT * FROM people;

    </copy>
    ````

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, February 2023
