While logged into your Operating System as the Oracle user, create a file called *vectorize_table_Cohere.py* and paste the following contents into the file.


    ```
      <copy>
      # -----------------------------------------------------------------------------
      # Copyright (c) 2023, Oracle and/or its affiliates.
      #
      # This software is dual-licensed to you under the Universal Permissive License
      # (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl and Apache License
      # 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose
      # either license.
      #
      # If you elect to accept the software under the Apache License, Version 2.0,
      # the following applies:
      #
      # Licensed under the Apache License, Version 2.0 (the "License");
      # you may not use this file except in compliance with the License.
      # You may obtain a copy of the License at
      #
      #    https://www.apache.org/licenses/LICENSE-2.0
      #
      # Unless required by applicable law or agreed to in writing, software
      # distributed under the License is distributed on an "AS IS" BASIS,
      # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      # See the License for the specific language governing permissions and
      # limitations under the License.
      # -----------------------------------------------------------------------------
      #
      # Add or update the vectors for all data values in a table
      # Use the Cohere embed-english-light-v3.0 model to create the vectors
      #

      # If you are using a FREE Cohere API Key you will need to add a time delay.
      # Change the setting below to "1" if your key is a free key.
      use_free_key = 0
      #use_free_key = 1

      import os
      import sys
      import array
      import time
      
      import oracledb
      import cohere

      un = os.getenv("PYTHON_USERNAME")
      pw = os.getenv("PYTHON_PASSWORD")
      cs = os.getenv("PYTHON_CONNECTSTRING")

      query_sql = """select id, info
                     from my_data
                     order by 1"""

      update_sql = """update my_data set v = :1
                      where id = :2"""
      
      # Get your Cohere API Key from the environment
      api_key = os.getenv("CO_API_KEY")
      if api_key:
          print('Using Cohere CO_API_KEY')
      else:
          print('\nYou need to set your Cohere API KEY\n')
          print('https://cohere.com/pricing')
          print('export CO_API_KEY=whatever_your_api_key_value_is\n')
          exit();

      embedding_model =  "embed-english-light-v3.0"
      #embedding_model =  "embed-english-v3.0"
      #embedding_model =  "embed-multilingual-light-v3.0"
      #embedding_model =  "embed-multilingual-v3.0"
      
      # Whether to generate int8 or float embeddings
      use_int_8 = 0
      if use_int_8:
          the_type = "int8"
          print("Using INT8 embeddings")
      else:
          the_type = "float"
          print("Using float embeddings")

      if use_free_key:
          print("Using FREE Cohere API Key")
      else:
          print("Using PAID Cohere API Key")

      # Authenicate and authorize with cohere.com
      co = cohere.Client(api_key)

      # Connect to Oracle Database 23.4
      with oracledb.connect(user=un, password=pw, dsn=cs) as connection:
          db_version = tuple(int(s) for s in connection.version.split("."))[:2]
          if db_version < (23, 4):
              sys.exit("This example requires Oracle Database 23.4 or later")
          print("\nConnected to Oracle Database\n")

          with connection.cursor() as cursor:
              print("Vectorizing the following data:\n")

              # Loop over the rows and vectorize the VARCHAR2 data

              binds = []
              tic = time.perf_counter()
              for id_val, info in cursor.execute(query_sql):

                  # Convert to format that Cohere wants
                  data = [info]
      
                  print(info)

                  # Create the vector embedding [a JSON object]
                  response = co.embed(
                      texts=data, 
                      model=embedding_model, 
                      input_type="search_query",
                      embedding_types=[the_type]).embeddings

                  # Extract the vector from the JSON object
                  # and convert to array format
                  if use_int_8:
                      vec = array.array("b", response.int8[0])
                  else:
                      vec = array.array("f", response.float[0])

                  # Record the array and key
                  binds.append([vec, id_val])

                  # Sleep for half a second if the Cohere API Key is a free key
                  if use_free_key:
                      time.sleep(.485)


              toc = time.perf_counter()

              # Do an update to add or replace the vector values
              cursor.executemany(
                  update_sql,
                  binds,
              )
              connection.commit()

              print(f"\nVectors took {toc - tic:0.3f} seconds")
              print(f"\nAdded {len(binds)} vectors to the table using embedding model: " + embedding_model + "\n")
