

<if type="Cohere">

# Using Cohere Vector Embedding Models
## Introduction

In this lab we will learn how to use the OCI generative ai Cohere embedding models with Oracle Vectors.

------------
Estimated Time: 25 minutes

### Objectives


In this lab, you will see the following Vector operations using nodejs:
* Task 1: Vectorizing a table with Cohere embedding
* Task 2: Perform Similarity Search using Cohere
* Task 3: Changing embedding models

## Task 1: Vectorizing a table with Cohere embedding

  1. The first step is to vectorize the contents of our table using an embedding model by Cohere. To do this, you will need to create a nodejs program to vectorize our phrases using the Cohere embedding model libraries that we just installed.

   The file *vectorizeTableCohere.js* is already on your machine. Below is the contents of the file.

    ```
      <copy>
      /* Copyright (c) 2024, Oracle and/or its affiliates. */

      /******************************************************************************
      *
      * This software is dual-licensed to you under the Universal Permissive License
      * (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
      * 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
      * either license.
      *
      * If you elect to accept the software under the Apache License, Version 2.0,
      * the following applies:
      *
      * Licensed under the Apache License, Version 2.0 (the "License");
      * you may not use this file except in compliance with the License.
      * You may obtain a copy of the License at
      *
      *    https://www.apache.org/licenses/LICENSE-2.0
      *
      * Unless required by applicable law or agreed to in writing, software
      * distributed under the License is distributed on an "AS IS" BASIS,
      * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      * See the License for the specific language governing permissions and
      * limitations under the License.
      *
      * NAME
      *   vectorizeTableCohere.js
      *
      * DESCRIPTION
      *   Add or update the vectors for all data values in a table using embedding
      *   models in Cohere
      *   http://www.cohere.com
      * If you are using a FREE Cohere API Key you will need to add a time delay.
      * Change the setting below to "1" if your key is a free key./

      /*****************************************************************************/
      
      const oracledb = require("oracledb");
      const sdk = require("oci-sdk");
      const common = require("oci-common");
      const configProfile = "DEFAULT"
      const endpoint = "https://inference.generativeai.us-chicago-1.oci.oraclecloud.com"
      const configurationFilePath = "/home/oracle/.oci/config";
      const provider = new common.ConfigFileAuthenticationDetailsProvider(configurationFilePath, configProfile);
      const compartment_id = "ocid1.compartment.oc1..aaaaaaaa4n4pyye4r7xosnqbsmgfgiieyief3q6q2vmtxwztbunqzt7u3cva"
      // Check and connect through proxy, if set
      if (process.env.GLOBAL_AGENT_HTTP_PROXY) {
        const {
          bootstrap
        } = require('global-agent');
        bootstrap();
      }

      async function vectorize() {
        let connection;
        const dbConfig = {
          user: process.env.NODE_ORACLEDB_USER,
          password: process.env.NODE_ORACLEDB_PASSWORD,
          connectString: process.env.NODE_ORACLEDB_CONNECTIONSTRING,
        };
        // oracledb.initOracleClient();

        /** Select/Set your Embedding model here */
        const embeddingModel = 'cohere.embed-english-light-v3.0';
        // const embeddingModel = 'cohere.embed-english-v3.0';
        // const embeddingModel = 'cohere.embed-multilingual-light-v3.0';
        // const embeddingModel = 'cohere.embed-multilingual-v3.0';

        console.log('Using embedding model ' + embeddingModel);


        try {

          const client = new sdk.generativeaiinference.GenerativeAiInferenceClient({
            authenticationDetailsProvider: provider
          });

          // Get a standalone Oracle Database connection
          connection = await oracledb.getConnection(dbConfig);

          //Check if we are connected to Oracle Database 23.4 that supports vectors
          if (connection.oracleServerVersion < 2304000000) {
            console.log('This example requires Oracle Database 23.4 or later');
            process.exit();
          }
          console.log('Connected to Oracle Database');

          console.log('Vectorizing the following data:');

          // Loop over the rows and vectorize the VARCHAR2 data
          const sql = 'SELECT id, info FROM my_data  ORDER BY 1';
          const result = await connection.execute(sql);

          const binds = [];

          const tic = performance.now();
          for (const row of result.rows) {
            // Convert to format that Cohere wants
            const data = [row[1]];
            console.log(row);

            // Create the vector embedding [a JSON object]
            const embedTextDetails = ({
              inputs: data,
              servingMode: {
                servingType: "ON_DEMAND",
                modelId: embeddingModel
              },
              compartmentId: compartment_id
            });

            const embedTextRequest = sdk.generativeaiinference.EmbedTextRequest = {
              embedTextDetails: embedTextDetails
            };

            const embedTextResponse = await client.embedText(embedTextRequest);
            // Extract the vector from the JSON object and convert to Typed Array
            const float32VecArray = new Float32Array(embedTextResponse.embedTextResult.embeddings[0]);
            // Record the array and key
            binds.push([float32VecArray, row[0]]);
              function wait() {}
              setTimeout(wait, .485);
          }

          // Do an update to add or replace the vector values
          await connection.executeMany('UPDATE my_data SET v = :1 WHERE id = :2', binds, {
            autoCommit: true
          });
          const toc = performance.now();

          console.log(`Vectors took ${((toc - tic) / 1000).toFixed(4)} seconds`);
          console.log(`Added ${binds.length} vectors to the table`);
        } catch (err) {
          console.error(err);
        } finally {
          if (connection)
            await connection.close();
        }
      }

      vectorize();
      </copy>
    ```

