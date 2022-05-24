# Oracle Machine Learning compute node preparation

## Introduction

Oracle Machine Learning workshop requires a compute node with Oracle Database 21c and OML tools. This instance can be created from a custom image.

### Objectives

In this lab, you will:
* Create the compute node from the custom image.
* Verify installed database and tools.

### Prerequisites

* Access to OCI OraclePartnerSas tenancy.

## Task 1: Create Compute Instance

1. On OCI OraclePartnerSas tenancy, select **Germany Central (Frankfurt)** region.

2. Navigate to Compute > **Custom Images**.

3. Select Compartment oraclepartnersas (root)/Team/**VTABACARU**.

4. Next to **OML-WS-IMG** custom image click **⋮** > **Create Instance**.

    - Name: give it a short name, e.g. *oml-vm-xy*.
    - Create in compartment: choose your compartment.
    - Under Network, Select existing virtual cloud network: Virtual cloud network in VTABACARU, REHEVCN.
    - Under Subnet, Select existing subnet: use the Public Subnet.
    - Public IP Address: it is necessary to Assign a public IPv4 address.

> **Note** : If you want to use your own VCN, change the compartment and select your VCN. You need to have the following ports open in your VCN Public Subnet Security List:
> - TCP 6080 for NoVNC
> - TCP 8888 for Jupyter
> - TCP 8787 for RStudio

5. After the instance is created, copy the Public IP address.


## Task 2: Verify Oracle Database and Listener.

1. In your browser, go to [**Public-IP**]:6080/index.html?resize=remote

2. Click Connect. Password is **MLlearnPTS#21_**

3. Open a Terminal. Run these commands one by one:

    ```
    <copy>
    fixHost

    . setEnv

    . oraenv</copy>

    ORACLE_SID = [mlcdb] ? - Hit Enter
    ```

4. Start the listener.

    ```
    <copy>lsnrctl start</copy>
    ```

5. Connect to the database and start it up.

    ```
    <copy>sqlplus / as sysdba

    startup</copy>
    ```

6. Verify the PDB, and exit Sql*Plus.

    ```
    <copy>show pdbs</copy>
    ```

7. Verify database services.

    ```
    <copy>lsnrctl status</copy>
    ```


## Task 3: Start Database Resident Connection Pooling

1. Connect to your PDB as SYSDBA.

    ```
    <copy>sqlplus sys/MLlearnPTS#21_@MLPDB1 as sysdba</copy>
    ```

2. Start the pool. Every time you restart the database, you will have to start the pool.

    ```
    <copy>
    exec DBMS_CONNECTION_POOL.start_pool;

    exit
    </copy>
    ```

6. Test DRCP on your PDB.

    ```
    <copy>sqlplus oml_user/MLlearnPTS#21_@MLPDB1P</copy>
    ```


## Task 4: Activate Python environment and start Jupyter

1. Go to the Python project folder in Terminal.

    ```
    <copy>cd ~/projects/oml4py/</copy>
    ```

2. Activate Python environment. Install any Python library in this environment. Ignore the warning message about Pip old version.

    ```
    <copy>. orclvenv/bin/activate

    pip install </copy>[library]
    ```

3. Start Jupyter Notebook.

    ```
    <copy>jupyter notebook --ip=0.0.0.0​</copy>
    ```

4. Copy the token value from the output. Jupyter Notebook is automatically launched in a browser window.

    ```
    http://0.0.0.0​:8888/?token=deee4a5109aa637deb61784774b61876a650b87970f2c499
    ```

5. If you want to connect to Jupyter Notebook from your browser, use the Public IP address:

    ```
    http://[**Public-IP**]:8888/?token=deee4a5109aa637deb61784774b61876a650b87970f2c499
    ```

6. This Terminal window must stay open until you finish and close Jupyter Notebook. To close, press **Ctrl-C** and **y**.

    ```
    Shutdown this notebook server (y/[n])? y
    ```

7. To deactivate the Python environment, run:

    ```
    <copy>deactivate</copy>
    ```


## Acknowledgements
* **Author** - Valentin Leonard Tabacaru
* **Last Updated By/Date** -  Valentin Leonard Tabacaru, July 2021
