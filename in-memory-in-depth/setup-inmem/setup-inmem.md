# In-Memory configuration

Oracle Database In-Memory option comes preinstalled with the Oracle Database and does not require additional software installation or recompilation of existing database software. This is because the In-Memory option has been seamlessly integrated into the core of the Oracle Database software as a new component of the Shared Global Area (SGA), so when the Oracle Database is installed, Oracle Database In-Memory gets installed with it.
However, the IM column store is not enabled by default, but can be easily enabled via a few steps, as outlined in this lesson.
It is important to remember that after the In-Memory option is enabled at the instance level, you also have to specifically enable objects so they would be considered for In-Memory column store population.

![](images/In-memory-sga.png)

## In-Memory Pool

## Task 1: Enabling In-Memory

1.  All scripts for this lab are stored in the labs/inmemory folder and are run as the oracle user.  Let's navigate there now.  We recommend you type the commands to get a feel for working with In-Memory. But we will also allow you to copy the commands via the COPY button.

    ````
        <copy>
        sudo su - oracle
        cd ~/labs/inmemory
        ls
        </copy>
    ````

    The In-Memory Area is a static pool within the SGA that holds the column format data (also referred to as the In-Memory Column Store). The size of the In-Memory Area is controlled by the initialization parameter INMEMORY\_SIZE (default is 0, i.e. disabled).
    As the IM column store is a static pool, any changes to the INMEMORY\_SIZE parameter will not take effect until the database instance is restarted.
    Note :  The default install of database usually set a parameter MEMORY_TARGET which manages both SGA (System Global Area) and PGA(Process Global Area). In the earlier version, Automatic Memory Management (AMM) was not supported and we had to set SGA and PGA exclusively.

2. Login as sys
    ````
    <copy>sqlplus / as sysdba
    show pdbs </copy>
    ````
    You will observe that you are connect to the CDB (Container Database) with one PDB (pluggable Database) preinstalled.


3. Next, note the memory settings and enable In-Memory.
    ````
    <copy>
    show parameter inmemory_size
    show parameter sga_target
    show parameter pga_aggregate_target
    show parameter memory_target
    </copy>
    ````


4.  Enter the commands to enable In-Memory.  The database will need to be restarted for the changes to take effect.

    ````
    <copy>
    alter system set inmemory_size=3G scope=spfile;
    shutdown immediate;
    startup;
    </copy>
    ````
    ````
    SQL> ORACLE instance started.

    Total System Global Area 1.0033E+10 bytes
    Fixed Size                  9160168 bytes
    Variable Size            1140850688 bytes
    Database Buffers         5653921792 bytes
    Redo Buffers                7614464 bytes
    In-Memory Area           3221225472 bytes
    Database mounted.
    Database opened.
    SQL>
    ````
    Note that during startup, you will see the *In-Memory Area* and the size of the pool.

5.  Now let's take a look at the parameters.

    ````
    <copy>
    show sga;
    show parameter inmemory;
    </copy>
    ````

## Task 2: Enable Objects  In-Memory

The Oracle environment is already set up so sqlplus can be invoked directly from the shell environment. Since the lab is being run in a pdb called orclpdb you must supply this alias when connecting to the ssb account.

1.  Login to the pdb as the SSB user.  
    ````
    <copy>
    connect ssb/Ora_DB4U@localhost:1521/orclpdb    
    set pages 9999
    set lines 200
    </copy>
    ````


2.  The In-Memory area is sub-divided into two pools:  a 1MB pool used to store actual column formatted data populated into memory and a 64K pool to store metadata about the objects populated into the IM columns store.  V$INMEMORY_AREA shows the total IM column store.  The COLUMN command in these scripts identifies the column you want to format and the model you want to use.  

    ````
    <copy>
    column alloc_bytes format 999,999,999,999;
    column used_bytes format 999,999,999,999;
    column populate_status format a15;
    --QUERY

    select * from v$inmemory_area;
    </copy>
    ````


