# Setting up the environment

## Introduction

In this lab we will finalize the environment that we will use to run the rest of the workshop.

There are three main elements.

* A **Virtual Cloud Network (VCN)** has been pre-created. It represents the network topology inside the Oracle Cloud by defining the following components (Subnets, Route Tables, Security Lists, Gateways, etc.).
* A two-node **DBCS RAC database** with ASM storage has been pre-created.
* A **Compute instance** is a VM hosting our demo appliation.

**Estimated Time: 30 minutes.**

### Objectives

In this lab, you will:

* Complete the network configuration
* Configure RAC services
* Create a demo schema
* Compile a demo application

### Prerequisites

* An Oracle Free Tier, Always Free, or Paid Oracle Cloud Account
* Or Oracle LiveLabs sandbox environment

## Task 1: Configure networking


> **Note**: Some components have been pre-created.

1. Create a **Network Security Group** rule allowing Oracle Net connectivity.

![NSGdef](./images/task1/img100.png)

![NSGrule](./images/task1/img200.png)


2. Add ONS egress/ingress rules.


## Task 2: Configure RAC services

1. Check ONS is running on the server
2. Standard service (no Application Continuity)
3. New service (with Application Continuity support)
4. Create TNS aliases in tnsnames.ora for the 2 services


## Task 3: Create demo schema

1. Create tablespace and user
2. Create  schema


## Task 4: Compile demo application

1. Download libraries and set CLASSPATH
2. Build the JDBC URL for the connection pool
3. Compile demo


15. **Sign in** as **DEMO** user.

    - Username: **demo**
    ```
    <copy>demo</copy>
    ```
    - Password: **DBlearnPTS#22_**
    ```
    <copy>DBlearnPTS#22_</copy>
    ```



18. Provide the following information:

    - Collection Name: **SimpleCollection**
    ```
    <copy>SimpleCollection</copy>
    ```
    - Click **Create**


**You can proceed to the next lab…**


## Acknowledgements
* **Author** - François Pons, Senior Principal Product Manager
* **Contributors** - Andrei Manoliu, Principal Product Manager
* **Last Updated By/Date** - François Pons, July 2022
