## Introduction
   This lab introduces complimentary database features that can be combined with In-Memory to provide additional performance gains to analytic queries.

## Task 1: Approximate Query Processing and In-Memory

In-Memory optimization does not improve sorting operations. Sql query performance can further improve performance using "Approximate Query Processing", introduced in Oracle 12c. This feature improve performance of sort operations like DISTINCT, RANK, PERCENTILE, MEDIAN.

Typical accuracy of approximate aggregation is over 97% (with 95% confidence) but use less CPU and avoid the I/0 cost of writing to temp files. These operations execute in the Process Global Area (PGA) of a user sessions. Approximate sort operations are faster while maintaining 95% or more accuracy.   

The functions that provide approximate results are as follows:
- APPROX\_COUNT\_DISTINCT
- APPROX\_COUNT\_DISTINCT_DETAIL
- APPROX\_COUNT\_DISTINCT_AGG
- TO\_APPROX\_COUNT\_DISTINCT
- APPROX\_MEDIAN
- APPROX\_PERCENTILE
- APPROX\_PERCENTILE\_DETAIL
- APPROX\_PERCENTILE\_AGG
- TO\_APPROX\_PERCENTILE
- APPROX\_COUNT
- APPROX\_RANK
- APPROX\_SUM

 “Approximate query processing is primarily used in data discovery applications to return quick answers to explorative queries. Users typically want to locate interesting data points within large amounts of data and then drill down to uncover further levels of detail. For explorative queries, quick responses are more important than exact values.”  

You can utilize Approximate functions without changing Application code. There are three initialization parameters introduced to control which functions should be treated as approximate functions during run time.

The initialization parameters are:
- APROX\_FOR\_AGGREGATION  (TRUE|FALSE)
- APPROX\_FOR\_COUNT_DISTINCT (TRUE|FLASE)
- APPROX\_FOR\_PERCENTILE (ALL| NONE | PERCENTILE\_CONT | PERCENTILE\_CONT DETERMINISTIC | PERCENTILE\_DISC | PERCENTILE\_DISC DETERMINISTIC | ALL DETERMINISTIC )

1. To test this, let us first run the below query from sql-Dev tool "In-Memory Query vs Buffer"

      ````
      <copy>
      select lo_custkey, median(lo_ordtotalprice) from lineorder
      group by  lo_custkey ;
      </copy>
      IN MEMORY PLAN
      Plan hash value: 4230308389

      -------------------------------------------------------------------------------------------------
      | Id  | Operation                   | Name      | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
      -------------------------------------------------------------------------------------------------
      |   0 | SELECT STATEMENT            |           | 80504 |   864K|       | 39801   (3)| 00:00:02 |
      |   1 |  SORT GROUP BY              |           | 80504 |   864K|   459M| 39801   (3)| 00:00:02 |
      |   2 |   TABLE ACCESS INMEMORY FULL| LINEORDER |    23M|   251M|       |  2045  (12)| 00:00:01 |
      -------------------------------------------------------------------------------------------------

      Run #  01 ran in 67.8  seconds
      Run #  02 ran in 96.19  seconds
      ````

2. InMemory query still took less time than buffer. Now run the same query with approx\_for\_percentile set in session level.
3. Run the same SQL query  sql-Dev tool "InMemory Query vs Buffer with sessions"

4. For the query string, enter the same query.

      ````
      <copy>
      select lo_custkey, median(lo_ordtotalprice) from lineorder
      group by  lo_custkey ;
      </copy>
      And for the second parameter "alter_session_statement" enter the following.
      <copy>
      ALTER SYSTEM SET approx_for_count_distinct = TRUE;
      ALTER SESSION SET approx_for_aggregation = TRUE;
      ALTER SESSION SET APPROX_FOR_PERCENTILE=all;
      </copy>
      ````


      ````
      Plan hash value: 3675673598

      -------------------------------------------------------------------------------------------------
      | Id  | Operation                   | Name      | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
      -------------------------------------------------------------------------------------------------
      |   0 | SELECT STATEMENT            |           | 80504 |   864K|       | 39801   (3)| 00:00:02 |
      |   1 |  HASH GROUP BY APPROX       |           | 80504 |   864K|   459M| 39801   (3)| 00:00:02 |
      |   2 |   TABLE ACCESS INMEMORY FULL| LINEORDER |    23M|   251M|       |  2045  (12)| 00:00:01 |
      -------------------------------------------------------------------------------------------------

      Run #  01 ran in 28.6  seconds
      Run #  02 ran in 56.69  seconds
      ````
Observe that the plan has HASH GROUP BY APPROX instead of "SORT GROUP BY"
And the InMemory query tool about 28 seconds which is lesser than the previous InMemory runs.
This feature also speeds up In Buffer runs too. This feature is useful in BI repoers, when we need to build visualization, and summation reports where 95-99% accuracy of data does not alter the overall information conveyed.   