3.  To check if the IM column store is populated with object, run the query below.

    ````
    <copy>
    column name format a30
    column owner format a20
    --QUERY

    select v.owner, v.segment_name name, v.populate_status status from v$im_segments v;
    </copy>
    ````

 4. Let us create a table and enable In-Memory.

    ````
    <copy>
    CREATE TABLE bonus (id number, emp_id number, bonus NUMBER, year date ) INMEMORY ;
    </copy>
    ````

 5. Check the in-memory attributes of PARTS by querying USER_TABLES. The columns to check are INMEMORY, INMEMORY\_PRIORITY, INMEMORY\_COMPRESSION, INMEMORY\_DISTRIBUTE and INMEMORY\_DUPLICATE.
     ````
     <copy>
     SELECT INMEMORY, INMEMORY_PRIORITY, INMEMORY_COMPRESSION, INMEMORY_DISTRIBUTE,
     INMEMORY_DUPLICATE FROM USER_TABLES WHERE TABLE_NAME = 'BONUS';
     </copy>
     ````
     ````
     SQL>  SELECT INMEMORY, INMEMORY_PRIORITY, INMEMORY_COMPRESSION, INMEMORY_DISTRIBUTE,
     INMEMORY_DUPLICATE FROM USER_TABLES WHERE TABLE_NAME = 'BONUS';  2

     INMEMORY INMEMORY INMEMORY_COMPRESS INMEMORY_DISTRI INMEMORY_DUPL
     -------- -------- ----------------- --------------- -------------
     ENABLED  NONE     FOR QUERY LOW     AUTO            NO DUPLICATE
     ````

   As you can observer, When we enable a table with INMEMORY, the INMEMORY PRIORITY is NONE and the COMPRESSION is set to *FOR QUERY LOW*.
   With no priority settings for In-Menory, the table will gets loaded the next time a query accesses the table.


  4.  Enabling priority for Table loading.
   The order in which objects are populated is controlled by the keyword PRIORITY, which has five levels. The default PRIORITY is NONE, which means an object is populated only after it is scanned for the first time. All objects at a given priority level must be fully populated before the population of any objects at a lower priority level can commence. However, the population order can be superseded if an object without a PRIORITY is scanned, triggering its population into IM column store.

   To enable an existing table for the IM column store, you would use the ALTER table DDL with the INMEMORY clause and the PRIORITY parameter. The syntax for this statement is:
  	ALTER TABLE … INMEMORY PRIORITY [NONE|LOW|MEDIUM|HIGH|CRITICAL]
    ````
    <copy>
    ALTER TABLE  bonus INMEMORY PRIORITY HIGH ;
    </copy>
    ````

  5. Enabling compression levels
  In-memory compression is specified using the keyword MEMCOMPRESS, a sub-clause of the INMEMORY attribute.
  There are six levels, each of which provides a different level of compression and performance.
  Each successive level typically decreases the amount of memory required to populate the object at a possible reduction in scan performance.

   ![](images/compress.png)


   6. Alter existing tables and enable In-Memory.

      ````
          <copy>
          set echo on
          ALTER TABLE lineorder INMEMORY PRIORITY CRITICAL MEMCOMPRESS FOR QUERY HIGH;
          ALTER TABLE part INMEMORY PRIORITY HIGH;
          ALTER TABLE customer INMEMORY PRIORITY MEDIUM;
          ALTER TABLE supplier INMEMORY PRIORITY LOW;
          ALTER TABLE date_dim INMEMORY;
          </copy>
      ````

  7.  This looks at the USER_TABLES view and queries attributes of tables in the SSB schema.  

      ````
      <copy>
      set pages 999
      column table_name format a12
      column cache format a5;
      column buffer_pool format a11;
      column compression heading 'DISK|COMPRESSION' format a11;
      column compress_for format a12;
      column INMEMORY_PRIORITY heading 'INMEMORY|PRIORITY' format a10;
      column INMEMORY_DISTRIBUTE heading 'INMEMORY|DISTRIBUTE' format a12;
      column INMEMORY_COMPRESSION heading 'INMEMORY|COMPRESSION' format a14;
      --QUERY    

      SELECT table_name, cache, buffer_pool, compression, compress_for, inmemory,
          inmemory_priority, inmemory_distribute, inmemory_compression
      FROM   user_tables;
      </copy>
      ````


  8.  Let's us query the table with noparallel hint. This will ensure that tables with no LOAD priority will get loaded to In-Memory pool.

      ````
      <copy>
      SELECT /*+ full(d)  noparallel (d )*/ Count(*)   FROM   date_dim d;
      SELECT /*+ full(s)  noparallel (s )*/ Count(*)   FROM   supplier s;
      SELECT /*+ full(p)  noparallel (p )*/ Count(*)   FROM   part p;
      SELECT /*+ full(c)  noparallel (c )*/ Count(*)   FROM   customer c;
      SELECT /*+ full(lo) noparallel (lo )*/ Count(*) FROM   lineorder lo;
      </copy>
      ````


