# Application Continuity for Planned Maintenance

## Introduction

In this lab we will create a connection pool with 10 connections and verify that UCP distributes them equally between the cluster nodes.

Estimated Lab Time: 30 minutes


### Objectives

In this lab, you will:

* Verify that the UCP connection pool balances the connections between available instances
* Move database services between instances according to planned maintenance needs

### Prerequisites 

This lab assumes you have:
* The Oracle environment prepared in lab 1.


## Task 1: Configure the lab

1. Configure the pool for 10 connections

Edit the java demo application...

2. Recompile the application


## Task 2: Connection loda balancing

1. Start demo with TAC service
2. Observe Connection load balancing


## Task 3: Planned maintenance

1. Move the service to a different RAC instance
2. Show this is transparent to the program


**This is the end of the workshop**


## Acknowledgements
* **Author** - François Pons, Senior Principal Product Manager
* **Contributors** - Andrei Manoliu, Principal Product Manager
* **Last Updated By/Date** - François Pons, July 2022
