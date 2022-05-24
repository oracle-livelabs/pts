# In-Memory Mixed workload

## Introduction

In a OLTP production environment, it is common to expect the database to run 1000s of transactions with very little toleration to poor throughput. In such environments, running reports and analytical queries can take a lot of resources and can bring down the throughput of the system. In such cases, it is a common strategy to make a redundant copy of data in a data warehouse system where analytic queries are run.

If there are reports running on OLTP production database, we usually have several indexes to ensure that the reports run efficiently. However, these additional access structures cause performance overhead because you must create, manage, and tune them. For example, inserting a single row into a table requires an update to all indexes on this table, which increases response time.
 Now with in-memory , these queries can run without the need of additional reporting indexes. The amount of CPU cycles needed to query the data for reporting is less. This helps to improve the overall throughput of DML operations by elimination of indexes. At the same time reports run faster.
 ![](../images/lessIndexs.png)


### <B> So how is In-Memory synchronized when we do DML operations on the underlying tables ? </B>
The IM column store is always transactionally consistent with the data on disk. This is done through 2 background activities.

 - <b>Repopulation of the IM Column Store :</b> The automatic refresh of columnar data after significant modifications is called repopulation. When DML occurs for objects in the IM column store, the database repopulates them automatically.
 Automatic repopulation takes the following forms:
      - Threshold-based repopulation : This form depends on the percentage of stale entries in the transaction journal for an IMCU.

      - Trickle repopulation : This form supplements threshold-based repopulation by periodically refreshing columnar data even when the staleness threshold has not been reached.

 During automatic repopulation, traditional access mechanisms are available. Data is always accessible from the buffer cache or disk. Additionally, the IM column store is always transactionally consistent with the data on disk. No matter where the query accesses the data, the database always returns consistent results.


 - <b>Row Modifications and the Transaction Journal :</b> An In-Memory Compression Unit (IMCU) is a read-only structure that does not modify data in place when DML occurs on an under underlying table. The Snapshot Metadata Unit (SMU) associated with each IMCU tracks row modifications in a transaction journal. If a query accesses the data, and discovers modified rows, then it can obtain the corresponding rowids from the transaction journal, and then retrieve the modified rows from the buffer cache. As the number of modifications increase, so do the size of SMUs, and the amount of data that must be fetched from the transaction journal or database buffer cache. To avoid degrading query performance through journal access, background processes repopulate modified objects.



Watch a preview video of querying the In-Memory Column Store

[](youtube:U9BmS53KuGs)

###  DML and In-Memory tables

It is clear by now that the IM column store can dramatically improve performance of all types of queries but very few database environments are read-only. For the IM column store to be truly effective in modern database environments it has to handle both analytical reports AND online transaction processing (OLTP).
We will test how the Oracle Database In-Memory is the only in-memory column store that can handle both Analytical queries  and online transaction processing today.

## Task 1: BULK LOADS and In-Memory tables.
Bulk data loads occur most commonly in Data Warehouse environments and are typically use direct path load. A direct path load parses the input data, converts the data for each input field to its corresponding Oracle data type, and then builds a column array structure for the data. These column array structures are used to format Oracle data blocks and build index keys. The newly formatted database blocks are then written directly to the database, bypassing the standard SQL processing engine and the database buffer cache.
Once the load operation (direct path or non-direct path) has been committed, the IM column store is instantly aware it does not have all of the data populated for the object. The size of the missing data will be visible in the BYTES\_NOT\_POPULATED column of V$IM_SEGMENTS. If the object has a PRIORITY specified on it then the newly added data will be automatically populated into the IM column store. Otherwise the next time the object is queried, the background worker processes will be triggered to begin populating the missing data, assuming there is free space in the IM column store.


1.	Using SQL*Plus, connect as LABUSER.
     ````
     <copy> CONNECT  ssb/Ora_DB4U@localhost:1521/orclpdb </copy>
     ````

2.	Create a new SALES1 table as an empty copy of PART with INMEMORY .
    ````
    <copy> CREATE TABLE PART1 INMEMORY AS SELECT * FROM  PART WHERE 1=2; </copy>
    ````

3.	Load data into PART1 via a bulk load operation (non-direct path). Do NOT COMMIT the transaction yet.

    ````
    <copy>
     INSERT INTO PART1 SELECT * FROM PART WHERE ROWNUM <=10000;
    </copy>
    ````