9. Background processes are populating these segments into the IM column store.  To monitor this, you could query the V$IM\_SEGMENTS.  Once the data population is complete, the BYTES\_NOT\_POPULATED should be 0 for each segment.  

    ````
    <copy>
    column name format a20
    column owner format a15
    column segment_name format a30
    column populate_status format a20
    column bytes_in_mem format 999,999,999,999,999
    column bytes_not_populated format 999,999,999,999,999
    --QUERY

    SELECT v.owner, v.segment_name name, v.populate_status status, v.bytes bytes_in_mem, v.bytes_not_populated
    FROM v$im_segments v;
    </copy>
    ````



10.  Now let's check the total space usage.

    ````
    <copy>
    column alloc_bytes format 999,999,999,999;
    column used_bytes      format 999,999,999,999;
    column populate_status format a15;
    select * from v$inmemory_area;
    </copy>
    ````


    In this Step you saw that the IM column store is configured by setting the initialization parameter INMEMORY_SIZE. The IM column store is a new static pool in the SGA, and once allocated it can be resized dynamically, but it is not managed by either of the automatic SGA memory features.

    You also had an opportunity to populate and view objects in the IM column store and to see how much memory they use. In this Lab we populated about 1471 MB of compressed data into the  IM column store, and the LINEORDER table is the largest of the tables populated with over 23 million rows.  Remember that the population speed depends on the CPU capacity of the system as the in-memory data compression is a CPU intensive operation. The more CPU and processes you allocate the faster the populations will occur.

11. To disable a table for the IM column store, use the NO INMEMORY clause. Once a table is disabled, its information is purged from the data dictionary views, metadata from the IM column store is cleared, and its in-memory column representation invalidated.

    ````
    <copy>
    ALTER TABLE bonus NO INMEMORY;
    </copy>
    ````

12.	Check the in-memory attributes for table.

    ````
    <copy>
    SELECT INMEMORY, INMEMORY_PRIORITY, INMEMORY_COMPRESSION, INMEMORY_DISTRIBUTE, INMEMORY_DUPLICATE
    FROM USER_TABLES
    WHERE TABLE_NAME = 'BONUS';
    </copy>
    ````

    We have learnt to how to add In-Memory attributes to tables, add priority and compress options. Oracle Database In-Memory is designed to be completely and seamlessly compatible with existing applications. No changes are required to use it with any application or tool that runs against Oracle Database. Analytic queries are automatically routed to the column store by the SQL optimizer, and transactional semantics are guaranteed by the database.

## Task 3: Partial In-Memory Data

