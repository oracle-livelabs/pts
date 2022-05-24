# Introduction

## Introduction to Oracle In-Memory

Oracle Database In-Memory adds in-memory functionality to Oracle Database for transparently accelerating analytic queries by orders of magnitude, enabling real-time business decisions. Using Database In-Memory, businesses can instantaneously run analytics and reports that previously took hours or days. Businesses benefit from better decisions made in real-time, resulting in lower costs, improved productivity, and increased competitiveness.

Oracle Database In-Memory accelerates both Data Warehouses and mixed workload OLTP databases and is easily deployed under any existing application that is compatible with Oracle Database. No application changes are required. Database In-Memory uses Oracle’s mature scale-up, scale-out, and storage-tiering technologies to cost effectively run any size workload. Oracle’s industry leading availability and security features all work transparently with Oracle Database In-Memory, making it the most robust offering on the market.

Oracle introduced Database In-Memory in Oracle Database Enterprise Edition with the first patch set (12.1.0.2) for Oracle Database 12c Release 1. Database In-Memory has been significantly enhanced in subsequent releases of Oracle Database with additional performance, scalability and manageability features. These features include the ability to automatically manage the contents of the In-Memory column store to maximize the use of memory and increase performance, enhanced mutli-model support, scale-out support with Oracle Real Applications Cluster (RAC) and support for Oracle Multitenant and Oracle Active Data Guard (ADG).

![](images/IMFeatures.png)

## **Dual-Format Database**


**Row Format vs. Column Format**

  ![](images/dbim.png)


Oracle Database has traditionally stored data in a row format. In a row format database, each new transaction or record stored in the database is represented as a new row in a table. That row is made up of multiple columns, with each column representing a different attribute about that record. A row format is ideal for online transaction systems, as it allows quick access to all of the columns in a record since all of the data for a given record are kept together in-memory and on-storage.

A column format database stores each of the attributes about a transaction or record in a separate column structure. A column format is ideal for analytics, as it allows for faster data retrieval when only a few columns are selected but the query accesses a large portion of the data set.

But what happens when a DML operation (insert, update or delete) occurs on each format? A row format is incredibly efficient for processing DML as it manipulates an entire record in one operation (i.e. insert a row, update a row or delete a row). A column format is not as efficient at processing DML, to insert or delete a single record in a column format all the columnar structures in the table must be changed. That could require one or more I/O operations per column. Database systems that support only one format suffer the tradeoff of either sub-optimal OLTP or sub-optimal analytics performance.

Oracle Database In-Memory (Database In-Memory) provides the best of both worlds by allowing data to be simultaneously populated in both an in-memory row format (the buffer cache) and a new in-memory columnar format (in Memory pool )  a dual-format architecture.

With Oracle’s unique approach, there remains a single copy of the table on storage, so there are no additional storage costs or synchronization issues. The database maintains full transactional consistency between the row and the columnar formats, just as it maintains consistency between tables and indexes. The Oracle Optimizer is fully aware of the columnar format: It automatically routes analytic queries to the columnar format and OLTP operations to the row format, ensuring outstanding performance and complete data consistency for all workloads without any application changes.

## **Database In-Memory Column Store**

Database In-Memory uses an In-Memory column store (IM column store), which is a new component of the Oracle Database System Global Area (SGA), called the In-Memory Area. Data in the IM column store does not reside in the traditional row format used by the Oracle Database; instead it uses a new columnar format. The IM column store does not replace the buffer cache, but acts as a supplement, so that data can now be stored in memory in both a row and a columnar format.

![](images/immemory_area.png)

The In-Memory area is sub-divided into two pools: a 1MB pool used to store the actual columnar formatted data populated into memory (i.e. IMCUs), and a 64KB pool used to store metadata about the objects that are populated into the IM column store (i.e. SMUs). The amount of available memory in each pool is visible in the V$INMEMORY_AREA view. The relative size of the two pools is determined by internal heuristics; the majority of the In-Memory area memory is allocated to the 1MB pool.

