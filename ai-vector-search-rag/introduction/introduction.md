# Introduction

## About this Workshop

This hands-on workshop covers the Oracle Database 23ai latest AI Vector Search capabilities. Learn how AI Vector Search in Oracle Database 23ai combines semantic search on unstructured data with relational search on traditional business data for faster, more relevant, and more secure results. Retrieval Augmented Generation (RAG) is a technique that improves the accuracy of Large Language Models (LLMs) by augmenting interactions with business-specific data. It avoids having to train LLMs on sensitive enterprise data and reduces hallucinations.

How is this workshop different from other workshops?
During this workshop you only need an Autonomous Database instance, it can be a Free Tier one, and you will import an APEX application that has all the components you need to run AI Vector Search and Retrieval-augmented generation (RAG) written in simple SQL and PL/SQL code that you can modify to understand how it works.

Estimated Workshop Time: 120 minutes.

### About AI Vector Search

Oracle AI Vector Search brings AI-powered similarity search to your business data without managing and integrating multiple databases or compromising functionality, security, and consistency. AI Vector Search enables searching both structured and unstructured data by semantics or meaning and values, enabling ultra-sophisticated AI search applications. Use the new native VECTOR data type to store vectors directly within tables in Oracle Database 23ai. This is why, for this workshop, you will use an Autonomous Database with Oracle Database 23ai.

[Oracle Database 23ai: Vector Search - Bring AI to your Data](youtube:pu79sny1AzY)

[Always Free Autonomous Database with Oracle Database 23ai](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/autonomous-always-free.html)

### About Retrieval Augmented Generation (RAG)

Retrieval-augmented generation (RAG) is a relatively new artificial intelligence technique that can improve the quality of generative AI by allowing large language models (LLMs) to tap additional data resources without retraining. Implementing RAG requires technologies such as vector databases, which allow for the rapid coding of new data and searches against that data to feed into the LLM.
Oracle AI Vector Search capabilities can help LLMs deliver more accurate and contextually relevant results for enterprise use cases using RAG on your business data. RAG provides a way to optimize the output of an LLM with targeted, domain-specific information without modifying the underlying LLM model itself. The targeted information can be more up-to-date than what was used to train the LLM and can be specific to a particular topic. That means the Generative AI system can provide more contextually appropriate answers to prompts and base those answers on your current data.

[Regions with Generative AI](https://docs.oracle.com/en-us/iaas/Content/generative-ai/overview.htm#regions)

### Objectives

In this workshop, you will learn how to:
* Upload files to OCI Object Storage using Oracle APEX
* Import files into the database from OCI Object Storage
* Work with LLMs imported inside Oracle Database
* Split documents and vectorize the chunks
* Perform AI Vector Search on text data
* Execute RAG on text data using OCI Generative AI service

### Prerequisites

This lab assumes you have the following:
* Access to Oracle Cloud Infrastructure (OCI), paid account or free tier, in a region that has:
    - Autonomous Database with Oracle Database 23ai
    - Generative AI
* Basic experience with OCI Cloud Console and standard components.
* Experience with Oracle Database features, SQL, and PL/SQL.
* Experience with Oracle Application Express (APEX) low-code development.

## Learn More

* [Database 23ai: Feature Highlights](https://www.oracle.com/database/23ai/)
* [Getting started with vectors in 23ai](https://blogs.oracle.com/coretec/post/getting-started-with-vectors-in-23ai)
* [Fast and Precise Business and Semantic Data Search with AI Vector Search](https://www.oracle.com/artificial-intelligence/semantic-data-search-with-vector-search/)
* [Generative AI capabilities](https://www.oracle.com/artificial-intelligence/generative-ai/)


## **Acknowledgements**

- **Author** - Valentin Leonard Tabacaru, Database Product Management
- **Last Updated By/Date** - Valentin Leonard Tabacaru, Database Product Management, March 2025
