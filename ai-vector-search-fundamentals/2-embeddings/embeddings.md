# Vector Embeddings

## Introduction

This lab walks you through the steps to load a vector embedding model into the database and display it's characteristics.

Estimated Lab Time: 10 minutes

### About Vector Embedding

To enable similarity search, we will need to create vector embeddings for the column(s) we would like to search on, which, in this first lab will be the DESCRIPTION column in the PARKS table. Vector embeddings are stored in a column of data type VECTOR. A vector embedding is a mathematical vector representation of data points or, more simply, an array of numbers. This vector representation translates semantic similarity into proximity in a mathematical vector space. You will get to see what these numbers look like, but ultimately it is the comparison of distance between any two vectors that enables similarity search.

Vector embeddings are generated using Machine Learning models. How do you decide which embedding model to use? After all, there are open-source embedding models and proprietary embedding models that you might have to pay for, or you could create and train your own embedding models. To add to the confusion, each embedding model has been trained on specific data. The type of embedding model you use will depend on the type of data that you plan to embed and how well that model performs for the searches you or your application need to perform.

Once you decide on one or more embedding models to try, you can choose to create vector embeddings outside the database or inside the database by importing the models directly into Oracle Database if they are compatible with the Open Neural Network Exchange (ONNX) standard. Since Oracle Database implements an ONNX runtime directly within the database, these imported models can be used to generate vector embeddings in Oracle Database.

In this Lab we are going to be searching on a text column, and we will use the all-MiniLM-L12-v2 model. This model is part of the sentence-transformers library. This model takes sentences or paragraphs and converts them into 384-dimensional vectors. Each of these 384 dimensions captures a specific aspect of the sentence's meaning or characteristics. We will be using a pre-built version of this model, which just means that it has already been converted into an ONNX format and is ready to be loaded into the database. You can find the details about how this was done in this blog post: https://blogs.oracle.com/machinelearning/post/use-our-prebuilt-onnx-model-now-available-for-embedding-generation-in-oracle-database-23ai.


### Objectives

In this lab, you will:
* Load an embedding model
* Describe and display a vector
* Create a vector column and describe the attributes
* Create vector embeddings on the PARKS table DESCRIPTION column
* Run exact similarity searches
  * Show an execution plan from the query
  * Show vector distances to reinforce how the search is evaluated

### Prerequisites (Optional)

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Load an Embedding Model

This task will involved identifying and loading an ONNX model into the database. The pre-built all_MiniLM_L12_v2 will be used as described in the About section above.

1. Let's see if there are any Machine Learning models currently loaded:
   ```
   <copy>
   select MODEL_NAME, MINING_FUNCTION, ALGORITHM, ALGORITHM_TYPE, MODEL_SIZE 
   from user_mining_models;
   </copy>
   ```

	 ![Mining models query](images/embedding_models1.png)

2. Next we will load the all_MiniLM_L12_v2 embedding model into the database. The file is in the DM_DUMP directory. You can display this directory with the following SQL:

   ```
   <copy>
   select * from all_directories where directory_name = 'DM_DUMP';
   </copy>
   ```

   ![directory query](images/onnx_directory.png)

   The all_MiniLM_L12_v2.onnx file resides in this operating system directory.

3. Load the all_MiniLM_L12_v2 embedding model into the database:

   ```
   <copy>
   begin
      dbms_vector.load_onnx_model('DM_DUMP','all_MiniLM_L12_v2.onnx','minilm_l12_v2',
        JSON('{"function" : "embedding", "embeddingOutput" : "embedding", "input": {"input": ["DATA"]}}'));
   end;
   </copy>
   ```

   ![directory query](images/load_model.png)

   Using the DBMS_VECTOR.LOAD_ONNX_MODEL procedure the database read the all_MiniLM_L12_v2.onnx file in the DM_DUMP directory and loaded it into the database.

4. Display the newly loaded model:

   ```
   <copy>
   select MODEL_NAME, MINING_FUNCTION, ALGORITHM, ALGORITHM_TYPE, MODEL_SIZE 
   from user_mining_models;
   </copy>
   ```

   ![directory query](images/embedding_models2.png)

   You may notice that the 'MINING FUNCTION' column has the attribute of EMBEDDING since this particular machine learning model is an embedding model.
  
5. Display the model details:

   ```
   <copy>
   select model_name, attribute_name, attribute_type, data_type, vector_info 
   from user_mining_model_attributes;
   </copy>
   ```

   ![directory query](images/model_details.png)

   You may notice that the VECTOR_INFO column displays 'VECTOR(384,FLOAT32)' which matches our description in the About section where we stated that the all_MiniLM_L12_v2 model has 384-dimensional vectors and a dimension format of FLOAT32.


## Task 2: Describe and display a vector

Now that we have loaded an embedding model let's take a look at what a vector looks like.

1. In the SQL Developer Web window copy the following example of creating a vector embedding for the word 'hello'.

   ```
   <copy>
   SELECT VECTOR_EMBEDDING(minilm_l12_v2 USING 'hello' as data);
   </copy>
   ```

   See the image below:

   ![directory query](images/vector_example.png)

