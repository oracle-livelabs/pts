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
# Basic Similarity Search using the Cohere embed-english-light-v3.0 model
#

import os
import sys
import array

import oracledb
import cohere
import time

un = os.getenv("PYTHON_USERNAME")
pw = os.getenv("PYTHON_PASSWORD")
cs = os.getenv("PYTHON_CONNECTSTRING")

# topK is how many rows to return
topK = 5

# Re-ranking is about potentially improving the order of the resultset
# Re-ranking is significantly slower than doing similarity search
# Re-ranking is optional
rerank = 1

sql = """select info
         from my_data
         order by vector_distance(v, :1, COSINE)
         fetch APPROX first :2 rows only"""

#embedding_model =  "embed-english-light-v3.0"
embedding_model =  "embed-english-v3.0"
#embedding_model =  "embed-multilingual-light-v3.0"
#embedding_model =  "embed-multilingual-v3.0"

rerank_model = "rerank-english-v2.0"
#rerank_model = "rerank-multilingual-v2.0"

print("Using embedding model " + embedding_model)
if rerank:
  print("Using reranker " + rerank_model)
else:
  print("Not using reranking")

print("TopK = " + str(topK))

# Whether to generate int8 or float embeddings
use_int_8 = 0
if use_int_8:
    the_type = "int8"
    print("Using INT8 embeddings")
else:
    the_type = "float"
    print("Using float embeddings")

# Get your Cohere API Key from the environment
api_key = os.getenv("CO_API_KEY")
if api_key:
    print('Using Cohere CO_API_KEY')
else:
    print('\nYou need to set your Cohere API KEY\n')
    print('https://cohere.com/pricing')
    print('export CO_API_KEY=whatever_your_api_key_value_is\n')
    exit();

co = cohere.Client(api_key)

# Connect to Oracle Database 23.4
with oracledb.connect(user=un, password=pw, dsn=cs) as connection:
    db_version = tuple(int(s) for s in connection.version.split("."))[:2]
    if db_version < (23, 4):
        sys.exit("This example requires Oracle Database 23.4 or later")
    print("Connected to Oracle Database")

    with connection.cursor() as cursor:

        while True:
            # Get the input text to vectorize
            text = input("\nEnter a phrase. Type quit to exit : ")

            if (text == "quit") or (text == "exit"):
                break

            if text == "":
                continue

            # Create the vector embedding [a JSON object]
            sentence = [text]

            tic = time.perf_counter()

            # Create the vector embedding [a JSON object]
            response = co.embed(
                texts=sentence,
                model=embedding_model,
                input_type="search_query",
                embedding_types=[the_type]).embeddings

            toc = time.perf_counter()
            print(f"\nVectorize query took {toc - tic:0.3f} seconds")

            # Extract the vector from the JSON object
            # and convert to array format
            if use_int_8:
                vec = array.array("b", response.int8[0])
            else:
                vec = array.array("f", response.float[0])

            docs = []

            tic = time.perf_counter()

            # Do the Similarity Search
            for (info,) in cursor.execute(sql, [vec, topK]):

                # Copy the resultset to a list of docs
                docs.append(info)

            toc = time.perf_counter()
            print(f"Similarity Search took {toc - tic:0.3f} seconds")

            if rerank == 0:

                # Just rely on the vector distance for the resultset order
                print("\nWithout ReRanking")
                print("=================")
                for hit in docs:
                  print(hit)

            else:

              tic = time.perf_counter()

              # ReRank for better results
              results = co.rerank(query=text, 
                                  documents=docs, 
                                  top_n=topK, 
                                  model=rerank_model)

              toc = time.perf_counter()
              print(f"Rerank took {toc - tic:0.3f} seconds")

              print("\nReRanked results:")
              print("=================")
              for hit in results:
                print(docs[hit.index])
