# Creating Vector Data Type

## Introduction

This lab walks you through the steps to create a vector data type. The Lab uses a two table schema that contains data about US National Parks. The dataset 

Estimated Lab Time: 10 minutes


### About the new VECTOR data type

AI Vector Search adds a new VECTOR data type to Oracle Database. You can add one or more VECTOR data type columns to your application's table(s) to store vector embeddings. A vector embedding is a mathematical  representation of data points or, more simply, an array of numbers. Vector embeddings are generated using Machine Learning models to represent the distance between data. We will create vector embeddings in the next lab using the VECTOR data type we add in this lab.

The VECTOR data type is created as a column in a table. You can optionally specify the number of dimensions and their format. If you don't specify any dimension or format, you can enter vectors of different dimensions with different formats, although not at the same time. This is a simplification to help you get started with using vectors in Oracle Database and avoids having to recreate the vector definition if you later decide to change the vector embedding model and it uses a different number of dimensions and/or format.

The number of dimensions must be strictly greater than zero, with a maximum of 65535 for non-BINARY vectors and 65528 for BINARY vectors.

The possible dimension formats are:
*	INT8 (8-bit integers) 
*	FLOAT32 (32-bit IEEE floating-point numbers) 
*	FLOAT64 (64-bit IEEE floating-point numbers) 
*	BINARY (packed UINT8 bytes where each dimension is a single bit) 

### Objectives


In this lab, you will:
* Query a table definition
* Add a vector column
* Insert vectors and display them


### Prerequisites (Optional)

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*


## Connecting to your Vector Database

The lab environment includes a preinstalled Oracle 23ai Database which includes AI Vector Search. We will be running the lab exercises from a pluggable database called: *orclpdb1* and connecting to the database as the user: *vector* with the password: *vector*

The lab will use SQL Developer Web to run the SQL commands in this lab. To connect with SQL\*Plus you can use:

```

  <copy>sqlplus vector/vector@orclpdb1</copy>

```

You should see:

 ![Lab 1 Task 0](images/lab1task000.png)


## Task 1: Query a table definition

(optional) Task 1 opening paragraph.

1. Step 1

	![Image alt text](images/sample1.png)

2. Step 2

  ![Image alt text](images/sample1.png)

4. Example with inline navigation icon ![Image alt text](images/sample2.png) click **Navigation**.

5. Example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## Task 2: Add a vector column using different formats

1. Step 1 - tables sample

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

## Task 3: Insert and update sample vectors and display them

1. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

2. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