4.	Check if the PART1 table got populated into the IM column store by querying V$IM_SEGMENTS. What do you observe?
    ````
    SQL> <copy>
    COL SEGMENT_NAME FORMAT A20
    SELECT SEGMENT_NAME, POPULATE_STATUS, BYTES, BYTES_NOT_POPULATED
    FROM V$IM_SEGMENTS WHERE SEGMENT_NAME = 'PART1';
     </copy>

    no rows selected
    ````

5.	As the data was not committed, the IM column store will not be able to see the changes and hence cannot be populated to the column store. COMMIT the changes so they are visible to the column store.

    ````
    SQL> <copy>COMMIT;</copy>

    Commit complete.
    ````
6.	Recheck V$IM_SEGMENTS.
    ````
    SQL> <copy>SELECT * FROM V$IM_SEGMENTS WHERE SEGMENT_NAME = 'PART1';</copy>

    no rows selected
    ````

7.	Notice that PART1 still did not get populated even though you had performed a COMMIT. Why?
    This is because the initial population is only triggered by querying the table via full table scan, using DBMS_INMEMORY.POPULATE or by specifying the PRIORITY clause, none of which was done in this case.

8.	Next, check the following session statistics:

    -	IM populate segments requested. The number of times the session has requested for In-Memory population of a segment.
    -	IM transactions. Transactions issued by the session to In-Memory tables (i.e. the number of times COMMITs have been issued).
    -	IM transactions rows journaled. Count of rows logged in the Transaction Journal by the session. Transaction Journal is discussed in the DML section.
    ````
    <copy> SELECT DISPLAY_NAME, VALUE  
    FROM V$MYSTAT m, V$STATNAME n
    WHERE m.STATISTIC# = n.STATISTIC#
    AND n.DISPLAY_NAME IN (
    'IM populate segments requested',
    'IM transactions',
    'IM transactions rows journaled');
     </copy>

    DISPLAY_NAME                                 VALUE
    ------------------------------------------   --------
    IM transactions                               1
    IM transactions rows journaled                10000
    IM populate segments requested                0
    ````
 9. In the above output, observe the following:
    -	IM populate segments requested. Segment population requested should be 0, as the column store population has not been triggered.
    -	IM transactions. There was one COMMIT issued.
    -	IM transactions rows journaled. The total number of rows loaded in the session so far is 10000.

10.	Let’s manually trigger a population using DBMS_INMEMORY.POPULATE procedure.

    ````
    SQL> <copy> EXEC DBMS_INMEMORY.POPULATE('SSB','PART1',NULL);
         </copy>
    PL/SQL procedure successfully completed.
    ````
11.	Check the population status now. You may need to run the below query a few times until you see an entry for PART1 with BYTES\_NOT\_POPULATED as 0.

    ````
    <copy>
    COL SEGMENT_NAME FORMAT A20
    SELECT SEGMENT_NAME, POPULATE_STATUS, BYTES, BYTES_NOT_POPULATED
    FROM V$IM_SEGMENTS WHERE SEGMENT_NAME = 'PART1'; </copy>

    SEGMENT_NAME         POPULATE_STAT      BYTES BYTES_NOT_POPULATED
    -------------------- ------------- ---------- -------------------
    PART1                COMPLETED        1998848                   0

    ````
12.	Using V$IM\_SEGMENTS\_DETAIL, check the number of extents and blocks for SALES1, both on disk and in-memory. Note that the number of blocks loaded in-memory (i.e. mapped to IMCUs) may be different from on-disk blocks as only the used blocks get populated into the column store.
    ````
    <copy>
    COL OBJECT_NAME FORMAT A11
    set linesize 200
    SELECT a.OBJECT_NAME, b.MEMBYTES, b.EXTENTS, b.BLOCKS,
    b.DATABLOCKS, b.BLOCKSINMEM, b.BYTES
    FROM V$IM_SEGMENTS_DETAIL b, DBA_OBJECTS a
    WHERE a.DATA_OBJECT_ID = b.DATAOBJ
    AND a.OBJECT_NAME =  'PART1'; </copy>

    OBJECT_NAME   MEMBYTES    EXTENTS     BLOCKS DATABLOCKS BLOCKSINMEM      BYTES
    ----------- ---------- ---------- ---------- ---------- ----------- ----------
    PART1          1310720         17        256        244         244    2097152
    ````

	From the above output, observe that PART1 so far has 17 extents, 256 allocated on-disk blocks (BLOCKS) and 244 used blocks (DATABLOCKS), All rows in 244 blocks on disk are loaded into the IM column store (BLOCKSINMEM).

  Note: If the table does not have PRIORITY ENABLED and you execute another Bulk Load, then those segments will be populated either during the next query or when you execute DBMS_INMEMORY.POPULATE (Step 10).