## Task 2: InMemory Materialized Views and Query Rewrite

The best SQL plans are the ones that minimize the amount of work it takes to get the result.  As we observed in the previous labs, In-Memory is very efficient at data filtering and Vector Joins for.  However, if aggregated data and joins are precomputed using Materialized Views, the need to perform these tasks In-Memory can be avoided entirely.
Oracle Materialized Views contain already precomputed aggregates and joins, Oracle Database employs an extremely powerful process called query rewrite to quickly answer queries using materialized views. One of the major benefits of creating and maintaining materialized views is the ability to take advantage of query rewrite, which transforms a SQL statement expressed in terms of tables or views into a statement accessing one or more materialized views that are defined on the detail tables. The transformation is transparent to the end user or application, requiring no intervention and no reference to the materialized view in the SQL statement.

1. By loading Materialized Views into the InMemory pool, we can now access the pre computed joins and aggressions from InMemory. This make Materialized Views extremely useful for enabling BI Dashboards and Data warehouse reports.
Let us test this out. For the same query we ran earlier, we can create a MV and see the performance difference. From sqlprompt or sqldeveloper worksheet, run the following creation script.

      ````
      <copy>
      DROP Materialized view MV_median ;
      CREATE MATERIALIZED VIEW MV_median INMEMORY PRIORITY HIGH
      BUILD IMMEDIATE
      --REFRESH FORCE ON COMMIT
      ENABLE QUERY REWRITE
      AS
      select lo_custkey, median(lo_ordtotalprice) from lineorder
      group by  lo_custkey ;
      </copy>
      ````

2. Run the sql report "In-Memory Query vs in Buffer Cache" and pass the below query.

      ````
      <copy>
      select lo_custkey, median(lo_ordtotalprice) from lineorder
      group by  lo_custkey ;
      </copy>
      ````
The output below.
      ````
      query string is :
      select lo_custkey, median(lo_ordtotalprice) from lineorder
      group by  lo_custkey

      IN MEMORY PLAN
      Plan hash value: 835373166

      ---------------------------------------------------------------------------------------------------
      | Id  | Operation                             | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
      ---------------------------------------------------------------------------------------------------
      |   0 | SELECT STATEMENT                      |           | 80000 |   859K|     3  (34)| 00:00:01 |
      |   1 |  MAT_VIEW REWRITE ACCESS INMEMORY FULL| MV_MEDIAN | 80000 |   859K|     3  (34)| 00:00:01 |
      ---------------------------------------------------------------------------------------------------

      BUFFER CACHE PLAN
      Plan hash value: 835373166

      ------------------------------------------------------------------------------------------
      | Id  | Operation                    | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
      ------------------------------------------------------------------------------------------
      |   0 | SELECT STATEMENT             |           | 80000 |   859K|    54   (2)| 00:00:01 |
      |   1 |  MAT_VIEW REWRITE ACCESS FULL| MV_MEDIAN | 80000 |   859K|    54   (2)| 00:00:01 |
      ------------------------------------------------------------------------------------------

      0 sec in memory, 0 sec in SGA ----
      0 X times faster


      Run #  01 ran in 0  seconds
      Run #  02 ran in .02  seconds
      ````
The query that had taken 28 seconds earlier when doing direct path load query. InMemory takes about 20 milliseconds to get data from Buffer compared to less than a millisecond for InMemory Materialized view.
MVs with query rewrite is powerful as a feature. But when these MVs are inmemory the performance is much more.

For more information about this, check out Oracle **[documentation.](https://docs.oracle.com/en/database/oracle/oracle-database/19/dwhsg/basic-query-rewrite-materialized-views.html#GUID-DB76286B-8557-446B-A6CC-BC987C378076)**

## Result Caching and InMemory

In the previous lab, we saw that materialized views can rewrite any SQL queries that use an underlying join condition or aggregation,  Result Caching is yet another optimization to reduce the amount of work needed to process queries. The Result Cache resides within the Shared pool, and saves the results of previously executed SQL statements for each bind value. If another user executes the exact same query, and there have been no changes to the underlying data, the cached result set can be immediately returned to the user instead of re-processing table data in the Buffer Cache, In-Memory Area, or Physical Storage.
While this feature is not part of In-Memory workshop, it is none the less a neat feature that can further improve performance of BI report and dashboard type applications!
For more information check out the **[documentation.](https://docs.oracle.com/en/database/oracle/oracle-database/19/tgdba/tuning-result-cache.html#GUID-FA30CC32-17AB-477A-9E4C-B47BFE0968A1)**.

## Acknowledgements

- **Author** - Vijay Balebail
- **Last Updated By/Date** - Kamryn Vinson, July 2021