2. now you are ready to run the *vectorizeTableCohere.js* nodejs program. This can be done by performing the following:  

    ```
      <copy>
      node vectorizeTableCohere.js
      </copy>
    ```

    When the program finishes running, you should see something similar to the following:

    ![Lab 1 Task 2 Step 3](images/nodejscohere03.png=60%x*)

  To summarize what we've just done, the *vectorizeTableCohere.js* program connects to the Oracle database, retrieves the text from the INFO column of the MY\_DATA table, and vectorizes the "factoid" for each of the 150 rows. We are then storing the vectorized data as a vector in the column called: V. You will also notice that we used the *embed-english-light-v3.0* embedding model for this operation. In other words an English speaking embedding model, and it's version 3.0 of the light model.
  
  3. Before we move onto performing Similarity Searches using OCI generative ai Cohere embedding models, we should take a look in the the Oracle database to see the updates made to the *MY\_DATA* table.
  
      3.a. Connect to your Oracle database as the user: **vector** with password: **vector**

      ```
        <copy>
        sqlplus vector/vector@localhost/freepdb1
        </copy>
      ```

    3.b. We can now query the *MY\_DATA* table to verify that all 150 rows have been updated.

    ```
      <copy>
      select count(*) from MY_DATA where V is not null;
      </copy>
    ```


    You should see:

    ![Lab 1 Task 2 Step 4](images/nodejscohere04.png=60%x*)


    3.c. We can also query the vector column: V in the MY\_DATA table to see what the vectors and dimensions look like.

    ```
      <copy>
      select V from MY_DATA;
      </copy>
    ```

    You should see something similar to this-

    ![Lab 1 Task 2 Step 6a](images/nodejscohere05.png=60%x*)


    This is the semantic representation of the data stored in the corresponding row of the INFO column.

    Now that we have vectorized the data in our table and confirmed the updates, we are ready to move onto the next task which is performing Similarity Searches using our Vectors.


## Task 2: Perform Similarity Search using Cohere

1. In this lab we will see how to perform a similarity search with the OCI Cohere embedding models in nodejs.

  So far we have vectorized the data in the *MY\_DATA* table using the OCI generative ai Cohere embedding model, we can now start performing Similarity Searches using the Vectors in our table. Even though the data in our table has been vectorized we will still need to connect to OCI generative ai to vectorize our search phrase with the same embedding model. The search phrase is entered on the fly, vectorized and then used to search against the vectors   in the database. We will create a nodejs program to do this.


   The file *similaritysearchCohere.js* is already on your machine. Below is the contents of the file.

    ```
      <copy>
      /* Copyright (c) 2024, Oracle and/or its affiliates. */
      /******************************************************************************
       *
       * This software is dual-licensed to you under the Universal Permissive License
       * (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
       * 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
       * either license.
       *
       * If you elect to accept the software under the Apache License, Version 2.0,
       * the following applies:
       *
       * Licensed under the Apache License, Version 2.0 (the "License");
       * you may not use this file except in compliance with the License.
       * You may obtain a copy of the License at
       *
       *    https://www.apache.org/licenses/LICENSE-2.0
       *
       * Unless required by applicable law or agreed to in writing, software
       * distributed under the License is distributed on an "AS IS" BASIS,
       * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       * See the License for the specific language governing permissions and
       * limitations under the License.
       *
       * NAME
       *   similaritySearchCohere.js
       *
       * DESCRIPTION
       *   Basic Similarity Search using the Cohere embedding models
       *   http://www.cohere.com
       *
       *****************************************************************************/

      const oracledb = require("oracledb");
      const readline = require("readline");
      const sdk = require("oci-sdk");
      const common = require("oci-common");
      const configProfile = "DEFAULT"
      const endpoint = "https://inference.generativeai.us-chicago-1.oci.oraclecloud.com"
      const configurationFilePath = "/home/oracle/.oci/config";
      const provider = new common.ConfigFileAuthenticationDetailsProvider(configurationFilePath, configProfile);
      const compartment_id = "ocid1.compartment.oc1..aaaaaaaa4n4pyye4r7xosnqbsmgfgiieyief3q6q2vmtxwztbunqzt7u3cva"

      // Check and connect through proxy, if set
      if (process.env.GLOBAL_AGENT_HTTP_PROXY) {
        const {
          bootstrap
        } = require('global-agent');
        bootstrap();
      }

      const readLineAsync = () => {
        const rl = readline.createInterface({
          input: process.stdin
        });

        return new Promise((resolve) => {
          rl.prompt();
          rl.on('line', (line) => {
            rl.close();
            resolve(line);
          });
        });
      };

      async function runSimilaritySearch() {
        let connection;
        const dbConfig = {
          user: process.env.NODE_ORACLEDB_USER,
          password: process.env.NODE_ORACLEDB_PASSWORD,
          connectString: process.env.NODE_ORACLEDB_CONNECTIONSTRING
        };

        const client = new sdk.generativeaiinference.GenerativeAiInferenceClient({
          authenticationDetailsProvider: provider
        });


        const topK = 5;
        let reRank = false;


        console.log("The LLM model is cohere.command from OCI GenAI Service");

        /** Select/Set your Embedding model here */
        const embeddingModel = 'cohere.embed-english-light-v3.0';
        //  const embeddingModel =   "cohere.embed-english-v3.0";
        //  const embeddingModel = 'cohere.embed-multilingual-light-v3.0';
        //  const embeddingModel = 'cohere.embed-multilingual-v3.0';

        /** Cohere re-ranking models */
        //  const rerankModel = 'rerank-english-v2.0';
        //  const rerankModel = 'rerank-multilingual-v2.0';

        console.log('Using embedding model ' + embeddingModel);

        if (reRank)
          console.log('Using reranker ' + rerankModel);
        else
          console.log('Not using reranking');

        console.log('TopK = ' + topK);


        try {
          // oracledb.initOracleClient(); // Run in Thick mode

          // Get a standalone Oracle Database connection
          connection = await oracledb.getConnection(dbConfig);

          //Check if we are connected to Oracle Database 23.4 that supports vectors
          if (connection.oracleServerVersion < 2304000000) {
            console.log('This example requires Oracle Database 23.4 or later');
            process.exit();
          }
          console.log('Connected to Oracle Database');

          // The embed-english-light-v3.0 model works best with the DOT product
          // distance function
          const sql = `select info from my_data
                        order by vector_distance(v, :1, EUCLIDEAN)
                        fetch first :2 rows only`;

          while (true) {
            // Get the text input to vectorize
            console.log("\nEnter a phrase. Type 'quit' or 'exit' to exit : ");
            const text = await readLineAsync();

            if (text === 'quit' || text === 'exit')
              break;

            if (text === '')
              continue;

            let tic, toc;
            // Create the vector embedding [a JSON object]
            const sentence = text;

            tic = performance.now();


            // Create the vector embedding [a JSON object]
            const embedTextDetails = ({
              inputs: [sentence],
              servingMode: {
                servingType: "ON_DEMAND",
                modelId: embeddingModel
              },
              compartmentId: compartment_id
            });

            const embedTextRequest = sdk.generativeaiinference.EmbedTextRequest = {
              embedTextDetails: embedTextDetails
            };

            const embedTextResponse = await client.embedText(embedTextRequest);
            // Extract the vector from the JSON object and convert to Typed Array
            toc = performance.now();

            console.log(`\nVectorize query took ${((toc - tic) / 1000).toFixed(3)} seconds`);

            // Extract the vector from the JSON object
            const float32VecArray = new Float32Array(embedTextResponse.embedTextResult.embeddings[0]);
            // Do the Similarity Search
            tic = performance.now();
            const rows = (await connection.execute(sql, [float32VecArray, topK])).rows;
            toc = performance.now();
            const docs = [];


            for (const row of rows) {
              docs.push(row[0]);
            }
            console.log(`\nSimilarity Search took ${((toc - tic) / 1000).toFixed(3)} seconds`);

            if (!reRank) {
              // Just rely on the vector distance for the resultset order
              console.log('\nWithout ReRanking');
              console.log('=================');

              for (const hit of docs) {
                console.log(hit);
              }
            } else {
              tic = performance.now();

              // Rerank for better results
              toc = performance.now();

              console.log(`Rerank took ${((toc - tic) / 1000).toFixed(3)} seconds`);
              console.log('\nReranked results');
              console.log('=================');

              for (const hit of results) {
                console.log(docs[hit.index]);
              }
            }
          } // End of while loop
        } catch (err) {
          console.error(err);
        } finally {
          if (connection)
            await connection.close();
        }
      }

      runSimilaritySearch();
      </copy>
    ```