## Task 2: DML and Trickle repopulation.

 We now understand that the Data population to InMemory happens to new extents (Bulk Load and Direct Path Loads). However, if data is not inserted into new data extents on disks, but inserted or updated in the existing data blocks in the free space within the data blocks, then this data is not immediately loaded into In-Memory. Oracle creates  a transactional journal. The Snapshot Metadata Unit (SMU) associated with each IMCU tracks row modifications in a transaction journal. If a query accesses the data, and discovers modified rows, then it can obtain the corresponding rowids from the transaction journal, and then retrieve the modified rows from the buffer cache. As the number of modifications increase, so do the size of SMUs, and the amount of data that must be fetched from the transaction journal or database buffer cache. To avoid degrading query performance through journal access, background processes repopulate modified objects.

1.	Load a few rows into PART1 via IAS (Insert as Select). Commit the changes so they become visible to the IM column store.
    ````
    <copy>
    INSERT INTO PART1 SELECT * FROM PART WHERE ROWNUM <=1000;

    COMMIT; </copy>
    ````

2.	Check the session statistics once again and observe the change.
    ````
    <copy>
    SELECT DISPLAY_NAME, VALUE  FROM V$MYSTAT m, V$STATNAME n
    WHERE m.STATISTIC# = n.STATISTIC#
    AND n.DISPLAY_NAME IN (
    'IM populate segments requested',
    'IM transactions',
    'IM transactions rows journaled'); </copy>

    DISPLAY_NAME                                 VALUE
    ------------------------------------------   --------
    IM transactions                                     2
    IM transactions rows journaled                  11000
    IM populate segments requested                      1
    ````
	From the above output, the IM transactions are now incremented to 2 (one additional due to the recent COMMIT) and the number of IM transactions rows journaled are now 11000 (reflecting the newly added 1000 rows on top of 10000).

3.	Check if the rows that just got inserted resulted in new extents being added to the on-disk table.
    ````
    <copy>
    COL OBJECT_NAME FORMAT A11
    SELECT a.OBJECT_NAME, b.MEMBYTES, b.EXTENTS, b.BLOCKS,
    b.DATABLOCKS, b.BLOCKSINMEM, b.BYTES
    FROM V$IM_SEGMENTS_DETAIL b, DBA_OBJECTS a
    WHERE a.DATA_OBJECT_ID = b.DATAOBJ
    AND a.OBJECT_NAME =  'PART1';
    </copy>

    OBJECT_NAME   MEMBYTES    EXTENTS     BLOCKS DATABLOCKS BLOCKSINMEM      BYTES
    ----------- ---------- ---------- ---------- ---------- ----------- ----------
    PART1          1310720         17        256        244         244    2097152

    ````

4. As you observe from the above output, no new extents were added as only a few rows were loaded (1000 rows). The table hasn’t grown its on-disk footprint, and still has 17 extents, 244 DATABLOCKS and 244 BLOCKSINMEM.
If the table would have grown its on-disk footprint, the rows in the new extents would not have been automatically populated into the column store, unless a non-default PRIOIRTY is specified or the table got accessed, or the procedure DBMS_INMEMORY.PROPULATE was used.
If the new rows got added to existing extents/blocks, the new rows should be populated to the IM column store via the *Trickle Repopulate process*, even when a default PRIORITY is specified on the table.

5.	Check the V$IM\_SEGMENTS view and observe the value in BYTES\_NOT\_POPULATED column. Do you think a 0 in this column indicate that all the new rows have been added to the column store ?

    ````
    <copy>
    COL SEGMENT_NAME FORMAT A20

    SELECT SEGMENT_NAME, POPULATE_STATUS, BYTES, BYTES_NOT_POPULATED
    FROM V$IM_SEGMENTS WHERE SEGMENT_NAME = 'PART1';
    </copy>

    SEGMENT_NAME         POPULATE_STAT      BYTES BYTES_NOT_POPULATED
    -------------------- ------------- ---------- -------------------
    PART1                COMPLETED        1998848                   0

    ````
