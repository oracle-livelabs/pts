# Retrieval Augmented Generation (RAG)

## Introduction

This lab walks you through the steps to create a RAG pipeline using AI Vector Search to augment a query to a Large Language Model (LLM). This Lab will use the OCI Generative AI service (OCI Gen AI) to access an LLM. The LLM used will be "meta.llama-3.2-90b-vision-instruct". You can find more details about this model here: https://docs.oracle.com/en-us/iaas/Content/generative-ai/meta-llama-3-2-90b.htm#meta.llama-3.2-90b-vision-instruct.

We have already created an OCI Gen AI credential and enabled other setup requirements so that we can just access the LLM through the public REST endpoint associated with the US West (Chicago) region.

Watch the video below for a quick walk-through of the similarity search on the RAG lab:

[RAG Lab](https://videohub.oracle.com/media/Vector-Search-Image-Search-Lab/1_6hwxhdjg)

Estimated Lab Time: 10 minutes

### About Retrieval Augmented Generation

Retrieval Augmented Generation (RAG) involves augmenting prompts to Large Language Models (LLMs) with additional data, thereby expanding the LLM's knowledge beyond what it was trained on. This can be newer data that was not available when the LLM was trained, or it can be with private, enterprise data that was never available to the LLM. LLMs are trained on patterns and data up to a point in time. After that, new data is not available to an LLM unless it is re-trained to incorporate that new data. This can lead to inaccurate answers or even made-up answers, also known as hallucinations, when the LLM is asked questions about information that it knows nothing about or only has partial knowledge of. The goal of RAG is to address this situation by supplying additional, relevant information about the questions being asked to enable the LLM to give more accurate answers. This is where AI Vector Search fits. AI Vector Search can be used to pass private business or database data to the LLM using SQL.

In this Lab we will be querying the Benny Benefits dataset ...


### Objectives

In this lab, you will:

* Learn about Retrieval Augmented Generation (RAG)
* Run a query to access an LLM and retrieve a response
* Run a similarity search to find benefits for a particular issue
* Run combined query that uses similarity search to augment the first query and send to the LLM
* Run a simulated HR benefits demo

### Prerequisites

This lab assumes you have:
* An Oracle Account (oracle.com account)
* All previous labs successfully completed


## Task 1: Send a question to the LLM

This task will send our question to the LLM and retrieve the answer. This will give us a baseline to use to see how much different an augmented query will make to the LLM's answer.

1. Run the following query to send our question to the LLM:

    ```
    <copy>
    exec :llm_params := '{"provider":"ocigenai","credential_name":"OCI_GENAI_CRED","url":"https://inference.generativeai.us-chicago-1.oci.oraclecloud.com/20231130/actions/chat","model":"meta.llama-3.2-90b-vision-instruct","transfer_timeout":300,"temperature":0,"topP":0.000001,"num_ctx":8192}';
    exec :user_question := 'The question goes here';

    with
      llm_prompt as
        (select ('Question: ' || :user_question ) as prompt_text from dual)
    select to_char(dbms_vector_chain.utl_to_generate_text(prompt_text, json(:llm_params))) as llm_response from llm_prompt;
    </copy>
    ```
     
## Task 2: Run a similarity search to find specific benefit polices

In this task we will ...


## Task 3: Run a RAG query to augment our first LLM question with specific benefit policies

In this task we will run similar queries to the ones we ran in the previous labs, but now we will use our text phrases to search ...

## Task 4: Run Benny Benefits chatbot demo

The ...

1. To run the demo ...:


You may now **proceed to the next lab**


## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 23ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes, Product Manager, AI Vector Search
* **Contributors** - Sean Stacey, Product Manager, AI Vector Search
* **Last Updated By/Date** - Andy Rivenes, Product Manager, AI Vector Search, September 2025
