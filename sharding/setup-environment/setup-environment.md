# Provision Catalog and Shard Database

## Introduction

In this lab you will setup 4 compute instances using Oracle Resource Manager and Terraform. The databases are automatically installed in the instances. One will be used as the sharding catalog named cata. Others are used as the sharded database name shd1, shd2 and shd3.

Estimated Lab Time: 45 minutes.

### Objectives

-   Use Terraform and Resource Manager to setup the shard catalog and sharded database.

### Prerequisites

This lab assumes you have already completed the following:
- An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- Create a SSH Keys pair

Click on the link below to download the Resource Manager zip files you need to build your environment.

- [sdb19c-market-19.14.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/B4ZlrnlqqkuR0_1-qQEKAlFclrnIEQyyd0ZSmwsweoDmNUVg7-Z0wQ8a4j4nfvCC/n/c4u04/b/livelabsfiles/o/labfiles/sdb19c-market-19.14.zip) - Packaged terraform primary database instances creation script.



## Task 1: Prepare the Shard Database

1. Login to the Oracle Cloud Console, open the hamburger menu in the left hand corner. Choose **Resource Manager > Stacks**. Choose the **Compartment** that you want to use, click the  **Create Stack** button. *Note: If you are in a workshop, double check your region to ensure you are on the assigned region.*

    ![Login to the Oracle Cloud Console.](./images/cloud-homepage.png " ")

    ![Select stacks from resource manager.](./images/resource.png " ")

    

    ![Click the create stack button.](./images/step1-3-createstackpage.png " ")

2. Check the **ZIP FILE**, Click the **Browse** link and select the setup zip file (`sdb19c-primary-num.zip`) that you downloaded. Click **Select** to upload the zip file.

    ![Select and upload zip file.](images/selectzipfile.png)

    Accept all the defaults and click **Next**.


3. Accept the default value of the  `CataDB_Shape` and `Shard_Shape`. Paste the content of the public key you create before to the `SSH_PUBLIC_KEY`,  and click **Next**. (Note: If you don't want to compare the performance in the following labs and want save the resource, you can change the catalog db shape to VM.Standard2.1).

    ![Enter SSH key and click next.](images/entersshkey.png)

    

4. Click **Create**.

    ![Click to create stack.](images/clickcreate.png)

5. Your stack has now been created!  Now to create your environment. *Note: If you get an error about an invalid DNS label, go back to your Display Name, please do not enter ANY special characters or spaces. It will fail.*

    ![Your stack is now created.](./images/step1-7-stackcreated.png)

## Task 2: Terraform Plan (OPTIONAL)

When using Resource Manager to deploy an environment, execute a terraform **Plan** to verify the configuration. This is an optional STEP in this lab.

1.  [OPTIONAL] Click **Terraform Actions** -> **Plan** to validate your configuration. Click **Plan**. This takes about a minute, please be patient.

    ![Click plan from Terraform Actions.](./images/terraformactions.png " ")

    ![Plan window loading.](images/planwindow.png)

    ![Plan job accepted.](./images/planjob.png " ")

    ![Plan job succeeded.](./images/planjob1.png " ")

## Task 3: Terraform Apply

When using Resource Manager to deploy an environment, execute a terraform **Plan** and **Apply**. Let's do that now.

1. At the top of your page, click on **Stack Details**.  Click the button, **Terraform Actions** -> **Apply**. Click **Apply**. This will create your instance and install Oracle 19c. This takes about a minute, please be patient.

    ![Begin by clicking stack details.](./images/applyjob1.png " ")

    ![Click apply from Terraform Actions.](images/applyterraformactions.png)

    ![Apply job in progress.](./images/applyjob2.png " ")

    ![Apply job succeeded.](./images/step3-1-applyjob3.png " ")

    

2. Once this job succeeds, you will get an apply complete notification from Terraform.  Click **Outputs**,  you can get the **public ip address** and **private ip address** for each of the instances. Congratulations, your environment is created! Time to login to your instances to finish the configuration.

    ![Click outputs from Terraform.](images/terraformoutputs.png)

3.  Write down all the public and private ip for later use. It's same like the following.

    ```
    152.67.196.50  10.0.0.2 cata 
    152.67.196.240 10.0.0.3 shd1 
    152.67.199.233 10.0.0.4 shd2 
    152.67.196.227 10.0.0.5 shd3 
    ```

    

## Task 4: Connect to your Instance

### MAC or Windows CYGWIN Emulator

1.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/optionskey opc@<Your Compute Instance Public IP Address>
    ````

2. After successfully logging in, proceed to STEP 5.

    ```
    ssh -i labkey opc@xxx.xxx.xxx.xxx
    The authenticity of host 'xxx.xxx.xxx.xxx (xxx.xxx.xxx.xxx)' can't be established.
    ECDSA key fingerprint is SHA256:Wq+YNHzgc1JUySBJuTRO0T4NKpeRz5Udw82Mn5RCe6c.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added 'xxx.xxx.xxx.xxx' (ECDSA) to the list of known hosts.
    -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
    [opc@primary ~]$ 
    ```

    

### Windows using Putty

1.  Open up putty and create a new connection.

2.  Enter a name for the session and click **Save**.

    ![Enter a session name and click save.](./images/putty-setup.png " ")

3.  Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to **opc**.

4.  Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5.  Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![Navigate to your SSH private key and click open.](./images/putty-auth.png " ")

6.  The file path for the SSH private key file now displays in the Private key file for authentication field.

7.  Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session Step.

8.  Click Open to begin your session with the instance.

## Task 5: Verify the Database is Up

1.  From your connected session of choice **tail** the `buildsingle.log`, This file has the configures log of the database.

    ````
    <copy>
    tail -f /u01/ocidb/buildsingle.log
    </copy>
    ````
    ![This file has the configures log of the database.](./images/tailofbuilddbinstancelog.png " ")

2.  When you see the following message, the database setup is complete - **Completed successfully in XXXX seconds** (this may take up to 30 minutes). You can press Ctrl-C to exit from the tail command.

    ![After seeing success message exit from tail command.](./images/tailofbuilddbinstancelog-finished.png " ")

3.  Run the following command to verify the database with the SID **ORCL** is up and running.

    ````
    <copy>
    ps -ef | grep ORCL
    </copy>
    ````

    ![Run the command.](./images/pseforcl.png " ")

4. Verify the listener is running:

    ````
    <copy>
    ps -ef | grep tns
    </copy>
    ````

    ![Verify the listener is running.](./images/pseftns.png " ")

5.  Do the same steps to the other VMs, make sure all the databases are created correctly. Connect to the Database using SQL*Plus as the **oracle** user. The 4 CDBs we created named `cata, shd1, shd2, shd3` and the PDB named `catapdb, shdpdb1, shdpdb2, shdpdb3`.

    ````
    <copy>
    sudo su - oracle
    sqlplus system/Ora_DB4U@localhost:1521/catapdb
    </copy>
    ````

    ![Make sure all databases are created correctly.](./images/sqlplus-login-orclpdb.png " ")
    
6.  To leave `sqlplus` you need to use the exit command. Copy and paste the text below into your terminal to exit sqlplus.

    ````
    <copy>
    exit
    </copy>
    ````

7.  Copy and paste the below command to exit from oracle user and become an **opc** user.

    ````
    <copy>
    exit
    </copy>
    ````

You now have a fully functional Oracle Database 19c instance running on Oracle Cloud Compute. Check all the 4 instances and make sure they are ready.

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Minqiao Wang, DB Product Management, Dec 2020
* **Last Updated By/Date** - Minqiao Wang, July 2022