BYTES\_NOT\_POPULATED only indicates the bytes in the new extents that got added to the segment and have not been populated to the column store. If the new rows get inserted into the existing extents, BYTES\_NOT\_POPULATED will still be 0 and new rows may still be not populated. This how the V$IM\_SEGMENTS view behaves currently.
Next, check if the newly added rows got populated to the IM column store using V$IM\_HEADER view. This view contains details about all IMCUs (incl. split IMCUs) for all segments that are loaded into the column store.

6. The number of rows contained within an IMCU can be observed in the v$im\_header dynamic performance view. You may have to run the below query a few times in order to for TRICKLE\_REPOPULATE to be set to 1.

    ````
    <copy>
    COL OBJECT_NAME FORMAT A11
    SELECT b.OBJECT_NAME, a.PREPOPULATED, a.REPOPULATED, a.TRICKLE_REPOPULATED, a.NUM_DISK_EXTENTS, a.NUM_BLOCKS, a.NUM_ROWS, a.NUM_COLS FROM V$IM_HEADER a, DBA_OBJECTS b WHERE a.OBJD = b.DATA_OBJECT_ID  AND b.OBJECT_NAME =  'PART1';
    </copy>

    OBJECT_NAM PREPOPULATED REPOPULATED TRICKLE_REPOPULATED NUM_DISK_EXTENTS NUM_BLOCKS   NUM_ROWS NUM_COLS
    ---------- ------------ ----------- ------------------- ---------------- ---------- ---------- -------
    PART1                 0           1                   1               17        244      11000        9

    ````


Below are the observations from the above output:
-	There is only one IMCU (evident from the presence of only a single row in the output).
- 	The number of on-disk rows mapped to this IMCU is 11000, which means that the newly added 1000 rows were also recorded in the journal.
- A total of 17 disk extents have been mapped to this IMCU.
- The REPOPULATED flag and the TRICKLE_REPOPULATED flag for this IMCU has been set to 1 (indicating that the trickle repopulate process has synchronized the changes).
- The trickle repopulate process must have populated the last 1000 rows.

Note : When inserting data through direct path load, the data is inserted into newer extents. This data will be populated automatically if table PRIORITY is set. If no PRIORITY is set, Loading is triggered when the table is queried by a SQL statement or when we use DBMS_INMEMORY.POPULATE( Step 10 )

7. Run the following query to view Population status and the number of IMCUs of all the In-Memory tables.

    ````
        <copy>
        SELECT a.OBJECT_NAME, b.INMEMORY_PRIORITY, b.POPULATE_STATUS, COUNT(1) IMCUs, SUM(num_rows),
        TO_CHAR(c.CREATETIME, 'MM/DD/YYYY HH24:MI:SS.FF2') START_POP, TO_CHAR(MAX(d.TIMESTAMP),'MM/DD/YYYY HH24:MI:SS.FF2') FINISH_POP FROM DBA_OBJECTS a, V$IM_SEGMENTS b,
        V$IM_SEGMENTS_DETAIL c, V$IM_HEADER d
        WHERE
        a.OBJECT_NAME = b.SEGMENT_NAME
        AND a.OBJECT_TYPE = 'TABLE'
        AND a.OBJECT_ID = c.BASEOBJ
        AND c.DATAOBJ = d.OBJD
        GROUP BY a.OBJECT_NAME, b.INMEMORY_PRIORITY, b.POPULATE_STATUS, c.CREATETIME ORDER BY FINISH_POP;
        </copy>
    ````

  In this section, we discussed how data is transparently loaded into In-Memory. Next we will discuss the impact of DML on In-Memory queries.

## Task 3: In-Memory workload Query Performance.

  In mixed workload environments, DML I/O operations have little impact on In-Memory queries as In-Memory operations are mainly CPU and memory bound.
  To demonstrate this we will run the following 4 scenarios:

      - Base RUN  : run queries without any load.
      - Batch RUN : run queries while, loading 10000 rows to Lineorder.
      - DML RUN   : run queries while inserting 500 rows to lineorder and commiting after each row.
      - ALL       : run queries while, batch and DML operating are happening.