**In-Memory Compression Unit (IMCU)** A read-only storage unit composed of one or more 1MB extents from the 1MB pool. Each segment populated in the IM column store is made up of one or more IMCUs. Each IMCU contains all columns for a subset of the rows in a populated segment. A one-to-many mapping exists between an IMCU and a set of database blocks. For example, if a table contains columns c1 through c6, and if its rows are stored in 100 database blocks on disk, then IMCU 1 might store the values for all columns for blocks 1-50, and IMCU 2 might store the values for all columns for blocks 51-100.

**Snapshot Metadata Unit (SMU)** A storage unit composed of one or more 64KB extents from the 64KB pool that contains metadata and transactional information for an associated In-Memory Compression Unit (IMCU).

![](images/IMCUs.png)

## **Database In-Memory Technology**

There are four basic architectural elements of the IM column store that enable orders of magnitude faster analytic query processing:

#### 1. Compressed columnar storage

Oracle Database In-Memory supports a pure in-memory columnar format. Columnar formatted data tends to compress well and Database In-Memory compression usually results in a 2-20x compression rate. Analytic queries typically reference only a small subset of the columns in a table and Database In-Memory only accesses the columns needed by a query. Database In-Memory can also operate directly on the column values without having to decompress them first. This allows Database In-Memory to apply any WHERE clause filter predicates and perform aggregations during the scan of the column(s). This greatly reduces the amount of data that needs to be accessed, processed and returned to the SQL execution layer.

#### 2. SIMD Vector Processing

For the data that does need to be scanned in the IM column store, Database In-Memory uses SIMD vector processing (Single Instruction processing Multiple Data values). Instead of evaluating each entry in the column one at a time, SIMD vector processing allows a set of column values to be evaluated together in a single CPU instruction.

The columnar format used in the IM column store has been specifically designed to maximize the number of column entries that can be loaded into the vector registers on the CPU and evaluated in a single CPU instruction. SIMD vector processing enables Database In-Memory to scan billion of rows per second per core instead of millions of rows per second per core with the row-store.

For example, let’s use the SALES table and let’s assume we are asked to find the total number of sales orders that used the PROMO\_ID value of 9999. The SALES table has been fully populated into the IM column store. The query begins by scanning just the PROMO\_ID column of the SALES table. The first 8 values from the PROMO\_ID column are loaded into the SIMD register on the CPU and compared with 9999 in a single CPU instruction (the number of values loaded will vary based on datatype & memory compression used). The number of entries that match 9999 is recorded, then the entries are discarded and another 8 entries are loaded into the register for evaluation. And so on until all of the entries in the PROMO\_ID column have been evaluated.

![](images/vector.png)



#### 3. In-Memory Storage Indexes

A further reduction in the amount of data accessed is possible due to the In-Memory Storage Indexes that are automatically created and maintained on each of the columns in the IM column store. Storage Indexes allow data pruning to occur based on the filter predicates supplied in a SQL statement. An In-Memory Storage Index keeps track of minimum and maximum values for each column in an IMCU. When a query specifies a WHERE clause predicate, the In-Memory Storage Index on the referenced column is examined to determine if any entries with the specified column value exist in each IMCU by comparing the specified value(s) to the minimum and maximum values maintained in the In-Memory Storage Index. If the column value is outside the minimum and maximum range for an IMCU, the scan of that IMCU is avoided.

![](images\IMCUMIN_MAX.png)



For equality, in-list, and some range predicates an additional level of data pruning is possible via the metadata dictionary created for each IMCU when dictionary-based compression is used. The metadata dictionary contains a list of the distinct values for each column within that IMCU. Dictionary based pruning allows Oracle Database to determine if the value being searched for actually exists within an IMCU, ensuring only the necessary IMCUs are scanned.

![](images/DicttionPruning.png)

#### 4. In-Memory Optimized Joins and Reporting

 As a result of massive increases in scan speeds, the Bloom Filter optimization (introduced earlier in Oracle Database 10g) can be commonly selected by the optimizer. With the Bloom Filter optimization, the scan of the outer (dimension) table generates a compact bloom filter which can then be used to greatly reduce the amount of data processed by the join from the scan of the inner (fact) table.