2. Save the file and run it with *Nodejs18* as follows:

    ```
      <copy>
      node similaritySearchCohere.js
      </copy>
    ```

    You should see the following:

    ![Lab 1 Task 3 Step 2](images/nodejscohere06.png=60%x*)

    The first thing you should notice is that the embedding model: "embed-english-light-v3.0" being used in the similarity search matches the embedding model that we used to Vectorize the data in the MY\_DATA table. You will also notice:

    - We are using the reranker with rerank-english-v2.0
    - We are only looking at the TopK 5 - or closest 5 results
    - We are connecting to the OCI generative ai services to use the Cohere embedding models 
    - We and connecting to the Oracle database with the oracledb nodejs library


3. For our first example we will enter the word "cars" at the prompt.  

    You should see something similar to:

    ![Lab 1 Task 3 Step 3](images/nodejscohere07.png=60%x*)

    It's possible that your times will be different to ours, as the time includes the network roundtrip REST call. With that being the case, we can see that the first operation is to vectorize our phrase, in this case "cars", and that it took 0.194 seconds.

    - Next we can see that the similarity search took 0.002 seconds (or 2 milliseconds) to locate 5 related entries to the word "cars".

    - The 5 rows returned are the 5 *most semantically* similar to our phrase *cars* from our sample data in the MY\_DATA table.

    - The results themselves look like a "good" result as all 5 of the factoids are on-point with the phrase "cars".  


4. Next we can type in the word "cats"

    You should see something similar to:

    ![Lab 1 Task 3 Step 4](images/nodejscohere07a.png=60%x*)

    This time, the output does not appear to have the same level of accuracy as "cats and mice" are often used in the same context, there is some correlation between the two animals. But finding a similarity between cats and oranges could be considered a stretch.

    The whole point about Similarity Search is that it is not necessarily exactly correct, it is the best match given the available data using the given embedding model. The embedding model is trained using information available from the internet and other publicly sourced information.

    Perhaps the term "orange" is associated with the colour of cats? But it would be pure speculation to jump to a conclusion on what drove the embedding model to make this correlation.  

5. We can also try other search phrases for example "fruit", or even "NY".

    You should see something similar to:

    ![Lab 1 Task 3 Step 5](images/nodejscohere08.png=60%x*)

    In both cases the query phrases we enter are not actually in the data set themselves, but the connection or correlation is apparent. It is important to understand that the search is not an exact or substring search for what is in the result set. Instead the results are looking for similar data based on the text being vectorized.
    **or**
    Both of these results were on target and illustrate the power of similarity search. The queries are very different to a traditional relational query where we are looking for an exact match, but in both of these instances neither of the terms "fruit" or "NY" were in our table. Similarity search is able to find a correlation.


6. Next we can search for "Boroughs".

   You should see something similar to:

   ![Lab 1 Task 3 Step 6](images/nodejscohere09.png=60%x*)

    This phrase directs our similarity search to information related to New York City - and you should notice that we do not see "Buffalo" this time. But you may also notice that we see four of the five boroughs: "Bronx" , "Brooklyn", "Manhattan" and "Queens". But we see "Harlem" and not "Staten Island". Harlem is a neighborhood in New York City and not a borough.

    **NOTE: We do have an entry for "Staten Island" in our MY\_DATA table, but once again we can see Similarity Search does not guarantee an exact answer.**


7. For another experiment, we can enter the word "Bombay". should see something similar to this"

   You should see something similar to:

   ![Lab 1 Task 3 Step 7](images/nodejscohere10.pngs.png=60%x*)


    The word "Bombay" does not appear in our data set, but the results related to Mumbai are correct because "Bombay" is the former name for "Mumbai", and as such there is a strong correlation between the two names for the same geographic location.

    Remember, similarity search works on the basis of the trained data from which the embedding models use. Trained embedding models use text sourced from the internet and it is very likely that there is information that includes both the names "Bombay" and "Mumbai" in relation to the same place.

