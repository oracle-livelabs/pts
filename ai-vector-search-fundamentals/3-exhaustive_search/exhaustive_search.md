# Exhaustive Similarity Search

## Introduction

This lab walks you through the steps to run exhaustive similarity searches and what is happening during the search.

Estimated Lab Time: 10 minutes

### About Exhaustive Similarity Search

An exhaustive similarity search looks at the distances, based on a given query vector, to all other vectors in a data set. This type of search produces the most accurate results as all vectors are compared.

In this Lab we are going to be performing exhaustive similarity searches on a text column, and we will use the all-MiniLM-L12-v2 model. This is the same model we used in the Embedding Models lab to create the vector embeddings for the DESCRIPTION column in the PARKS table.


### Objectives

In this lab, you will:

* Run exhaustive similarity searches
* Show vector distances to reinforce how the search is evaluated
* Show an execution plan from a query

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Connecting to your Vector Database

The lab environment includes a preinstalled Oracle 23ai Database which includes AI Vector Search. We will be running the lab exercises from a pluggable database called: *orclpdb1* and connecting to the database as the user: *nationalparks*. The Lab will be run using SQL Developer Web.

To connect with SQL Developer Web to run the SQL commands in this lab you will first need to start a browser using the following URL. You will then be prompted to sign in:

  ```
  <copy>google-chrome http://localhost:8080/ords/nationalparks/_sdw/?nav=worksheet</copy>
  ```

After signing in you should see a browser window like the following:

 ![sqldev browser](images/sqldev_web.png " ")


## Task 1: Run exhaustive similarity searches

In this task we will put our work to use and run some exhaustive similarity searches on the DESCRIPTION vector embeddings that we just created in the PARKS table.

1. Our first query will look for parks that are associated with the Civil War:

    ```
    <copy>
    SELECT name, city, states, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 USING 'Civil War' AS data), COSINE)
    FETCH EXACT FIRST 10 ROWS ONLY;
    </copy>
    ```

    ![exhaustive query1](images/parks_exhaustive_civil_war.png " ")

    If you know anything about the Civil War you will notice that those are some pretty famous locations. However you might also notice that the words "Civil War" show up in almost all of the descriptions. You might ask, couldn't I have just searched on the term civil war? And that probably would have worked so let's try something a little harder in our next query.

2. For our second query we will try a query with a term, "rock climbing", that doesn't show up in the description:

    ```
    <copy>
    SELECT name, city, states, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 using 'rock climbing' AS data), COSINE)
    FETCH EXACT FIRST 10 ROWS ONLY;
    </copy>
    ```

    ![exhaustive query2](images/parks_exhaustive_rock_climbing.png " ")

    The results are even more surprising since only two descriptions have words that are close to "rock climbing". One has "rock climbers" in it, and one mentions "crack climbing", but otherwise no mention of actual rock climbing for parks that appear to be good candidates for rock climbing. We will see later in the Lab how close we actually came.

3. We mentioned in the introduction that vectors are used to search for semantically similar objects based on their proximity to each other. In other words, the embedding process enables the use of specialized algorithms to search for the closest matches to the vector embedding being compared based on the distance between the search vector and the target vectors. Lets add the distance calculation to our query to see how this actually works.

    ```
    <copy>
    SELECT name,
      to_number(VECTOR_DISTANCE(desc_vector,
        VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' AS data), COSINE)) AS distance,
      description
    FROM parks
    ORDER BY 2
    FETCH EXACT FIRST 10 ROWS ONLY;
    </copy>
    ```

	 ![distance query](images/parks_exhaustive_rock_climbing_distance.png " ")

    Notice that the distance number, the DISTANCE column, is increasing. This means that the best match is first with the smallest distance and as the distance increases the matches have less and less similarity to the search vector.

4. One last step. Since we are doing exhaustive queries, that is we have not created any vector indexes, what does an execution plan look like?

    ```
    <copy>
    SELECT name, description
    FROM parks
    ORDER BY VECTOR_DISTANCE(desc_vector,
      VECTOR_EMBEDDING(minilm_l12_v2 USING 'rock climbing' AS data), COSINE)
    FETCH EXACT FIRST 10 ROWS ONLY;
    </copy>
    ```
  
    Click on the "Explain Plan" button and choose the "Advanced View" button to display an image like the one below:

	 ![plan query](images/parks_execute_plan.png " ")

    Notice that a TABLE ACCESS is performed on the PARKS table since we have not defined any indexes. In the next Lab we will take a look at how to create a vector index and perform approximate similarity searches.


You may now **proceed to the next lab**


## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 23ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes, Product Manager
* **Contributors** - Sean Stacey, Markus Kissling, Product Managers
* **Last Updated By/Date** - Andy Rivenes, April 2025
