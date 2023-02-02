# Run SQL queries on PowerPoint slides and notes

## Introduction

Wouldn't it be awesome to query PowerPoint presentations using SQL to find some information inside the slides or the notes? Oracle Database can access data from any source, structured or unstructured. You must find a way to ingest those sources into the database and understand their format. This is just a hands-on workshop meant to be used as an exercise. It is not a solution or a best practice for extracting data from documents. It should be used for training purposes to understand how Oracle cloud resources can be integrated and used to build a solution.

Estimated Time: 2 hours

### Objectives

In this workshop you will:
* Provision cloud resources: networking, object storage, compute and autonomous database
* Install the XML file processor and mount object storage on compute instance
* Create credentials and access PowerPoint files uploaded to object storage
* Create tables, views, procedures for file processing inside Oracle database
* Write Linux Bash (Bourne Again Shell) scripts for file type conversions
* Create external tables based on flat files and document collections for JSON data
* Write PL/SQL stored procedures to process PowerPoint presentations
* Create views to expose structure, slides and notes data in a relational format

You will deploy this workflow to process PowerPoint documents and retrieve text data that can be used for any purpose inside your Oracle Autonomous Database.

![Workflow](./images/workflow.png "")

### Prerequisites

This workshop assumes you have:
* Access to Oracle Cloud Infrastructure
* Basic knowledge of Oracle Cloud resources
* Basic knowledge of Linux Bash programming
* Intermediate Oracle SQL and PL/SQL experience

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, January 2023
