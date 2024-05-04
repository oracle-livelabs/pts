# AI Vector Search - 7 Easy Steps to Building a RAG application with Oracle AI Vector Search and LangChain

## About this Workshop

Retrieval Augmented Generation (RAG) is an important component in Generative AI.  Here are three reasons why RAG should be included in your Gen AI application.
1.	LLMs can hallucinate or generate incorrect responses to your prompt if it has not been trained to respond to the query in the prompt.  Retraining LLMs to produce the responses you want can be very expensive.
2.	Businesses and enterprises have lots of private and confidential information and they want to leverage the power of Gen AI with LLMs with the least cost.  
3.	Businesses and enterprises have streaming data and need LLM responses to this data in near real time.

And that’s where RAG comes in.  RAG allows important context to be included with the prompt to the LLM.  In our lab use case the context is the business information, and we store that information in the form of vectors in Oracle Database 23ai, and we use the Oracle AI Vector Search capability to return the context.

![RAG image](images/rag_image.png)

In this workshop, you will build a simple, yet powerful RAG application using Oracle AI Vector Search and the LangChain framework that can be used as a blueprint for many use cases.  A vector store will be needed to store the relevant context and Oracle Database 23ai is ideal for this.

Estimated Time:  0 hours 15 min

### **About Oracle AI Vector Search**

Oracle AI Vector Search is a feature of Oracle Database 23ai.  It allows the  searching of AI vectors in the database.  Oracle AI Vector Search supports fast search with a number of indexing strategies and can handle very large amounts of vector data.

### Objectives

The labs in this workshop focus on the following:
* Using the LangChain framework for developing applications with Large Language Models (LLMs)
* Using Oracle AI Vector Search to store and search vectors in Oracle Database 23ai
* Access to popular LLMs

### Prerequisites

- An Oracle LiveLabs Account


## Learn More

* [About Oracle Database 23ai](https://docs.oracle.com/en/database/oracle/oracle-database/)
* [Oracle AI Vector Search](https://www.oracle.com/news/announcement/ocw-integrated-vector-database-augments-generative-ai-2023-09-19/)

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Milton Wan, Vijay Balebail
* **Last Updated By/Date** -  Milton Wan, April 2024