### Partition In-Memory
1. In order to conserve the In-Memory pool in SGA, we need not load all the data. In case of a Big partitioned table, we can load only the partition that is relevant.
Also, each partition can be compressed to a different level and have different priority for loading. Below is a example.

    ````
    <copy>
    CREATE TABLE list_customers
    ( customer_id             NUMBER(6)
    , cust_first_name         VARCHAR2(20)
    , cust_last_name          VARCHAR2(20)
    , cust_address            VARCHAR2(40)
    , nls_territory           VARCHAR2(30)
    , cust_email              VARCHAR2(40))
    PARTITION BY LIST (nls_territory) (
    PARTITION asia VALUES ('CHINA', 'THAILAND')
            INMEMORY MEMCOMPRESS FOR CAPACITY HIGH PRIORITY HIGH,
    PARTITION europe VALUES ('GERMANY', 'ITALY', 'SWITZERLAND')
            INMEMORY MEMCOMPRESS FOR CAPACITY LOW,
    PARTITION west VALUES ('AMERICA')
            INMEMORY MEMCOMPRESS FOR CAPACITY LOW,
    PARTITION east VALUES ('INDIA')
            INMEMORY MEMCOMPRESS FOR CAPACITY HIGH,
    PARTITION rest VALUES (DEFAULT) NO INMEMORY);
    </copy>
    ````

### Partital Columns In-Memory.
By default, all of the columns in an object with the INMEMORY attribute will be populated into the IM column store.
However, it is possible to populate only a subset of columns. If a table has many columns, but the query only accesses a few columns, then it is possible to load only those columns into InMemory pool. These columns can additionally be loaded with MEMCOMPRESS levels to further conserve memory.
For example, to enable an existing table for the IM column store, you would use the ALTER table DDL statement with the INMEMORY clause, along with the in-memory column clause as shown below.
  ````
	. ALTER TABLE … 	INMEMORY (col1)
	. ALTER TABLE … 	INMEMORY (col1, col2)
	. ALTER TABLE … 	NO INMEMORY (col1, col2)
	. ALTER TABLE … 	INMEMORY MEMCOMPRESS QUERY LOW (col1)
	. ALTER TABLE … 	INMEMORY MEMCOMPRESS QUERY HIGH (col2) NO INMEMORY (col3) INMEMORY PRIORITY HIGH
 ````
2. Enable partial columns for In-Memory.

    ````
    <copy>
    ALTER TABLE BONUS INMEMORY  
    INMEMORY    (emp_id,bonus,year)
    NO INMEMORY (id) ;
    </copy>
    ````

3. check the In-Memory parameters at column level.
    ````
    <copy>
    col table_name format a10
    col column_name format a20
    col inmemory_compression format a20
    SELECT TABLE_NAME, COLUMN_NAME, INMEMORY_COMPRESSION
    FROM V$IM_COLUMN_LEVEL
    WHERE TABLE_NAME = 'BONUS'; </copy>

    TABLE_NAME COLUMN_NAME          INMEMORY_COMPRESSION
    ---------- -------------------- --------------------
    BONUS      ID                   NO INMEMORY
    BONUS      EMP_ID               DEFAULT
    BONUS      BONUS                DEFAULT
    BONUS      YEAR                 DEFAULT

    ````
 Note: Before 21c, Oracle optimizer will not choose the In-Memory table if all the rows in the select and filter are not loaded into memory.
 Starting in 21c, there is a new feature called **HYBRID SCAN**.  In-memory hybrid scans can access some data from the IM column store, and some data from the row store, when not all columns in a table have been populated into the In-Memory Column Store, improving performance by orders of magnitude over pure row store queries.


 ![](images/IMHybrid.png)

## Task 4: In-Memory External Tables
In-Memory External Tables builds on the theme of expanding analytic queries to all data, not just Oracle native data. Oracle Database already supports accessing external data with features like External Tables and Big Data SQL to allow fast and secure SQL query on all types of data. In-Memory External Tables allow essentially any type of data to be populated into the IM column store. This means non-native Oracle data can be analyzed with any data in Oracle Database using Oracle SQL and its rich feature set and also get the benefit of using all of the performance enhancing features of Database In-Memory.
Until 19c , this feature is licensed for only Oracle Cloud databases and  Engineered Systems. We can still test the feature on EE after setting  "\_exadata\_feature_on" to true. This feature is available in 21c EE releases.

 ![](images/IMExternal.png)