8. Now to see what happens when there is no correlation in the terms, let's try something completely random.

    Enter the phrase "random stuff" - you should see:

   ![Lab 1 Task 3 Step 7](images/nodejscohere11.png.png=60%x*)

    The first thing you may notice is that this takes slightly longer, but just as you may have anticipated, there is little or no correlation between the terms returned and the phrase we entered. This is also likely influenced by the small data-set or number of rows in the MY\_DATA table.

    This also introduces another topic. What about changing the Embedding Model?  We'll take a look at that next...  


## Task 3: Changing embedding models

   1. So far, for the sake of simplicity and speed, we have been using the "embed-english-light-v3.0" or English Light v3.0 embedding model from Cohere. In the next step we will switch the embedding model to see how it impacts our similarity search results.

   We will continue to use Cohere, so the modifications required are minor.

   In order to do this we will need to edit the nodejs program: *similaritysearchCohere.js*.

    Before we get started with making our changes, we should take a few moments to understand what the program is doing.

    We are passing the Oracle database Username and Password along with the database connect-string. We then set the number of rows to return (topK) along with whether or not to use  Re-ranking.

   ![Lab 1 Task 4 Step 1b](images/nodejscohere13.png=60%x*)

    The SQL statement returns the text from the INFO column in the MY\_DATA table.

   ![Lab 1 Task 4 Step 1c](images/nodejscohere13a.png=60%x*)

    The SQL statement calls the vector_distance function to perform a similarity comparison of the vectorized value for the input string (:1) with the vector that we stored in column V. This example performs a COSINE Similarity Search. We are only returning the first 5 rows (:2) which can be controlled using the TopK parameter. The key word APPROX informs the Oracle optimizer to use a Vector Index if it is deemed to be beneficial.  

    Below the SQL block we can see the parameter for setting the embedding model to be used by the program:

   ![Lab 1 Task 4 Step 1d](images/nodejscohere14.png=60%x*)

    This is where we can choose the embedding model. As mentioned earlier, we have been using the *embed-english-light-v3.0* - both to vectorize our data when we populated the MY\_DATA table, as well as when we performed our similarity searches.

    **We can switch to the "non-light" version by commenting out the line where we with *"embed-english-light-v3.0"* and uncommenting the line for "embed-english-v3.0".**

    Your modified program should look like this:

   ![Lab 1 Task 4 Step 1e](images/nodejscohere16.png.png=60%x*)

2. So now we're ready to rerun our program:

    ```
      <copy>
      node similaritySearchCohere.js
      </copy>
    ```

    When prompted for a query string, enter the term "cats".

    However, this time, when we run the program we see the following error displayed:

   ![Lab 1 Task 4 Step 2](images/nodejscohere18.png=60%x*)


    This is because, as we mentioned earlier, you cannot perform similarity search operations using different embedding models. In other words, in order for us to use the *embedding-english-v3.0* model, we will need to go back and re-vectorize the data in the MY\_DATA table so that it too uses the same embedding model.

    In order to make this change we will need to revisit the *vectorizeTableCohere.js* program and make the same code change to comment out the line for assigning the *"embed-english-light-v3.0"* and uncommenting the line for *"embed-english-v3.0"*.

    The program should look like this:

   ![Lab 1 Task 4 Step 2](images/nodejscohere16.png=60%x*)

3. We will also need to rerun the Vectorize program to change the embedding model for our terms-  


    ```
      <copy>
      node vectorizeTableCohere.js
      </copy>
    ```

    This time the vectorize operation will take slightly longer to run as the new model is more complex. For comparison embed-english-light-v3.0 has 384 dimensions and embed-english-v3.0 has 1024 dimensions.

    Your should see the following:

   ![Lab 1 Task 4 Step 3](images/nodejscohere19.png=60%x*)


4. We're now ready to reun the Similarity Search program once again-

    ```
      <copy>
      node similaritySearchCohere.js
      </copy>
    ```

    When prompted to enter a phrase to query - enter "cats"

    You should see something similar to the following:

   ![Lab 1 Task 4 Step 4](images/nodejscohere20.png=60%x*)

   This time your output will be different. The first result returned is "Cats do not care." which is more accurate than when we previously ran this query (you may recall the first entry was "Oranges are orange" when we used the *embed-english-light-v3.0* model). The last entry in the results "Wolves are hairy." is still not quite accurate but one could argue that there is a better correlation as they are both animals.   

5. Also when we re-run the query for "Borough" we see "Staten Island" this time, but we don't see "Queens" so we get a different set of results,  but it's still not exactly right...

   ![Lab 1 Task 4 Step 5](images/nodejscohere21.png=60%x*)


   Feel free to try some other queries including repeating some of the previous examples we entered with the light embedding model for your own comparison.

## Appendix: Installing OCI generative ai packages on your own machine

1. To install the oci generative ai packages from oracle with *npm* (package installer for node). While logged in as the oracle Linux user, run the following *npm* command:

    ```
      <copy>
      npm install oci-common
      npm install oci-sdk
      </copy>
    ```


## Summary

In this lab you have seen how easy it is to use Cohere with Nodejs and Oracle Vectors and Similarity Search.
</if>


<if type="SentenceTransformers">

# Using Sentence Transformers and Nodejs with Oracle AI Vector Search

## Introduction

In this lab we will be using open source embedding models from Hugging Face so they're free to use. In addition to being free to use, these models can be installed locally, so they can be accessed by making a function call to a library, rather than a RESTful call over the internet.

So they're free, local and fast ...plus there are over 500 sentence transformer models to choose from.

*SentenceTransformers* is an open source Nodejs framework for modern sentence, text and image embeddings. Sentence Transformers make creating embeddings for text or images simple. Simple text based sentence transformers tend to have the same template where the only variable is the embedding model.


