# Application Continuity for planned maintenance

## Introduction

In this lab, we will create a connection pool with 10 connections and first verify that UCP distributes them equally between the cluster nodes.

We will then also direct (and drain) connections to a chosen node of the database cluster, thus making one node of the cluster available for planned maintenance.

Draining connections means that enough time is provided for current work to complete before maintenance is started on a node.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

* Verify that the UCP connection pool balances the connections between available instances
* Move database services between instances according to planned maintenance needs

### Prerequisites

This lab assumes you have:
* The Oracle environment prepared in previous lab.


## Task 1: Configure the Lab

1. Edit the java demo application MyUCPDemo.java and make sure the pool is configured to use a 10 connections. For example:

    ```
    pds.setInitialPoolSize(10);
    pds.setMinPoolSize(10);
    pds.setMaxPoolSize(20);
    ```

2. Recompile the application

    ````
    user@cloudshell:~ $ <copy>MyCompile.sh MyUCPDemo.java</copy>
    ````


3. Refresh demo schema

  We will start by refreshing the demo schema. Run **ddl_setup.sh** again from a third tab on your terminal window.

  ![Show script ddl_setup.sh](./images/task1/ddl-setup-script.png " ")

  ![Run script ddl_setup.sh](./images/task1/run-ddl-setup-script.png " ")


## Task 2: Observe Connection Balancing And Draining

1. Run the demo program with a database service that uses **Application Continuity**

    ````
    user@cloudshell:~ $ <copy>MyRun.sh MyUCPDemo tacsrv</copy>
    ````

    The application creates a connection pool of 10 connections, gets a connection from the pool and starts a first transaction.

    ![Start demo application](./images/task2/start-demo-application.png " ")


2. Observe the pool

    From a **second tab** in the terminal session, go to the **sql** directory and examine the pool by running **show_pool.sh**

    ![Show script show_pool.sh](./images/task2/show-pool-script.png " ")

    Observe that connections are spread across available nodes.

    ![Run script show_pool.sh](./images/task2/run-show-pool-script.png " ")


3. Strike RETURN and complete a few more transactions

    ![Show running application](./images/task2/running-application.png " ")


4. Prepare to no longer use node1 (ie instance CONT1) and drain existing connections

    Let us suppose we need to do some maintenance to node1 of the cluster.

    To be able to take node1 our of the cluster without impacting the application, let us move the service to instance 2.

    Using Cloud Shell:

    * Connect to the first node of the RAC cluster as **opc** and switch to the **oracle** user

        ````
        user@cloudshell:~ $ <copy>ssh -i [my-pub-key] opc@[node 1 public IP]</copy>
        ````

    * Switch to user *oracle*

        ````
        $ <copy>sudo su - oracle</copy>
        ````

    * Instruct the service to stop on instance CONT1

        ````
        user@cloudshell:~ $ <copy>srvctl stop service -db cont_prim -service tacsrv -instance CONT1</copy>
        ````

        The drain_timeout parameter of the service defines the tipme given to in-progtess trabsactions tpo complete.

        ````
        user@cloudshell:~ $ <copy>srvctl status service -db cont_prim -service tacsrv</copy>

        Service tacsrv is running on instance(s) CONT2
        ````

5. Run a couple more transactions and verify that the pool **does not get any errors** and has recreated **all connections to node2**

      ![Show completed transactions](./images/task2/completed-transactions.png " ")

      ![Show script show_pool.sh](./images/task2/show-pool-script-again.png " ")

      ![Run script show_pool.sh](./images/task2/show-pool-all-node2.png " ")


    This would allow a system administrator to take node 1 off the cluster for maintenance with no application outage whatsoever...


## Task 3: Route Connections To Instance 1 Only

1. We can now do the reverse and move the service to only CONT1

    ````
    user@cloudshell:~ $ <copy>srvctl start service -db cont_prim -service tacsrv -instance CONT1</copy>
    ````

    ````
    user@cloudshell:~ $ <copy>srvctl stop service -db cont_prim -service tacsrv -instance CONT2</copy>
    ````

    ````
    user@cloudshell:~ $ <copy>srvctl status service -db cont_prim -service tacsrv</copy>

    Service tacsrv is running on instance(s) CONT1
    ````

2. Run a couple more transactions and verify the pool is now only using connections to node1

  ![Show completed transactions](./images/task3/completed-transactions.png " ")

  ![Show script show_pool.sh](./images/task3/show-pool-script.png " ")

  ![Run script show_pool.sh](./images/task3/show-pool-on-first-node.png " ")


## Task 4: Re-Balance Connections To Both Nodes

1. Restart the service on both nodes

    ````
    user@cloudshell:~ $ <copy>srvctl start service -db cont_prim -service tacsrv -instance CONT2</copy>

    Service tacsrv is running on instance(s) CONT1,CONT2
    ````

    Observe how the pool reconfigures connections to both nodes by running **show_pool.sh** again

    ![Show pool has connections to both nodes](./images/task3/show-pool-on-both-nodes.png " ")



**This is the end of the workshop**


## Acknowledgements
* **Author** - François Pons, Senior Principal Product Manager
* **Contributors** - Andrei Manoliu, Principal Product Manager
* **Last Updated By/Date** - François Pons, September, 15th 2022