1. Create an external table on a comma separated text file in /home/oracle/labs.

    ````
    <copy>
    connect / as sysdba
    show pdbs
    alter session set container=orclpdb;
    create or replace directory ext_dir as '/home/oracle/labs' ;
    grant read, write on directory ext_dir to ssb;
    connect ssb/Ora_DB4U@localhost:1521/orclpdb

    CREATE  TABLE ext_emp ( ID NUMBER(6), FIRST_NAME VARCHAR2(20),
        LAST_NAME VARCHAR2(25), EMAIL VARCHAR2(25),
        PHONE_NUMBER VARCHAR2(20), HIRE_DATE DATE,
        JOB_ID VARCHAR2(10), SALARY NUMBER(8,2),
        COMMISSION_PCT NUMBER(2,2), MANAGER_ID NUMBER(6),
        DEPARTMENT_ID NUMBER(4)
        )
        ORGANIZATION EXTERNAL
        ( TYPE ORACLE_LOADER  DEFAULT DIRECTORY ext_dir
        ACCESS PARAMETERS
        (records delimited by newline
        badfile ext_dir:'empxt%a_%p.bad'
        logfile ext_dir:'empxt%a_%p.log'
        fields terminated by ','  missing field values are null
        (ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER,
            HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT,
            MANAGER_ID, DEPARTMENT_ID)
            )
        LOCATION ('empext1.dat')
        )
    REJECT LIMIT UNLIMITED
    INMEMORY;
    </copy>
    ````

2. Query the table. Note: External tables will not populate upon query..
    ````
    <copy>
    set linesize 200
    set pages 10
    select count(*) from  ext_emp;
    SELECT * FROM table(dbms_xplan.display_cursor());
    </copy>
    PLAN_TABLE_OUTPUT
    --------------------------------------------------------------------------------
    SQL_ID  gsd9fmyquwh5c, child number 0
    -------------------------------------
    select count(*) from  ext_emp
    Plan hash value: 546827939
    -------------------------------------------------------------------------------
    PLAN_TABLE_OUTPUT
    --------------------------------------------------------------------------------
    | Id  | Operation                   | Name    | Rows  | Cost (%CPU)| Time     |
    -------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT            |         |       |   341 (100)|          |
    |   1 |  SORT AGGREGATE             |         |     1 |            |          |
    |   2 |   EXTERNAL TABLE ACCESS FULL| EXT_EMP |   102K|   341   (1)| 00:00:01 |
    -------------------------------------------------------------------------------

    ````
Note that in the above plan *EXTERNAL TABLE ACCESS FULL* would mean that oracle is still doing a scan of external table on disk and has not loaded the table to In-Memory.

3. Unlike regular tables, external table does not get populated into In-Memory even if it has INMEMORY parameter on the external table. Confirm if it is not populated.

    ````
    <copy>
    col owner format A10
    col segment_name format A20

    SELECT owner, segment_name, populate_status, con_id FROM v$im_segments where segment_name='EXT_EMP';
    </copy>
    ````

4. Populate the external table (manually) and verify that the population is complete.
    External tables need to be manually populated
    ````
    <copy>
    EXEC dbms_inmemory.populate ('SSB','EXT_EMP')


    SELECT owner, segment_name, populate_status, con_id FROM v$im_segments where segment_name='EXT_EMP';
    </copy>

    OWNER      SEGMENT_NAME         POPULATE_STAT     CON_ID
    ---------- -------------------- ------------- ----------
    SSB        EXT_EMP              COMPLETED              3

    ````

