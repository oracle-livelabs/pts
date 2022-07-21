# Simple Application Continuity

## Introduction

In this lab we will configure a connection pool with a single connection. This will allow us to interrupt at will the demo application in the middle of a transaction and see whether or not Application Continuity hides the outage.

Estimated Lab Time: 30 minutes


### Objectives

In this lab, you will:

* Interrupt a transaction whilst connected with a **standard service** and experience an application error and a lost transaction.
* Interrupt a transaction whilst connected with a database service supporting **Application Continuity** and verify that the application continues without outage nor loss of any transactions.

### Prerequisites (Optional)

This lab assumes you have:
* The Oracle environment prepared in lab 1.


## Task 1: Configure the lab

1. Configure the pool to a single connection
2. Recompile the application


## Task 2: See what happens **without** Application Continuity

1. Refresh demo schema
2. Start demo with standard service
3. Run normal transactions
4. Observe what happens when connection aborts in the middle of a transaction


## Task 3: See what happens **with** Application Continuity

1. Refresh demo schema
2. Start demo with TAC service
3. Run normal transactions
4. Observe what happens when connection aborts in the middle of a transaction


**You can proceed to the next lab…**


## Acknowledgements
* **Author** - François Pons, Senior Principal Product Manager
* **Contributors** - Andrei Manoliu, Principal Product Manager
* **Last Updated By/Date** - François Pons, July 2022
