# Approximate Similarity Search

## Introduction

This lab walks you through the steps to create vector indexes and run approximate similarity searches for text.

Watch the video below for a quick walk-through of the approximate similarity search lab:

[Approximate Similarity Search](https://videohub.oracle.com/media/Vector-Search-Approximate-Search-Lab/1_zmvlhld8)

Estimated Lab Time: 10 minutes

### About Approximate Similarity Search

In the previous Lab, Exhaustive Search, we performed exhaustive similarity searches which examined each vector in the table. This can be resource intensive, and therefore very time consuming, since examining vector distances are computationally expensive and don't scale well for very large vector datasets. This is where approximate similarity searches have an advantage. Creating vector indexes enables the ability to use approximate similarity search. Instead of checking every possible match, an approximate similarity search uses a class of algorithms referred to as _Approximate Nearest Neighbor_. Using vector indexes helps reduce the number of distance calculations, making searches faster and more efficient with only a slight penalty in accuracy.

There are currently three types of vector indexes available in AI Vector Search:

*	**In-Memory Neighbor Graph Vector Index** – Oracle AI Vector Search supports an in-memory Hierarchical Navigable Small World (HNSW) type of In-Memory Neighbor Graph vector index where vertices represent vectors and edges between vertices represent similarity.  This is an in-memory only index. This type of index is typically highly efficient for both accuracy and speed.
* **Neighbor Partition Vector Index** – Oracle AI Vector Search also supports an Inverted File Flat (IVF) partition-based index with vectors clustered into table partitions based on similarity. This type of index typically provides an efficient scale-out index, with fast and seamless transactional support, and is an alternative to an HNSW index when there is not enough memory to fit the whole index in-memory.
* **Hybrid Vector Index** - There is also a Hybrid Vector Index that combines the information retrieval capabilities of Oracle Text search indexes and the semantic search capabilities of Oracle AI Vector Search vector indexes.

In this Lab we will use HNSW indexes to enable approximate similarity search since they provide the fastest performance and our dataset will easily fit in-memory.


### Objectives

In this lab, you will:

* View the Vector Pool
* Run the vector memory advisor to estimate the space required
* Create an HNSW vector index on the PARKS table vector column
* Show index memory usage and information
* Run approximate similarity searches
* Show an execution plan from a query
* Show differences between and exhaustive and approximate similarity searches

### Prerequisites

This lab assumes you have:
* An Oracle Account (oracle.com account)
* All previous labs successfully completed


## Task 1: View the Vector Pool

When HNSW indexes are used, you must enable a new memory area in the database called the Vector Pool. The Vector Pool is memory allocated from the System Global Area (SGA) to store HNSW type vector indexes and their associated metadata. It is allocated using a new database initialization parameter called VECTOR\_MEMORY\_SIZE.

1. Let's see how much memory has been allocated to the Vector Pool in our Lab environment:

    ```
    <copy>
    SELECT * FROM v$vector_memory_pool;
    </copy>
    ```

    ![directory query](images/vector_pool.png " ")

    You can see that there are two pools, the 1MB pool and the 64KB pool. Notice that no memory has been allocated to the vector memory pool. Since we are running in an Oracle Autonomous Database the vector memory pool will not be allocated until the first vector index is created.

## Task 2: Create a vector index

In this task we will create an HNSW vector index and see how much space is used in the Vector Pool.

1. Create a vector index for the DESC\_VECTOR column in the PARKS table:

    ```
    <copy>
    CREATE VECTOR INDEX parks_hnsw_idx ON parks (desc_vector)
    ORGANIZATION INMEMORY NEIGHBOR GRAPH
    DISTANCE COSINE WITH TARGET ACCURACY 95;
    </copy>
    ```

    ![index create](images/create_index.png " ")

    Notice that an HNSW index is created by specifying "inmemory neighbor graph". The minilm\_l12\_v2 embedding model we have been using works well with the "COSINE" distance method and we have also specified a "TARGET ACCURACY" of 95 percent.

2. Display information about the new vector index:

    ```
    <copy>
    SELECT owner, index_name, index_organization, num_vectors
    FROM v$vector_index
    WHERE index_name = 'PARKS_HNSW_IDX';
    </copy>
    ```

    ![index details query](images/index_details.png " ")

    The index details show us that we have indexed 472 vectors, which is the number of rows in the PARKS table.

3. See how much memory was used in the Vector Pool:

    ```
    <copy>
    SELECT * FROM v$vector_memory_pool;
    </copy>
    ```

    ![mem used query](images/vector_pool_used.png " ")

    Now you should see that memory has been allocated to each pool in the ALLOC\_BYTES column. You should also see how much memory has been used for the vector index we just created in the USED\_BYTES column.

## Task 3: Run approximate similarity searches

In this task we will run the same queries we ran in the the Exhaustive Search lab, but now we will run approximate similarity searches with the vector index that we just created.

1. Recall that the first query we ran in the Exhaustive Search lab looked for parks that were associated with the Civil War. Notice that we have changed the EXACT keyword on the fetch line to APPROX for approximate. If the EXACT keyword is NOT used, the optimizer will choose a vector index if one exists and if the access cost is less than an exhaustive search. Specifying APPROX can help ensure that you are actually running an approximate search. The APPROX keyword is optional but helps make the intent to run an approximate query more obvious. The EXACT keyword forces an exhaustive search.

    ```
    <copy>
    SELECT name, city, states, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 USING 'Civil War' AS data), COSINE)
    FETCH APPROX FIRST 10 ROWS ONLY;
    </copy>
    ```

    ![exact query1](images/parks_approx_civil_war.png " ")

2. Lets also re-run our "rock climbing" query and see if there are any differences running an approximate search:

    ```
    <copy>
    SELECT name, city, states, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' AS data), COSINE)
    FETCH APPROX FIRST 10 ROWS ONLY;
    </copy>
    ```

    ![exact query2](images/parks_approx_rock_climbing.png " ")

   Notice that the results are the same for both queries with potentially less work and faster execution. Since our dataset is so small you may not notice much difference. However, in practice with large datasets the difference can be very large.

3. Since we are now doing an approximate search using a vector index, what does the execution plan look like?

    ```
    <copy>
    SELECT name, city, states, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' AS data), COSINE)
    FETCH APPROX FIRST 10 ROWS ONLY;
    </copy>
    ```
  
    Click on the "Explain Plan" button and select the "Advanced View" button to display an image like the one below:

	![plan query](images/parks_approx_execute_plan.png " ")

    Notice that a vector index access is now performed on the PARKS table since we have a vector index available.


You may now **proceed to the next lab**


## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 26ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/26/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes, Product Manager, AI Vector Search
* **Contributors** - Sean Stacey, Product Manager, AI Vector Search
* **Last Updated By/Date** - Andy Rivenes, Product Manager, AI Vector Search, January 2026