5. Query In-Memory external table.

    Sessions that query In-Memory external tables must have the initialization parameter QUERY\_REWRITE\_INTEGRITY set to stale\_tolerated. It is important to keep in mind that if an external table is modified, then the results from the IM column store are undefined. Results are also undefined if a partition is altered (by dropping or adding values). This may lead to differences in results between IM and non-IM based scans. You can run DBMS_INMEMORY.REPOPULATE to refresh the IM store so that it is resynchronized with the table data.

    ````
    <copy>
    col plan_table_output format a140
    ALTER SESSION SET QUERY_REWRITE_INTEGRITY=stale_tolerated;

    SELECT count(*) FROM ext_emp ;
    SELECT * FROM table(dbms_xplan.display_cursor());
    </copy>

    SQL>
    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------
    SQL_ID  d720xtyhhdfx0, child number 0
    -------------------------------------
    SELECT count(*) FROM ext_emp
    Plan hash value: 546827939

    ----------------------------------------------------------------------------------------

    PLAN_TABLE_OUTPUT
    ------------------------------------------------------------------------------------------
    | Id  | Operation                            | Name    | Rows  | Cost (%CPU)| Time     |
    ----------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT                     |         |       |   341 (100)|          |
    |   1 |  SORT AGGREGATE                      |         |     1 |            |          |
    |   2 |   EXTERNAL TABLE ACCESS INMEMORY FULL| EXT_EMP |   102K|   341   (1)| 00:00:01 |
    ----------------------------------------------------------------------------------------
    ````
Notice that the plan changed from *EXTERNAL TABLE ACCESS FULL* to *EXTERNAL TABLE ACCESS INMEMORY FULL*.
Note that if you append data to the external file, you will have to repopulate to In-Memory.

## Task 5: In-Memory FastStart

![](images/IMFaststart.png)

In-Memory FastStart was introduced in 12.2 to speed up the re-population of the IM column store when an instance is restarted. IM FastStart works by periodically checkpointing IMCUs to a designated IM FastStart tablespace. This is done automatically by background processes. The motivation for FastStart is to reduce the I/O and CPU intensive work required to convert row based data into columnar data with the associated compression and IM storage indexes that are part of the population process. With IM FastStart the actual columnar formatted data is written out to persistent storage and can be read back faster and with less I/O and CPU than if the data has to be re-populated from the row-store. It is also worth noting that if the IM FastStart tablespace fills up or becomes unavailable the operation of the IM column store is not affected.

The IM FastStart area does not change the behavior of population. Priorities are still honored and if data is not found in the IM FastStart area, that is it hasn't been written to the IM FastStart area yet or it has been changed, then that data is read from the row-store. If a segment is marked as "NO INMEMORY" then it is removed from the IM FastStart area. The bottom line is that IM FastStart hasn't changed the way Database In-Memory works, it just provides a faster mechanism to re-populate in-memory data.

So how does this work? The first thing you have to do is to enable IM FastStart. You do this by designating a tablespace that you create as the IM FastStart tablespace. It must be empty and be able to store the contents of the IM column store. Oracle recommends that the tablespace be sized at twice the size of the INMEMORY_SIZE parameter setting.

1. Enable FastStart

    ````
    <copy>
    conn / as sysdba
    alter session set container=orclpdb;
    exec dbms_inmemory_admin.faststart_enable('USERS', FALSE);
    </copy>
    ````

2. Verify that FastStart is enabled.
    ````
    <copy>
    column tablespace_name format a10
    select tablespace_name, status, allocated_size, used_size from
    v$inmemory_faststart_area;
    </copy>

    TABLESPACE STATUS     ALLOCATED_SIZE  USED_SIZE
    ---------- ---------- -------------- ----------
    USERS      ENABLE         2368471040 2215837696
    ````
3. The actual IM FastStart data is written to a SecureFile LOB in the IM FastStart tablespace. You can display the LOB information from the DBA_LOBS view:
    ````
    <copy>
    column segment_name format a20
    select segment_name, logging from dba_lobs where tablespace_name='USERS';
    </copy>

    SEGMENT_NAME         LOGGING
    -------------------- -------
    SYSDBIMFS_LOBSEG$    YES

    ````
4. To Disable In-Memory FastStart run the following.
    ````
    <copy>
    exec DBMS_INMEMORY_ADMIN.FASTSTART_DISABLE();
    </copy>
    ````
We have looked at how we can configure In-Memory pool. Alter table InMemory properties and how to load them. Next we will look at some of the optimizations to speed up queries.

## Acknowledgements

- **Authors/Contributors** - Vijay Balebail, Andy Rivenes, Maria Colgan
- **Reviewers** - Bob Mackowiak, Rajeev Rumale
- **Last Updated By/Date** - Kamryn Vinson, July 2021