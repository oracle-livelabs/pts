# Introduction

## About This Workshop

The **Getting Started with AI Vector Search** workshop will show you how you can combine the ability to perform similarity search on unstructured data like text and images with relational data to enable a whole new class of applications.

Estimated Workshop Time: 60 minutes

Oracle AI Vector Search is a sophisticated suite of capabilities, empowering developers to seamlessly store, index, and search vector data within Oracle Database. Vector data, represented as arrays of numbers, plays a pivotal role in capturing diverse features within unstructured data, including images, text, audio and video.

Key components of AI Vector Search include:

*Vector Data Type*: A data type designed to store vector data directly within Oracle Database, facilitating seamless integration.

*Similarity Search*: The ability to search for semantic similarity on structured or unstructured data.

*Vector Indexes*: Specialized indexing optimized for rapid and efficient retrieval of similar vectors, enhancing the database's search efficiency.

*Vector Search SQL Operators*: These SQL operators are tailored for conducting intricate similarity searches on vector data, providing developers with powerful tools to explore and analyze complex datasets.

Why use AI Vector Search?

At the heart of AI Vector Search is the ability to do a similarity search. A similarity search works with the semantic representations of your data rather than the value (words or pixels) and finds similar objects quickly. For example, find other images or documents that look like this one.  It uses vectors, or more precisely vector embeddings, to search for semantically similar objects based on their proximity to each other. In other words, vector embeddings are a way of representing almost any kind of data, like text, images, videos, and even music, as points in a multidimensional space where the locations of those points and proximity to other data are semantically meaningful.

Another big benefit of AI Vector Search is that similarity search can be combined with relational search on business data in one single system. This is not only powerful but also significantly more effective because AI Vector Search allows you to generate, store, index, and query vector embeddings along with other business data, using the full power of SQL. This means you don't need to add a specialized vector database, eliminating the pain of data fragmentation between multiple systems.

In this workshop we will build the AI Vector Search features that will enable you to use AI Vector Search to search on text and image data. In the interest of time, and not to get too far into all of the implementation details, we have already set up the database environment including pre-staging files, pre-loading embedding models and even pre-loading vector embeddings for the park images. All of this was done so that you could just run the labs in the workshop and see how AI Vector Search works. In our [blog posts](https://blogs.oracle.com/database/category/db-vector-search) we have gone into more detail about how AI Vector Search works and there is a wealth of information and examples in the [Oracle AI Vector Search User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/index.html) about how to use and implement AI Vector Search.

There will be labs that will use a US National Parks dataset to search on descriptions and images of parks based on your interests. For example, you may want to search for parks where you can have a family picnic, go rock climbing, or see other spectacular sights. Below you can see a search on "picnic tables" that you will be able to in the APEX Demo lab. The labs in this workshop will build the SQL and show you the features of AI Vector Search that enable this APEX-based demo.

![apex demo](images/apex_demo.png " ")

### Objectives

In this workshop, you will learn how to:

* Load a vector embedding model into Oracle AI Database.
* Learn about vectors and the new vector data type.
* Create vector embeddings from the embedding model you loaded.
* Learn what similarity search is.
* Perform an exact similarity search using basic SQL query operations.
* Create a vector index.
* Perform an approximate similarity search.
* Use similarity search with traditional relational searches.
* Run an APEX demo using the previously created data and queries.

### Prerequisites

This lab assumes you have:

* An Oracle Account (oracle.com account)

## Dataset

This workshop uses a public source:

* A public dataset from the [US National Parks] (https://www.nps.gov/subjects/science/science-data.htm) web site. There are two tables, a PARKS table that describes the different National Parks, and a PARK_IMAGES table that has one or more images for each of the parks.

## Tools

The examples in the Lab were run using the Google Chrome browser. If you use a different browser some attributes may look slightly different. For example, cut and paste may behave differently, and opening new windows based on a URL may have slightly different instructions.

In this Lab you will use Database Actions SQL Worksheet to access the database and run queries. The URL to invoke SQL Worksheet is listed in the "View Login Info" details. If you are not familiar with SQL Worksheet you can run through a short tutorial by clicking on the binoculars in the circled image below once you start SQL Worksheet in each of the following labs.

![sqldev help](images/sqldev_help.png " ")

In the APEX demo lab you will use APEX to run an application demonstration of just how powerful AI Vector Search can be. The URL to invoke the APEX demo is also listed in the "View Login Info" details.

## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 26ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes, Product Manager, AI Vector Search
* **Contributors** - Markus Kissling, Product Managers, AI Vector Search
* **Last Updated By/Date** - Andy Rivenes, Product Manager, AI Vector Search, March 2026