See [https://www.sbert.net/](https://www.sbert.net/) and [https://arxiv.org/abs/1908.10084](https://arxiv.org/abs/1908.10084) for more details about Sentence Transformers.


------------
Estimated Time: 20 minutes

### Objectives

In this lab, you will perform the following tasks:
* Task 1: Vectorizing a table with Sentence Transformers embedding
* Task 2: Understanding the Vector Embedding processing
* Task 3: Perform Similarity Search with Sentence Transformers
* Task 4: Changing embedding models



## Task 1: Vectorizing a table with Sentence Transformers embedding

  1. We're now ready to vectorize our data using the hugging face sentence transformers. To do this you will need to create a nodejs program to vectorize our phrases using the Sentence Transformers embedding model packages. 

  **NOTE:** We have already installed the sentence transformers available from hugging face locally on your system. 

  The file *vectorizeTableHFTransformers.js*  is already on your machine. Below is the contents of the file.
  

    ```
      <copy>
      /* Copyright (c) 2024, Oracle and/or its affiliates. */
      /******************************************************************************
      *
      * This software is dual-licensed to you under the Universal Permissive License
      * (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
      * 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
      * either license.
      *
      * If you elect to accept the software under the Apache License, Version 2.0,
      * the following applies:
      *
      * Licensed under the Apache License, Version 2.0 (the "License");
      * you may not use this file except in compliance with the License.
      * You may obtain a copy of the License at
      *
      *    https://www.apache.org/licenses/LICENSE-2.0
      *
      * Unless required by applicable law or agreed to in writing, software
      * distributed under the License is distributed on an "AS IS" BASIS,
      * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      * See the License for the specific language governing permissions and
      * limitations under the License.
      *
      * NAME
      *   vectorizeTableHFTransformers.js
      *
      * DESCRIPTION
      *   Add or update the vectors for all data values in a table using Hugging
      *   Face Transformers
      *   https://huggingface.co/docs/transformers.js/index
      *   Requires Node.js 18 and above
      *
      *****************************************************************************/

      const oracledb = require('oracledb');
      const fs = require('fs');

      // Hugging Face is supported only from Node.js 18 and above
      const MAJOR_NODEJS_VERSION = parseInt(process.version.slice(1).split('.')[0], 10);
      if (MAJOR_NODEJS_VERSION < 18) {
        console.log('Hugging Face transformers require Node.js version 18 or higher. Please upgrade your Node.js version.');
        process.exit();
      }

      async function vectorize() {
        let connection;
        const dbConfig = {
          user          : process.env.NODE_ORACLEDB_USER,
          password      : process.env.NODE_ORACLEDB_PASSWORD,
          connectString : process.env.NODE_ORACLEDB_CONNECTIONSTRING
        };

        // oracledb.initOracleClient(); // enable Thick mode

        /** Select/Set your Embedding model here */
        // const embeddingModel = 'Xenova/multilingual-e5-large';
        const embeddingModel = 'Xenova/all-MiniLM-L6-v2';

        // Re-ranking models
        const reRankModel = 'Xenova/bge-reranker-base';
        // const embeddingModel = 'Xenova/text-embedding-ada-002';

        console.log('Using embedding model ' + embeddingModel);

        // Call the import function for the transformers module
        const { pipeline, env } = await import('@xenova/transformers');

           const PROXYURL = process.env.GLOBAL_AGENT_HTTP_PROXY;
        // Check and connect through proxy, if required.
        // As 'Xenova/transformers' uses native fetch for downloading the models
        // from the remote URL, The global dispatcher must be updated if we are
        // connecting through a firewall or a corporate proxy to download the models.
        // Once and if the model is cached locally, there is no need to connect to
        // the remote URL again.

        let modelCacheDir;
        if (process.platform === 'win32')
          modelCacheDir = `${env.cacheDir}\\${embeddingModel.replace('/', '\\')}`;
        else
          modelCacheDir = `${env.cacheDir}/${embeddingModel}`;

        if (PROXYURL && !fs.existsSync(modelCacheDir)) {
          const { bootstrap } = require('global-agent');
          const { setGlobalDispatcher, ProxyAgent } = require('undici');
          bootstrap();
          const dispatcher = new ProxyAgent({ uri: new URL(PROXYURL).toString() });
          setGlobalDispatcher(dispatcher);
        }

        const extractor = await pipeline('feature-extraction', embeddingModel);

        try {
          // Get a standalone Oracle Database connection
          connection = await oracledb.getConnection(dbConfig);

          // Check if we are connected to Oracle Database 23.4 that supports vectors
          if (connection.oracleServerVersion < 2304000000) {
            console.log('This example requires Oracle Database 23.4 or later');
            process.exit();
          }
          console.log('Connected to Oracle Database');
          console.log('Vectorizing the following data:');
          // Loop over the rows and vectorize the VARCHAR2 data
          const sql = 'select id, info from my_data order by 1';
          const result = await connection.execute(sql);

          const binds = [];

          const tic = performance.now();
          for (const row of result.rows) {
            // Prepare inputs
            const sentences = [row[1]];
            console.log(row);
            const response = await extractor(sentences, { pooling: 'mean', normalize: true });
            // Extract the vector from the JSON object, which is a Float32 Typed Array
            // Record the array and key
            binds.push([response.data, row[0]]);
          }
          // Do an update to add or replace the vector values
          await connection.executeMany('update my_data set v = :1 where id = :2', binds,
            { autoCommit: true });
          const toc = performance.now();

          console.log(`Vectors took ${((toc - tic) / 1000).toFixed(4)} seconds`);
          console.log(`Added ${binds.length} vectors to the table`);
        } catch (err) {
          console.error(err);
        } finally {
          if (connection)
            await connection.close();
        }
      }

      vectorize();

      </copy>
    ```

2. Save the file and run it with *nodejs18* as follows:


    ```
      <copy>
      node vectorizeTableHFTransformers.js
      </copy>
    ```

    You should see the following:

    ![Lab 3 Task 2 Step 2a](images/nodejstfr02a.png=60%x*)

    Once the program has completed you will see the following:

    ![Lab 3 Task 2 Step 2b](images/nodejstfr02b.png=60%x*)

    If you have previously run this process with Cohere or OpenAI, the first thing you will notice is that this operation runs significantly faster. This can be attributed to the fact that we do not have to go over the internet to perform the task.

    You may have also noticed that we used the *all-MiniLM-L6-v2* embedding model. This is a very popular embedding model with millions of monthly downloads. It's popularity is due to the fact that it tends to be a good trade-off when comparing accuracy and performance.

    To summarize what we've just done, the *vectorizeTableHFTransformers.js* program connects to the Oracle database, retrieves the text from the INFO column of the MY\_DATA table, and vectorizes the "factoid" for each of the 150 rows. We then store the vectorized data as a vector in the V column.


3. We can now query the MY\_DATA table in the Oracle database to verify that our data has been updated too:

    3.a. Connect to Oracle database as the user: *vector* and password *vector*

    ```
      <copy>
      sqlplus vector/vector@localhost/freepdb1
      </copy>
    ```


    3.b. We can now query the MY\_DATA table to verify that all 150 rows have been updated.

    ```
      <copy>
      select count(*) from my_data where V is not null ;
      </copy>
    ```

    You should see:

    ![Lab 3 Task 2 Step 3A](images/nodejstfr03.png=60%x*)


    3.c. We can also query the vector column: V in the MY\_DATA table to see what the vectors and dimensions look like.

    ```
      <copy>
      select info from my_data where V is not null ;
      </copy>
    ```


    You should see:

    ![Lab 3 Task 2 Step 3B](images/nodejstfr04.png=60%x*)


    ```
      <copy>
      select V from my_data ;
      </copy>
    ```


    You should see:

    ![Lab 3 Task 2 Step 3C](images/nodejstfr05.png=60%x*)


## Task 2: Understanding the Vector Embedding processing

  1. Before proceeding any further, lets take a look at the code of the Nodejs program we just ran. This will help us understand how this process is being performed. You will notice that this program looks very similar to the other vectorize\_table nodejs programs we have run in this workshop, the basic logic flow is very similar for the most part.

   Open the file with your favorite editor. You can use *vi* or *view* to view the contents of the file. We will not be making any changes to the program-

    ```
      <copy>
      vi vectorizeTableHFTransformers.js
      </copy>
    ```


    The first thing you should notice is that the program has just over 100 lines of code. If you've inspected the vectorizing node programs for Cohere or OpenAI you will see that this program logic is very similar. It calls the *oracledb* library to load the Node Oracle driver. This time however we are importing the SentenceTransformer package from Hugging Face.

    We also have a large number of embedding models to choose from. As we've aready noted, we opted to use the "all-MiniLM-L6-v2" embedding model due to it's popularity.       

    ![Lab 3 Task 3 Step 1a](images/nodejstfr06.png=60%x*)

    The next set of code is where we assign the embedding model we have chosen (un-commented line) to use.  

    ![Lab 3 Task 3 Step 1b](images/nodejstfr07.png=60%x*)

    If we scroll a little further down we can see the SQL code that is being called to populate the vectorized data into the MY\_DATA table. The first block of SQL code creates a cursor for the rows we wish to update and the second block performs the update operation.

    ![Lab 3 Task 3 Step 1c](images/nodejstfr08a.png=60%x*)
    ![Lab 3 Task 3 Step 1c](images/nodejstfr08b.png=60%x*)

## Task 3: Perform Similarity Search with Sentence Transformers

1. The file *similaritySearchHFTransformers.js*  is already on your machine. Below is the contents of the file.

    ```
      <copy>
      /* Copyright (c) 2024, Oracle and/or its affiliates. */

      /******************************************************************************
      *
      * This software is dual-licensed to you under the Universal Permissive License
      * (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
      * 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
      * either license.
      *
      * If you elect to accept the software under the Apache License, Version 2.0,
      * the following applies:
      *
      * Licensed under the Apache License, Version 2.0 (the "License");
      * you may not use this file except in compliance with the License.
      * You may obtain a copy of the License at
      *
      *    https://www.apache.org/licenses/LICENSE-2.0
      *
      * Unless required by applicable law or agreed to in writing, software
      * distributed under the License is distributed on an "AS IS" BASIS,
      * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      * See the License for the specific language governing permissions and
      * limitations under the License.
      *
      * NAME
      *   similaritySearchHFTransformers.js
      *
      * DESCRIPTION
      *   Basic Similarity Search using Hugging Face with the
      *   supported embedding models
      *   https://huggingface.co/docs/transformers.js/index
      *
      *****************************************************************************/

      const oracledb = require('oracledb');
      const readline = require('readline');
      const fs = require('fs');

      const readLineAsync = () => {
        const rl = readline.createInterface({
          input: process.stdin
        });

        return new Promise((resolve) => {
          rl.prompt();
          rl.on('line', (line) => {
            rl.close();
            resolve(line);
          });
        });
      };

      const setProxy = (url) => {
        const { bootstrap } = require('global-agent');
        const { setGlobalDispatcher, ProxyAgent } = require('undici');
        bootstrap();
        const dispatcher = new ProxyAgent({ uri: new URL(url).toString() });
        setGlobalDispatcher(dispatcher);
      };

      async function runSimilaritySearch() {
        let connection;
        const dbConfig = {
          user          : process.env.NODE_ORACLEDB_USER,
          password      : process.env.NODE_ORACLEDB_PASSWORD,
          connectString : process.env.NODE_ORACLEDB_CONNECTIONSTRING
        };

        const topK = 5;
        let reRank = false;

        /** Select/Set your Embedding model here */
        // const embeddingModel = 'Xenova/multilingual-e5-large';
        const embeddingModel = 'Xenova/all-MiniLM-L6-v2';

        // Re-ranking models
        const reRankModel = 'Xenova/bge-reranker-base';

        console.log('Using embedding model ' + embeddingModel);

        // Call the import function for the transformers module
        const { AutoModelForSequenceClassification, AutoTokenizer, pipeline, env } = await import('@xenova/transformers');

        const PROXYURL = process.env.GLOBAL_AGENT_HTTP_PROXY;
        // Check and connect through proxy, if required.
        // As 'Xenova/transformers' uses native fetch for downloading the models
        // from the remote URL, The global dispatcher must be updated if we are
        // connecting through a firewall or a corporate proxy to download the models.
        // Once and if the model is cached locally, there is no need to connect to
        // the remote URL again.

        let modelCacheDir;
        let isProxyAgentSet = false;
        if (process.platform === 'win32')
          modelCacheDir = `${env.cacheDir}\\${embeddingModel.replace('/', '\\')}`;
        else
          modelCacheDir = `${env.cacheDir}/${embeddingModel}`;

        // Embedding model caching with Proxy
        if (PROXYURL && !fs.existsSync(modelCacheDir)) {
          setProxy(PROXYURL);
          isProxyAgentSet = true;
        }

        let tokenizer, model;
        if (reRank) {
          if (!isProxyAgentSet) {
            let reRankModelCacheDir;
            if (process.platform === 'win32') {
              reRankModelCacheDir = `${env.cacheDir}\\${reRankModel.replace('/', '\\')}`;     
            } else {
              reRankModelCacheDir = `${env.cacheDir}/${reRankModel}`;
            }
        
            // Rerank model caching with Proxy
            if (PROXYURL && !fs.existsSync(reRankModelCacheDir)) {
              setProxy(PROXYURL);
              isProxyAgentSet = true;
            }
          }
          tokenizer = await AutoTokenizer.from_pretrained(reRankModel);
          model = await AutoModelForSequenceClassification.from_pretrained(reRankModel, { quantized: false });
          console.log('Using reranker ' + reRankModel);
        } else {
          // Not using reranking
          console.log('Not using reranking');
        }

        console.log('TopK = ' + topK);

        const extractor = await pipeline('feature-extraction', embeddingModel);

        try {
          //oracledb.initOracleClient(); // For node-oracledb Thick mode

          // Get a standalone Oracle Database connection
          connection = await oracledb.getConnection(dbConfig);

          //Check if we are connected to Oracle Database 23.4 that supports vectors
          if (connection.oracleServerVersion < 2304000000) {
            console.log('This example requires Oracle Database 23.4 or later');
            process.exit();
          }
          console.log('Connected to Oracle Database');

          const sql = `select info from my_data
                        order by vector_distance(v, :1, COSINE)
                        fetch first :2 rows only`;

          while (true) {
            // Get the text input to vectorize
            console.log("\nEnter a phrase. Type 'quit' or 'exit' to exit : ");
            const text = await readLineAsync();

            if (text === 'quit' || text === 'exit')
              break;

            if (text === '')
              continue;

            let tic, toc;
            // Create the vector embedding [a Tensor object] with the data
            // attribute containing the vector data as a Float32 Typed Array
            const sentence = [text];

            tic = performance.now();
            const response = await extractor(sentence, { pooling: 'mean', normalize: true });
            toc = performance.now();
            console.log(`\nVectorize query took ${((toc - tic) / 1000).toFixed(3)} seconds`);

            const docs = [];
            const texts = [];
          
            tic = performance.now();
            // Do the Similarity Search
            const rows = (await connection.execute(sql, [response.data, topK])).rows;
            toc = performance.now();

            for (const row of rows) {
              // Remember the SQL data resultset
              docs.push(row[0]);
              texts.push(text);
            }
            console.log(`Similarity Search took ${((toc - tic) / 1000).toFixed(3)} seconds`);

            if (!reRank) {
              // Just rely on the vector distance for the resultset order
              console.log('\nWithout ReRanking');
              console.log('=================');

              for (const hit of docs) {
                console.log(hit);
              }
            } else {
              tic = performance.now();

              // Rerank for better results
              const inputs = tokenizer(texts, { text_pair: docs, padding: true, truncation: true });
              const modelOutput = await model(inputs);
              const scores = modelOutput.logits.data;

              toc = performance.now();

              console.log(`Rerank took ${((toc - tic) / 1000).toFixed(3)} seconds`);

              let idx;
              const unranked = [];
              for (idx = 0; idx < topK; idx ++) {
                unranked.push([scores[idx], docs[idx]]);
              }

              // Sort the unranked list based on the scores in descending order
              const reranked = unranked.sort((a, b) => a[0] - b[0]).reverse();
              console.log('\nReranked results');
              console.log('=================');

              for (idx = 0; idx < topK; idx ++) {
                console.log(reranked[idx][1]);
              }
            }

          } // End of while loop
        } catch (err) {
          console.error(err);
        } finally {
          if (connection)
            await connection.close();
        }
      }

      runSimilaritySearch();

      </copy>
    ```

   Now that we've vectorized our data and created the similarity search file, we are ready to try performing a similarity search using the Sentence Transformers.

2. You can do this by-

    ```
      <copy>
      node similaritySearchHFTransformers.js
      </copy>
    ```

    **NOTE:** The embedding model being used is displayed when we run the program. It is important to make sure that the embedding model you use matches the embedding model you chose when you vectorized the data - in this instance we vectorized our data with *"all-MiniLM-L6-v2"*, and our search is using the same model, so we are good to go. A mismatch will lead to an error and even worse a false positive - in the sense that no error will be displayed but the wrong results will be displayed.

    For our first example let's try the word "cars". This is the same phrase we have tested using the Cohere and OpenAI models, so if you have used those embedding models, you know what to expect, and the results should be similar.

    Enter Phrase: **cars**

    ![Lab 3 Task 4 Step 1b](images/nodejstfr09.png=60%x*)

    In our situation it took half a second to vectorize the query and about 2 milliseconds to perform the query. This is extremely fast when we compare it to the Cohere and OpenAI models as we do not need to perform the roundtrip REST calls over the internet.


3. Next let's try the phrase "cats" and see what is returned.

    Enter phrase: **cats**

    You should see:

    ![Lab 3 Task 4 Step 2](images/nodejstfr10.png=60%x*)

    The first thing you may notice is that the operation runs even faster now as we have already performed our database connection and authorization and the Sentence Transformers libraries are already loaded into memory too.

    Looking at the query output, not all the results are directly related to our search term: "cats", but one could argue that there is a minor correlation as all 5 rows are animal associations and not fruit. So not bad considering our relatively small number of 150 entries.

4. If we try a more general term like "animals" we should see the following:

    Enter phrase: **animals**

    ![Lab 3 Task 4 Step 3](images/nodejstfr11.png=60%x*)


5. Let's try two queries related to New York...

    First we'll try "NY" and then "boroughs"

    Enter phrase: **NY**

    Enter phrase: **boroughs**

    This time you should see the following:

    ![Lab 3 Task 4 Step 4](images/nodejstfr12.png=60%x*)

    This time we see results that are accurate. For "NY", the model returns the names of places located in the state of "New York". The second search for the term "boroughs" is 100% accurate using the Sentence Transformers embedding model.

6. Another interesting query to test our results are for the phrase "New Zealand".

    Enter Phrase: **New Zealand**

    This time we see the following:

    ![Lab 3 Task 4 Step 5](images/nodejstfr13.png=60%x*)

    The results we see when using the Sentence Transformers embedding model have nothing to do with "New Zealand", though they are geographic locations, so one could argue there is a minor correlation here.

## Task 4: Changing embedding models

  1. Just as we have done with the embedding models from other vendors, let's experiment with changing the Sentence Transformer embedding model.

  In this instance we will see what happens when we use a multilingual embedding model. We will switch from *"sentence-transformers/all-MiniLM-L6-v2"* to *"intfloat/multilingual-e5-large"*. This embedding model not only supports English, but also other languages including: German, Spanish, Japanese, Russian, Thai, etc

  To switch embedding models you will need to comment out the line:
    
    *embedding\_model = "sentence-transformers/all-MiniLM-L6-v2"*

  and uncomment the line:
    
    *embedding\_model = "intfloat/multilingual-e5-large"*.

   To make this switch we will need to change the embedding model in both the programs:

    - *vectorizeTableHFTransformers.js*

    ```
      <copy>
      vi vectorizeTableHFTransformers.js
      </copy>
    ```

    - *similaritySearchHFTransformers.js*

    ```
      <copy>
      vi similaritySearchHFTransformers.js
      </copy>
    ```


    Your programs will look like this **BEFORE** making your modification-

    ![Lab 3 Task 5 Step 1](images/nodejstfr14.png=60%x*)

    Your programs will look like this **AFTER** making your modification-

    ![Lab 3 Task 5 Step 1](images/nodejstfr15.png=60%x*)



2. Before changing to a different embedding model for performing a similarity search you must re-vectorize the contents of the table: MY\_DATA. Do this by running the *vectorizeTableHFTransformers.js* program as follows:


    ```
      <copy>
      node vectorizeTableHFTransformers.js
      </copy>
    ```

    You should see:

    ![Lab 3 Task 5 Step 2](images/nodejstfr16.png=60%x*)

    **NOTE:** Verify that the program is using the new embedding model.

    Since it's the first time we are using this new embedding model there are multiple libraries and modules that will be downloaded and installed into our system. This is done automatically and there should be no manual intervention required, but this will require addition disk space (our system has been sized to accomodate this). Once the embedding model is installed, the data will be vectorized.  


3. We're now ready to try out our new model. As a baseline let's start with the term "cars".  But this time, we'll also perform the similarity search in Spanish "coche", French "voiture" and even a Spanish dialect "carros". What is interesting, is that while the phrases returned are all accurately related to the search phrase "cars", they are not identical phrases returned per language, nor are they in the same sequence.

    Enter Phrase: **cars**

    Enter Phrase: **coche**

    Enter Phrase: **voiture**

    Enter Phrase: **carros**

    You should see:

    ![Lab 3 Task 5 Step 3](images/nodejstfr17.png=60%x*)


4. So now let's take a look at how the new model fares when we try our phrase "cats" and this time we'll also try German "katze" and Spanish "gato" as well to see what happens...    

    Enter Phrase: **cats**

    Enter Phrase: **katze**

    Enter Phrase: **gato**

    You should see:

    ![Lab 3 Task 5 Step 4](images/nodejstfr18.png=60%x*)

    Once again the embedding model is fairly accurate for the first two responses for all 3 languages. But after that the results are mixed. In the English version the results are at least within the animals grouping, but the German and Spanish results are a bit more random. Once again underscoring subtle nuances between differnt embedding models.
## Appendix: Installing hugging face sentence transformers on your own machine

1. To install the *sentence-transformers* packages from hugging face with *npm* (package installer for node). While logged in as the oracle Linux user, run the following *npm* command:

    ```
      <copy>
      npm install @xenova/transformers
      </copy>
    ```

## Summary

In these labs you have seen how easy it is to use Oracle Vectors and Similarity Search with Nodejs. 

</if>
## Learn More

* [Oracle Database 23c Release Notes](../docs/release_notes.pdf)
* [Oracle AI Vector Search Users Guide](../docs/oracle-ai-vector-search-users-guide_latest.pdf)
* [Oracle Documentation](http://docs.oracle.com)
* [Cohere website: cohere.com](https://cohere.com)
* [huggingface.co/sentence-transformers](https://huggingface.co/sentence-transformers)
* [www.sbert.net](https://www.sbert.net/) 

## Acknowledgements
* **Author** - Zackary Rice, Software Developer
* **Contributors** - Sean Stacey, Outbound Product Manager, Doug Hood, Product Manager
* **Last Updated By/Date** - Zackary Rice, April 2024