**In-Memory Aggregation** Analytic style queries often require more than just simple filters and joins. They require complex aggregations and summaries.

A new optimizer transformation, called **Vector Group By**, was introduced with Database In-Memory to ensure more complex analytic queries can be processed using new CPU-efficient algorithms.


## **Additional High Performance Database In-Memory Features**

**Join Groups** For hash joins, if there is no filter predicate on the dimension table (smaller table on the left hand side of the join) then a Bloom filter won’t be generated and the join will be executed as a standard hash join.

Join Groups have been added to help improve the performance of standard hash joins in the IM column store. It allows the join columns from multiple tables to share a common dictionary, enabling the hash joins to be conducted on the compressed values in the join columns rather than having to decompress the data and then hash it before conducting the join.

**In-Memory Expressions** :   Analytic queries often contain complex expressions in the select list or where clause predicates that need to be evaluated for every row processed by the query. The evaluation of these complex expressions can be very resource intensive and time consuming.

In-Memory Expressions provide the ability to materialize commonly used expressions in the IM column store. Materializing these expressions not only improves the query performance by preventing the repeated computation of the expression for every row but it also enables the ability to take advantage of all of the In-Memory query performance optimizations when they are accessed.

**In-Memory Optimized Arithmetic :** In-Memory Optimized Arithmetic is a feature that encodes the NUMBER data type as a fixed-width native integer scaled by a common exponent. This enables faster calculations using SIMD hardware. The Oracle Database NUMBER data type has high fidelity and precision. However, NUMBER can incur a significant performance overhead for queries because arithmetic operations cannot be performed natively in hardware.

The In-Memory optimized number format enables native calculations in hardware for segments compressed with the QUERY LOW compression option. Not all row sources in the query processing engine have support for the In-Memory optimized number format so the IM column store stores both the traditional Oracle Database NUMBER data type and the In-Memory optimized number type. This dual storage increases the space overhead, sometimes up to 15%.

**In-Memory Dynamic Scans:**

In-Memory Dynamic Scans (IM dynamic scans) further increase scan performance. When additional CPU is available, IM dynamic scans accelerate In-Memory table scans. IM dynamic scans automatically use idle CPU resources to scan IMCUs in parallel and maximize CPU usage. Because in-memory scans tend to be CPU bound, IM dynamic scans can provide a significant increase in performance of in-memory scans. IM dynamic scans are more flexible than traditional Oracle parallel execution, but the two can work together. IM dynamic scans use multiple lightweight threads of execution within a process and this helps keep the performance overhead low. IM dynamic scans are controlled by Oracle Database Resource Manager and require that a CPU resource plan is enabled (for example, RESOURCE_MANAGER_PLAN=DEFAULT_PLAN).


## **More Information on In-Memory**
 **[Oracle 19c InMemory White paper](https://www.oracle.com/a/tech/docs/twp-oracle-database-in-memory-19c.pdf)**

Database In-Memory Channel [![ ](https://github.com/vijaybalebail/learning-library/raw/master/data-management-library/database/in-memory/intro/images/inmem.png)](https://www.youtube.com/channel/UCSYHgTG68nrHa5aTGfFH4pA)

Oracle Database Product Management Videos on In-Memory [![ ](https://github.com/vijaybalebail/learning-library/raw/master/data-management-library/database/in-memory/intro/images/youtube.png)](https://www.youtube.com/channel/UCr6mzwq_gcdsefQWBI72wIQ/search?query=in-memory)

Please proceed to the next lab.

## Acknowledgements

- **Authors/Contributors** - Vijay Balebail, Andy Rivenes, Maria Colgan
- **Reviewers** - Bob Mackowiak, Rajeev Rumale
- **Last Updated By/Date** - Vijay Balebai, Aug 2021
- **Workshop Expiration Date** - July 31, 2023
