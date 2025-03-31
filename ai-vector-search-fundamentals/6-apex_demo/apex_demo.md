# APEX Demo Search on Images

## Introduction

This lab walks you through a demonstration of AI Vector Search in an APEX application using the SQL that we build in the previous steps in this Lab.

Estimated Lab Time: 5 minutes

### About APEX Demo

In the previous Labs, we loaded vector embedding models in the database and ran exact similarity searches and then created a vector index and ran approximate similarity searches. Now we are going to show you an APEX demo that uses the same dataset and queries that we were using in our SQL Developer Web to show how one might use AI Vector Search to write applications.

This demo will allow you to search for US National Parks based on some attribute like picnic tables and a general location if for example, you wanted to find a park to have a family picnic. Perhaps you're more adventurous and would like to find parks that you could go rock climbing in on your next vacation. We have also designed the application so you can supply any search term you want.


### Objectives

In this lab, you will:

* Use an APEX application to explore US National Parks.


### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Connecting to your Vector Database

The lab environment includes a preinstalled Oracle 23ai Database which includes AI Vector Search. We will be running the lab exercises from a pluggable database called: *orclpdb1* and connecting to the database as the user: *nationalparks*. The Lab will be run using SQL Developer Web.

To connect with SQL Developer Web to run the SQL commands in this lab you will first need to start a browser using the following URL. You will then be prompted to sign in:

  ```
  <copy>google-chrome http://localhost:8080/apex/nationalparks</copy>
  ```

After signing in you should see a browser window like the following:

 ![sqldev browser](images/apex_demo.png)


## Task 1: Run the APEX demo

You can now enter any search term and location that you would like to search on. You can pull down on a pre-created list of search terms or make up your own. You can specify a location or search all parks.

1. Run APEX demo:

    ![model query](images/CLIP_model.png)


## Learn More

* [Oracle AI Vector Search Users Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [OML4Py: Leveraging ONNX and Hugging Face for AI Vector Search](https://blogs.oracle.com/machinelearning/post/oml4py-leveraging-onnx-and-hugging-face-for-advanced-ai-vector-search)
* [Oracle Database 23ai Release Notes](https://docs.oracle.com/en/database/oracle/oracle-database/23/rnrdm/index.html)
* [Oracle Documentation](http://docs.oracle.com)

## Acknowledgements
* **Author** - Andy Rivenes and Sean Stacey, Product Managers
* **Contributors** - Markus Kissling, Product Manager
* **Last Updated By/Date** - Andy Rivenes, March 2025