1. Setup: Run the following DDL to create the the procedure that will run 3 queries in a loop.

      ````
      <copy>
      CREATE TABLE RUN_TIME
    (
      ID NUMBER GENERATED ALWAYS AS IDENTITY, RUN_TYPE VARCHAR2(30) ,
      QX CHAR(2) , QRUN_TIME NUMBER
    ) ;

    create or replace procedure query_performance(run_type in varchar2, run_count in number)
    is
    t1 integer;
    t2 integer;
    t3 integer;
    t4 integer;
    c1 SYS_REFCURSOR;
    v_stmt_str1      VARCHAR2(200);
    v_stmt_str2      VARCHAR2(2000);
    v_stmt_str3      VARCHAR2(2000);
    lo_orderkey1     lineorder.lo_orderkey%type;
    lo_custkey1     lineorder.lo_custkey%type;
    lo_revenue1     lineorder.lo_revenue%type;
    begin

    /* Q1 : Simple query with 3 filter conditions */
    v_stmt_str1 := 'select lo_orderkey, lo_custkey, lo_revenue from LINEORDER where lo_custkey = 5641 and lo_shipmode = ''XXX AIR'' and lo_orderpriority = ''5-LOW''';

    /* Q2 : Ad-Hoc query with join on time dimension and 3 filter conditions*/
    v_stmt_str2 := ' SELECT SUM(lo_extendedprice * lo_discount) revenue FROM   lineorder l,
      date_dim d
      WHERE  l.lo_orderdate = d.d_datekey
      AND    l.lo_discount BETWEEN 2 AND 3
      AND    l.lo_quantity < 24
      AND    d.d_date=''December 24, 1996''';

    /* Q3 : CPU intensive query with full table arithmetic summation*/   
    v_stmt_str3 :=   'SELECT max(lo_ordtotalprice) most_expensive_order,
    sum(lo_quantity) total_items FROM lineorder';

    /* run all 3 queries run_count (400) times. */
    for i in 1..run_count loop
      open c1 for v_stmt_str1 ;
      t1 := dbms_utility.get_time;

      LOOP
        FETCH c1 INTO lo_orderkey1,lo_custkey1, lo_revenue1;
        EXIT WHEN c1%NOTFOUND ;
      END LOOP;
      close c1;
      t2 :=  dbms_utility.get_time;

      /* insert timing into run_time table */
      insert into run_time (run_type ,Qx ,qrun_time) values (run_type,'Q1',(t2-t1)/100);

      open c1 for v_stmt_str2 ;
        FETCH c1 INTO lo_orderkey1;
      close c1;
        t3 :=  dbms_utility.get_time;
        /* insert timing into run_time table */
        insert into run_time (run_type ,Qx ,qrun_time) values (run_type,'Q2',(t3-t2)/100);

      open c1 for v_stmt_str3 ;
        FETCH c1 INTO lo_orderkey1, lo_revenue1;
      close c1;
        t4 :=  dbms_utility.get_time;  
        /* insert timing into run_time table */
        insert into run_time (run_type ,Qx ,qrun_time) values (run_type,'Q3',(t4-t3)/100);

      commit;  
    end loop ;
    commit ;
    end;
    /
    </copy>
    ````
2. Now run the test BASE, BATCH, DML and ALL while queries run in the background..

    ````
    <copy>
    DECLARE

      /*Run the queries as a background job */
      PROCEDURE BACKGROUND_QUERY ( job_name in varchar2) AS
      BEGIN
      Begin
      dbms_scheduler.drop_job('JOB_NAME');
      EXCEPTION WHEN OTHERS THEN NULL;
      END ;
      dbms_scheduler.create_job (
        job_name => JOB_NAME,
        job_type => 'PLSQL_BLOCK',
        job_action => 'BEGIN QUERY_PERFORMANCE('''||job_name||''',400); END;',
        auto_drop =>  TRUE,
        enabled => true    
      );
      commit;
      END;

      /* procedure to wait until job is finished before calling the next job */
      PROCEDURE wait_macro as
      cnt1 number:=1;
      BEGIN
        while cnt1 >= 1 loop
        dbms_lock.sleep (5);
        SELECT count(1) into cnt1 FROM dba_scheduler_running_jobs srj
        WHERE srj.job_name like 'QRUN%';
      end loop;
      end;

    BEGIN
      execute immediate 'truncate table run_time ';

      /* Base RUN  : run queries without any load. */
      BACKGROUND_QUERY('QRUN_BASE');
      WAIT_MACRO();

      /* Batch RUN : run queries while, loading 10000 rows to Lineorder. */
      BACKGROUND_QUERY('QRUN_BATCH');
      EXECUTE IMMEDIATE 'insert /*+ append */ into lineorder select * from lineorder2 where rownum <=10000';
      commit;   
      WAIT_MACRO();

      /* DML RUN   : run queries while inserting 500 rows to lineorder and commiting after each row.*/
      BACKGROUND_QUERY('QRUN_DML');
      for c1 in ( select * from lineorder2 where rownum < 100 ) Loop
          insert into lineorder values (c1."LO_ORDERKEY",c1.LO_LINENUMBER,c1.LO_CUSTKEY,c1.LO_PARTKEY,c1.LO_SUPPKEY,c1.LO_ORDERDATE,c1.LO_ORDERPRIORITY,c1.LO_SHIPPRIORITY,c1.LO_QUANTITY, c1.LO_EXTENDEDPRICE,c1.LO_ORDTOTALPRICE,c1.LO_DISCOUNT, c1.LO_REVENUE,c1.LO_SUPPLYCOST,c1.LO_TAX,c1.LO_COMMITDATE,c1.LO_SHIPMODE ) ;
      end loop;
      commit;
      WAIT_MACRO();


      /* ALL       : run queries while, batch and DML operating are happening.*/
      BACKGROUND_QUERY('QRUN_ALL');
      for c1 in ( select * from lineorder2 where rownum < 100 ) Loop
          insert into lineorder values (c1."LO_ORDERKEY",c1.LO_LINENUMBER,c1.LO_CUSTKEY,c1.LO_PARTKEY,c1.LO_SUPPKEY,c1.LO_ORDERDATE,c1.LO_ORDERPRIORITY,c1.LO_SHIPPRIORITY,c1.LO_QUANTITY, c1.LO_EXTENDEDPRICE,c1.LO_ORDTOTALPRICE,c1.LO_DISCOUNT, c1.LO_REVENUE,c1.LO_SUPPLYCOST,c1.LO_TAX,c1.LO_COMMITDATE,c1.LO_SHIPMODE ) ;
      end loop;
      commit;
      EXECUTE IMMEDIATE 'insert /*+ append */ into lineorder select * from lineorder2 where rownum <=10000';
      commit;
      WAIT_MACRO();
    END;
    /
    </copy>
    ````
This job will run for about 5 minutes. You can run the following query to see the average time each query took under different load conditions.
What you will observe is that the *query performance is consistent* when running (BASE_RUN), or when there is bulk loading (QRUN\_BATCH) or DML(QRUN\_DML), and all (QRUN_ALL) operations are performed on the table being queried. This indicates that  *In-Memory queries are not affected by DML operations*.
    ````
    <copy>
    select run_type,qx, count(1) runs, round(avg(qrun_time),3)
    from run_time  group by run_type,qx order by  qx,run_type;
    </copy>

    RUN_TYPE                       QX       RUNS ROUND(AVG(QRUN_TIME),3)
    ------------------------------ -- ---------- -----------------------
    QRUN_ALL                       Q1        400                    .002
    QRUN_BASE                      Q1        400                    .001
    QRUN_BATCH                     Q1        400                    .001
    QRUN_DML                       Q1        400                    .001
    QRUN_ALL                       Q2        400                    .015
    QRUN_BASE                      Q2        400                    .014
    QRUN_BATCH                     Q2        400                    .015
    QRUN_DML                       Q2        400                    .015
    QRUN_ALL                       Q3        400                    .199
    QRUN_BASE                      Q3        400                    .198
    QRUN_BATCH                     Q3        400                    .199
    QRUN_DML                       Q3        400                    .194
    ````

## Conclusion

In this lab you had an opportunity to try out Oracle’s In-Memory performance claims with queries that run against a table with over 23 million rows (i.e. LINEORDER), which resides in both the IM column store and the buffer cache. In Spite of running DML and BATCH jobs against LINEORDER table and querying the new data added, the performance was not affected. We can conclude that In-Memory operation not only improves query performance, but is not affected by DML or ETL jobs on the underlying table.

Remember, new data added as part of a bulk load operation is only visible after the session performing the DML commits. If the bulk load is done using a direct path operation, the data is written directly to disk and bypasses the buffer cache and the IM column store. The next query that accesses that data will trigger the newly inserted data to be populated into the column store, unless the table is configured with a non-default PRIORITY.
Single row change done via the buffer cache (OLTP style changes), are typically committed immediately and are reflected in the column store as they occur. The buffer cache and the column store are kept transactionally consistent.

## Acknowledgements

- **Author** - Vijay Balebail
- **Last Updated By/Date** - Rajeev Rumale, July 2021