2. Now let's create an embedding for the DESCRIPTION column in the PARKS table. We will just create the embedding for one row in the table, but in the next section we will create vector embeddings for the entire table based on the DESCRIPTION column.

   ```
   <copy>
   SELECT SELECT description, VECTOR_EMBEDDING(minilm_l12_v2 USING description as data)
   from parks fetch first 1 rows only;
   </copy>
   ```

   See the image below:

   ![directory query](images/parks_row_vector.png)

   The description column has been added so you can see the full text that was used for the vector embedding. Below is a text version so hopefully you can appreciate the size of the full vector.

   ![directory query](images/parks_row_vector_text.png)


## Task 3: Create a vector column and describe the attributes

Now we are ready to take a look at the PARKS table. We will be using the DESCRIPTION column which is a text string describing the particular park's attributes. We will create a vector embedding for this column.

1. In the SQL Developer Web window you can you can expand the PARKS table by clicking on the arrow just to the left of the PARKS table. The table's columns will display underneath. You can display all of the table attributes by right clicking on the table name and choosing Open.

   See the image below:

   ![directory query](images/parks_columns1.png)

2. Next will add a new column to the table of type VECTOR. We will call the column DESC_VECTOR.

   ```
   <copy>
   alter table PARKS add (desc_vector vector);
   </copy>
   ```

   ![directory query](images/parks_add_column.png)

3. Refresh the screen to see the newly added column:

   ![directory query](images/parks_refresh.png)

4. Now let's describe the column and take a look at the VECTOR column definitions:

   ```
   <copy>
   desc PARKS
   </copy>
   ```

	 ![directory query](images/parks_describe.png)

   Notice that the column definition is VECTOR(\*,\*,DENSE). Since we didn't specify any dimension or format it has been set to a '*'. This means that we could change the vector dimension and/or format and not have to redefine the column. This can be less disruptive than having to change the column definition.

## Task 4: Create vector embeddings

In this next task we will create vector embeddings on the DESCRIPTION column for all of the rows in the PARKS table.

1. Create vector embeddings:

   ```
   <copy>
   update parks
   set desc_vector = vector_embedding(minilm_l12_v2 using DESCRIPTION as data);
   </copy>
   ```

	 ![directory query](images/parks_embedding.png)

   There are other methods of creating vector embeddings, but for the small number of rows in our PARKS table this was probably the simplest method and only took a short amount of time.


2. Verify that embeddings were created:

   Since the vectors are quite large we will just display a small number of rows to verify our work:

   ```
   <copy>
   SELECT description, VECTOR_EMBEDDING(minilm_l12_v2 USING description as data)
   from parks fetch first 15 rows only;
   </copy>
   ```

	 ![directory query](images/parks_embeddings_query.png)



## Task 5: Run exact similarity searches

In this task we will put our work to use and run some exact similarity searches on the DESCRIPTION vector embeddings that we just created.

1. Our first query will look for parks that are associated with the Civil War:

    ```
    <copy>
    select name, city, states, description from parks
    order by vector_distance(desc_vector, VECTOR_EMBEDDING(minilm_l12_v2 USING 'Civil War' as data), COSINE)
    fetch exact first 10 rows only;
    </copy>
    ```

    ![directory query](images/parks_exact_civil_war.png)

    If you know anything about the Civil War you will notice that those are some pretty famous locations. However you might also notice that the words "Civil War" show up in almost all of the descriptions. You might ask, couldn't I have just searched on the term civil war? And that probably would have worked so lets try something a little harder in our next query.

2. For our second query we will try a query with a term that doesn't show up in the description:

    ```
    <copy>
    select name, city, states, description from parks 
    order by vector_distance(desc_vector, VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' as data), COSINE)
    fetch exact first 10 rows only);
    </copy>
    ```

    ![directory query](images/parks_exact_rock_climbing.png)

    The results are even more surprising since only two description have words that are close to "rock climbing". One has "rock climbers" in it, and one mentions "crack climbing", but otherwise no mention of actual rock climbing for parks that appear to be good candidate for rock climbing. We will see later in the Lab how close we actually came.

3. We mentioned in the introduction that vectors are used to search for semantically similar objects based on their proximity to each other In other words, the embedding process enables the use of specialized algorithms to search for the closest matches to the vector embedding being compared based on the distance between the search vector and the target vectors. Lets add the distance calculation to our query to see how this actually works.

    ```
    <copy>
    select name, 
      to_number(vector_distance(desc_vector, VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' as data), COSINE)),
      description
    from parks
    order by 2
    fetch exact first 10 rows only;
    </copy>
    ```

	 ![directory query](images/parks_exact_rock_climbing_distance.png)

    Notice that the distance number, the TO_NUMBER(VECTOR... column, is increasing. This means that the best match is first with the smallest distance and as the distance increases the matches have less and less similarity to the search vector.

4. One last step. Since we are doing exact queries, that is we have not created any vector indexes, what does an execution plan look like?

    ```
    <copy>
    select name, description from parks 
    order by vector_distance(desc_vector, VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' as data), COSINE)
    fetch exact first 10 rows only);
    </copy>
    ```
  
    Click on the "Explain Plan" button to display an image like the one below:

	 ![directory query](images/parks_execute_plan.png)

    Notice that a TABLE ACCESS FULL is performed on the PARKS table since we have not defined any indexes. In the next Lab we will take a look at how to create a vector index and perform approximate similarity searches.


## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 23ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes and Sean Stacey, Product Managers
* **Contributors** - Markus Kissling, Product Manager
* **Last Updated By/Date** - Andy Rivenes, March 2025
