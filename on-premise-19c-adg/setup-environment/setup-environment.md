# Setup Primary And Standby Compute Instance

## Introduction

In this lab you will setup 2 Oracle Cloud network (VCNs) and 2 compute instances using Oracle Resource Manager and Terraform. One simulate the primary site and another simulate the standby site. You can setup the primary and standby hosts using the related scripts. The primary and the standby hosts are in different VCN. You can setup primary and standby hosts in the same region or in different region.

Estimated Time: 40 minutes

### Objectives

- Use Terraform and Resource Manager to setup the primary and standby environment.

### Prerequisites

This lab assumes you have already completed the following:
- An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
- Create a SSH Keys pair

Click on the link below to download the Resource Manager zip files you need to build your environment.

- [db19c-primary-num-19.14.zip](https://objectstorage.us-phoenix-1.oraclecloud.com/p/WFlStlZpSo-OuHYfyyeEOP893BIOQqMX656nqc_ggCoWvyFEEQJS76OqiNmkOOZi/n/oraclepartnersas/b/dataguard_op/o/db19c-primary-num-19.14.zip) - Packaged terraform primary database instance creation script
- [db19c-standby-nodb-19.14.zip](https://objectstorage.us-phoenix-1.oraclecloud.com/p/uv4kCIVrE-NHHP2T-PAHF_Xq8iuT3-fJd6bIy_Fzo7ll-4yeSxH34W6lmilniCj2/n/oraclepartnersas/b/dataguard_op/o/db19c-standby-nodb-19.14.zip) - Packaged terraform standby database instance creation script



## **Task 1:** Prepare The Primary Database

1. Login to the Oracle Cloud Console, open the hamburger menu in the left hand corner. Choose **Developer Services**, under **Resource Manager** choose **Stacks**. Choose the **Compartment** that you want to use, click the  **Create Stack** button. 

    ![Resource Manager](images/image-resourcemanager.png " ")
    
    
    
    ![Create Stack Page](./images/step1.3-createstackpage.png " ")
    
2. Check the **ZIP FILE**, Click the **Browse** link and select the primary database setup zip file (`db19c-primary-num.zip`) that you downloaded. Click **Select** to upload the zip file.

    ![Stack Information Page](images/image-stackinforpage.png)

    Accept all the defaults and click **Next**.


3. Choose the **Compartment** you want to deploy the database instance. Upload or Paste the content of the public key you create before,  and click **Next**. 

    ![Configure Variables Page](images/image-configurevariable.png)

    

4. Click **Create**.

    ![Stack Review Page](images/image-stackreviewpage.png)

5. Your stack has now been created!  Now to create your environment. 

    ![Stack Details](images/image-stackdetail.png)



## Task 2: Terraform Apply

When using Resource Manager to deploy an environment, execute a terraform **Plan** and **Apply**. Let's do that now.

1.  In the **Stack Details** page.  Click **Apply**. This will create your instance and install Oracle 19c. This takes about a minute, please be patient.

    ![Apply](images/image-applypage.png)
    
    ![Apply Confirm](images/image-applyconfirm.png)
    
    ![Apply Running](images/image-applyrunning.png)
    
    ![Apply Finished](images/image-applyfinished.png)

2.  Once this job succeeds, you will get an apply complete notification from Terraform.  In the end of the apply log,  you can get the **public ip address** of the primary instance. Congratulations, your environment is created! Time to login to your instance to finish the configuration.

    ![Public IP](images/image-publicip.png)


## **Task 3:** Connect To Your Instance

### MAC or Windows CYGWIN Emulator

1.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    <copy>ssh -i labkey opc@<Your Compute Instance Public IP Address></copy>
    ````

2. After successfully logging in, proceed to Task 5.

    ```
    ssh -i labkey opc@xxx.xxx.xxx.xxx
    The authenticity of host 'xxx.xxx.xxx.xxx (xxx.xxx.xxx.xxx)' can't be established.
    ECDSA key fingerprint is SHA256:Wq***...***Ce6c.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added 'xxx.xxx.xxx.xxx' (ECDSA) to the list of known hosts.
    -bash: warning: setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory
    [opc@primary ~]$ 
    ```

    

### Windows Using Putty

1.  Open up putty and create a new connection.

2.  Enter a name for the session and click **Save**.

    ![Putty Setup](./images/putty-setup.png " ")

3.  Click **Connection** > **Data** in the left navigation pane and set the Auto-login username to root.

4.  Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking Browse under Private key file for authentication.

5.  Navigate to the location where you saved your SSH private key file, select the file, and click Open.  NOTE:  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![Putty Auth](./images/putty-auth.png " ")

6.  The file path for the SSH private key file now displays in the Private key file for authentication field.

7.  Click Session in the left navigation pane, then click Save in the Load, save or delete a stored session Task .

8.  Click Open to begin your session with the instance.


## **Task 4:** Verify The Database Is Up

1.  From your connected session of choice **tail** the `buildsingle.log`, This file has the configures log of the database.

    ````
    <copy>
    tail -f /u01/ocidb/buildsingle.log
    </copy>
    ````
    ![Tail of Build DB](./images/tailOfBuildDBInstanceLog.png " ")

2.  When you see the following message, the database setup is complete - **Completed successfully in XXXX seconds** (this may take up to 30 minutes). You can do the **Task 5** to setup the standby environment while waiting the primary database ready .

    ![tail of Build DB Finished](./images/tailOfBuildDBInstanceLog_finished.png " ")

3.  Run the following command to verify the database with the SID **ORCL** is up and running.

    ````
    <copy>
    ps -ef | grep ORCL
    </copy>
    ````

    ![ps ef orcl](./images/pseforcl.png " ")

4. Verify the listener is running:

    ````
    <copy>
    ps -ef | grep tns
    </copy>
    ````

    ![ps ef tns](./images/pseftns.png " ")

5.  Connect to the Database using SQL*Plus as the **oracle** user.

    ````
    <copy>
    sudo su - oracle
    sqlplus system/Ora_DB4U@localhost:1521/orclpdb
    </copy>
    ````
    

    ![SQL Plus connect](images/image-sqlplusconnect.png)
    
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

You now have a fully functional Oracle Database 19c instance **ORCL** running on Oracle Cloud Compute, the default pdb name is **orclpdb**. This instance is your primary DB.

## **Task 5:** Prepare The Standby Host

Repeat from the **Task 1** to **Task 3** to prepare the standby host. This time please choose the `db19c-standby-nodb.zip` file in the Resource Manager. And you can choose another region and compartment for the standby database.

After complete, you have a standby host which has the database software only been installed and no database created.

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Minqiao Wang, Oct 2020
* **Last Updated By/Date** - Minqiao Wang, Feb 2023
* **Workshop Expiry Date** - Nov 30, 2024



