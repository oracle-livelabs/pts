# AI Vector Search - Building Secure RAG applications with Oracle AI Vector Search and PLSQL

## About this Workshop

Retrieval Augmented Generation (RAG) plays a pivotal role in Generative AI, offering significant advantages to Gen AI applications. Here are three compelling reasons why integrating RAG into your Gen AI setup is paramount:

1. Guarding against Misinformation: Large Language Models (LLMs) may generate inaccurate or irrelevant responses if they lack training on specific prompts. Re-training LLMs to align with desired responses incurs substantial costs.
2. Safeguarding Confidentiality: Enterprises often deal with sensitive data and seek to harness the capabilities of Gen AI with LLMs economically.
3. Real-time Responsiveness: Enterprises rely on processing streaming data promptly, necessitating LLMs to provide rapid responses.
4. RAG addresses these challenges by enabling the inclusion of vital context alongside prompts provided to LLMs. In our laboratory scenario, this context comprises business information stored in Oracle Database 23ai as vectors.
5.  Leveraging Oracle PLSQL & the Oracle AI Vector Search functionality extend your application capabilities seamless retrieval of context.


![RAG image](images/rag_image.png)

In this workshop, you'll construct a straightforward yet robust RAG application utilizing Oracle AI Vector Search using PLSQL code. This application serves as a versatile blueprint applicable across various use cases, with Oracle Database 23ai serving as an optimal vector store for storing relevant context.

Estimated Time:  15 min

### **About Oracle AI Vector Search**

Oracle AI Vector Search is a feature of Oracle Database 23ai.  It allows the  searching of AI vectors in the database.  Oracle AI Vector Search supports fast search with a number of indexing strategies and can handle very large amounts of vector data.

AI Vector Search makes it possible for LLMs to query private business data using a natural language interface and helps LLMs provide more accurate and relevant results. In addition, AI Vector Search allows developers to easily add semantic search capabilities to both new applications and existing applications

### Objectives

The labs in this workshop focus on the following:
* Get familiar with the new Vector Datatype & PLSQL packages for manipulating vector data and operations
* Using the PLSQL for developing applications with Large Language Models (LLMs)
* Using Oracle AI Vector Search to store and search vectors in Oracle Database 23ai
* Access to popular LLMs and genrate output
* Run a complete sample appliciation to implement all learnings

### Prerequisites

- An Oracle LiveLabs Account

## Learn More

See below for more information on Oracle Database 23ai and Oracle AI Vector Search

* [Oracle Database 23ai Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/)
* [Oracle AI Vector Search User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [Oracle AI Vector Search Blog](https://blogs.oracle.com/database/post/oracle-announces-general-availability-of-ai-vector-search-in-oracle-database-23ai)

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Milton Wan, Vijay Balebail, Douglas Hood
* **Last Updated By/Date** -  Milton Wan, May 2024
