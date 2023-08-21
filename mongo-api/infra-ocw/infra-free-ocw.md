# Infrastructure configuration

## Introduction

In this lab we will build the infrastructure that we will use to run the rest of the workshop.

The main three elements that we will be creating are a **Virtual Cloud Network** which helps you define your own data center network topology inside the Oracle Cloud by defining some of the following components (Subnets, Route Tables, Security Lists, Gateways, etc.), **Compute instance** using an image from the marketplace including the libraries need to execute the scripts needed to create and execute applications in Python. And finally an **Autonomous JSON Database** where we will allocate the JSON documents that we will ingest our Python apps with.

We will prepare the documents to be capable of accessing to **SODA APIs**, in particular, to create, drop, and list document collections using **APEX** as vehicle to visualize the JSON documents as we used to do with structure data. This capability is unique of Oracle Databases.

Estimated Time: 40 minutes

Watch the video below for a quick walk-through of the lab.
[Infrastructure Configuration](videohub:1_pcbhdbtb)


### Objectives

In this lab, you will:

* Create Virtual Cloud Network (VCN)
* Provision Compute Node for development
* Provision Oracle Autonomous JSON Database (AJD)
* Prepare Document Store

### Prerequisites

* An Oracle Cloud Infrastructure (OCI) account


## Task 1: Create Virtual Cloud Network (VCN)

1. Login to Oracle cloud console: [cloud.oracle.com](https://cloud.oracle.com/)

    - Cloud Account Name: oci-tenant
    - **Next**

    ![cloud Account Name](./images/cloud-account-name.png)

    - User Name: oci-username - email address provided
    - Password: oci-password
    - **Sign In**

    ![User Name & Password](./images/username-password.png)    

2. Click on main menu ≡, then Networking > **Virtual Cloud Networks**. Select your Region and Compartment assigned by the instructor.

    >**Note**: Use **Root** Compartment, oci-tenant(root), to create all resources for this workshop.

    ![Oracle Console Networking](./images/oracle-console-networking.png)

3. Select your Region and Compartment assigned by the instructor. Click **Start VCN Wizard**.

    ![Oracle Console Networking Start Wizard](./images/oracle-console-networking-start-wizard.png)

4. Select **Create VCN with Internet Connectivity**. Start **VCN Wizard**.

   ![Create VCN with Internet Connectivity](./images/create-vcn-with-internet-connectivity.png)

5. Provide the following information:

    - VCN Name: **DEVCN**
    ```
    <copy>DEVCN</copy>
    ```
    - Compartment: Be sure you have selected the correct one for this workshop purpose. **Root** is the recommended one
    - Click **Next**

    ![vcnName & Compartment](./images/vcn-name-compartment.png)

6. Review the information in the 'Review and Create Page' and Click **Create**.

    ![vcn Creation](./images/vcn-creation.png)

7. The Resources have being created on the next page. Click **View VCNic** to access to the VCN.

    ![View vcn Page](./images/view-vcn-page.png)
    ![DEVCN Detail](./images/devcn-detail.png)

8. Click **public Subnet-DEVCN**.

    ![Public Subnet](./images/public-subnet.png)

9. Click **Default Security List for DEVCN**.

    ![Default Security List for DEVCN](./images/default-security-list-for-devcn.png)

10. Click **Add Ingress Rules**.

    ![Add Ingress Rules](./images/add-ingress-rules.png)

11. Provide the following information:

    - CIDR Block: **0.0.0.0/0**
    ```
    <copy>0.0.0.0/0</copy>
    ```
    - Destination Port Range: **5000**
    ```
    <copy>5000</copy>
    ```
    - Description: **Python Flask**
    ```
    <copy>Python Flask</copy>
    ```
    - Click **+ Another Ingress Rule**

    ![Python Flask Rule](./images/python-flask-rule.png)

12. Provide the following information:

    - CIDR Block: **0.0.0.0/0**
    ```
    <copy>0.0.0.0/0</copy>
    ```
    - Destination Port Range: **80**
    ```
    <copy>80</copy>
    ```
    - Description: **HTTP**
    ```
    <copy>HTTP</copy>
    ```
    - Click **Add Ingress Rules**

    ![Port 80 Rule](./images/port80-rule-new.png)

13. You can check on the **Detail Page** that the 2 Ingress Rules have been added.

    ![All Ingress Rules Added](./images/all-ingress-rules-added-new.png)

## Task 2: Provision Compute Node for development

1. Click on the following link to access to a marketplace image from [Oracle marketplace](https://bit.ly/3CxvsxA).

    ![Marketplace Image](./images/marketplace-image.png)

2. Click **Get App**.

    ![Marketplace Get App](./images/marketplace-get-app.png)

3. Select **Commercial Market** and click **Sign in**.

    ![Marketplace Commercial Market](./images/marketplace-commercial-market.png)

4. In the next screen be sure that you have the correct information:

    - Version: 2.0 (3/4/2022) - default
    - Compartment: Be sure you have selected the correct one for this workshop purpose. **Root** is the recommended one
    - **Accept** the Oracle standard Terms and Restrictions
    - **Launch Instance**

    ![Marketplace Launch App](./images/marketplace-launch-app.png)

5. Provide the following information:

    - Name: **DEVM**
    ```
    <copy>DEVM</copy>
    ```
    - Compartment: Be sure you have selected the correct one for this workshop purpose. **Root** is the recommended one
    - Image and shape: click **Edit/Collapse** and after **Change shape** if you don't have the following information:
        - Image: **MongoDB and Autonomous JSON workshop**
        - Shape: **VM.Standard.E2.1.Micro**

    ![Marketplace Compute Instance Creation](./images/marketplace-compute-instance-creation.png)

    If you are using your own cloud account, not just a trial, you can see this section different. Just be sure you have all the information as following selected:

    - Name: **DEVM**
    ```
    <copy>DEVM</copy>
    ```
    - Compartment: Be sure you have selected the correct one for this workshop purpose. **Root** is the recommended one
    - Image and shape: click **Edit/Collapse** and after **Change shape** if you don't have the following information:
        - Image: **MongoDB and Autonomous JSON workshop**
        - Shape: **VM.Standard.E2.1.Micro**

    ![Marketplace Compute Instance Creation No Trial](./images/marketplace-compute-instance-creation-no-trial.png)

    - Networking: Be sure you have the following information. If not, click **Edit/Collapse** to edit the information:

        - Virtual cloud network: **DEVCN**
        - Subnet: **public Subnet-DEVCN (regional)**

    ![Networking Compute](./images/networking-compute.png)

    - Download the private and public keys: **Save Private Key**, **Save Public Key**
    - Click **Create**

    ![Create Compute](./images/create-compute.png)

6. Wait for Compute Instance to finish provisioning, and have status Available (click browser Refresh button).
On the Instance Details page, copy Public IP Address in your notes.

    ![Compute Provisioning](./images/compute-provisioning.png)
    ![Compute Running](./images/compute-running.png)

> **Note**: On the Instance Details page, copy **Public IP address** in your notes.


## Task 3: Provision Oracle Autonomous JSON Database (AJD)

1. **Click** on main menu ≡, then Oracle Database > **Autonomous JSON Database**.

    ![Oracle Console AJD](./images/oracle-console-ajson.png)

2. Click **Create Autonomous Database**.

    ![Create AJD](./images/create-ajson.png)

3. Provide the following information:

    - Compartment: Be sure you have selected the correct one for this workshop purpose. *Root* is the recommended one
    - Display name: **AJDEV**
    ```
    <copy>AJDEV</copy>
    ```
    - Database name: **AJDEV**
    ```
    <copy>AJDEV</copy>
    ```
    - Choose a workload type: JSON
    - Choose a deployment type: Serverless
    - Choose database version: 19c
    - OCPU count: 1
    - Storage (TB): 1 or 0.02 if you are using a Trial account

    ![Creation AJD Dashboard](./images/creation-ajson-dashboard.png)
    ![Creation AJD Dashboard](./images/creation-ajson-dashboard2.png)

4. Under **Create administrator** credentials:

    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    ![Creation AJD Password](./images/creation-ajson-password.png)

5. Under **Choose network access**:

    - Access Type: **Secure access from allowed IPs and VCNs only**

    - IP notation type:**IP Address**
    - Click **Add My IP Address**

    ![Creation AJD Network](./images/creation-ajson-network-new.png)

    - Click **Add access control rule**

    - IP notation type: **IP Address**
    - Values: Type your **DEVM-Public-IP**, you just copy it at the end of the previous task.

    ![Creation AJD Network](./images/creation-ajson-network-public-ip.png)

6. Under **Choose license and Oracle Datavase editiont**:

    - This Database is provisioned with **License included** license type.

    ![Creation AJD License](./images/creation-ajson-license.png)

7. Click **Create Autonomous Database**.

    ![Creation AJD Create](./images/creation-ajson-create.png)

8. Wait for Lifecycle State to become **Available** from Provisioning (click browser Refresh button).

    ![AJD Provisioning](./images/ajson-provisioning.png)
    ![AJD Available](./images/ajson-available.png)

9. Next to the big green box, click **Database connection**.

    ![AJD DB Connection](./images/ajson-db-connection.png)

10. Click **Download wallet**.

    ![Download Wallet](./images/download-wallet.png)

11. Type the following information:

    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    - Confirm Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    - Click **Download**

    You can close this window after the wallet has been downloaded.

    ![Download Wallet Password](./images/download-wallet-password.png)


12. To access to our compute instance, we will use the **cloud shell**, a small linux terminal embedded in the OCI interface. **Click** on the **shell** icon next to the name of the OCI region, on the top right corner of the page.

    ![Cloud Shell](./images/cloud-shell.png)

13. **Drag and drop** the previously saved **private key file** (ssh-key-xxx.key) and **wallet file** (Wallet_AJDEV.zip) into the **cloud shell**. Be sure both files have been completed checking the **green flag**.

    ![Cloud Shell Files](./images/cloud-shell-files.png)

14. You can **verify** if the files have been transferred correctly using the following command:

    ````bash
    <copy>
    ll   
    </copy>
    ````

    ![Cloud Shell Files](./images/ll.png)

15. We will **copy** the files in our **compute machine** in this case in `/home/opc` through the **ssh connections** using the **Public IP**. **Replace** <Public_IP> with your own one, removing <> too. We copied the Public IP when we provisioned the compute instance few tasks back. Execute the following commands:

    ```bash
    <copy>
    chmod 400 <private-key-file-name>.key
    </copy>
    ```

    ```bash
    <copy>
    scp -i <private-key-file-name>.key ./Wallet_AJDEV.zip opc@<Public_IP>:/home/opc
    </copy>
    ```

    ![scp Command](./images/scp-command.png)

    > **Note**: If you are asked: `Are you sure you want to continue connecting (yes/no)?`, please type **yes** to continue.

16. Now we will stablish an **ssh connections** using the **Public IP.** Replace <Public_IP> with your own one, removing <> too. We copied the Public IP when we provisioned the compute instance few tasks back. Execute the following commands:

    ````bash
    <copy>
    ssh -i <private-key-file-name>.key opc@<Public_IP>
    </copy>
    ````

    ![ssh Connection](./images/ssh.png)

17. We will **unzip** the **Wallet** running the following commands:

    ````bash
    <copy>
    unzip Wallet_AJDEV.zip -d Wallet_AJDEV
    </copy>
    ````

    ![ssh Connection](./images/unzip-wallet.png)

18. We will **export** the **paths** using the following commands:

    ````bash
    <copy>
    sed -i 's/?\/network\/admin/\${TNS_ADMIN}/g' Wallet_AJDEV/sqlnet.ora
    export TNS_ADMIN=/home/opc/Wallet_AJDEV
    export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
    export PATH=$PATH:/usr/lib/oracle/21/client64/bin/
    </copy>
    ````

    ![Export Paths Firewall](./images/export-paths-firewall.png)

## Task 4: Prepare Document Store


1. On the Oracle Cloud Infrastructure Console, click **Database actions** next to the big green box. Allow pop-ups from cloud.oracle.com.

    ![DB Actions](./images/db-actions.png)

    If you need to **Sign in** again remember doing it as admin:
    - User: **admin**
    ```
    <copy>admin</copy>
    ```
    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

2. Under the **Administration** section, click on **Database Users**.

    ![DB Actions - Database Users](./images/database-actions-database-users.png)

3. Click **+ Create User**.

    ![DB Actions - Create User](./images/create-user.png)

4. Create the new user using the following information in the **User** tab:

    - User Name: **DEMO**
    ```
    <copy>DEMO</copy>
    ```
    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    - Confirm Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    - Quota on tablespace DATA: **UNLIMITED**
    - Enable **Web Access** and **OML**

    ![DB Actions - Info DEMO User](./images/demo-user-info.png)

4. Change to **Granted Roles** tab. Search by SODA_APP and select **Granted** and **Default**. After click **Create User**.

    ![DB Actions - Info DEMO Granted Roles](./images/granted-roles.png)

    Be sure that the user has been created correctly, exactly like the screenshot.

    ![DB Actions - DEMO User Ready](./images/demo-user-ready.png)

5. Go back to the main menu ≡, then Oracle Database > **Autonomous JSON Database**.

    ![AJD Dashboard](./images/ajson-dashboard.png)

6. On **Tool configuration** tab, next to **Oracle APEX**, click **Copy** link, and open this URL in a new tab in your browser.

    ![Apex](./images/apex.png)

7. **Copy** the URL on your web browser, on **Administration Services** login page, use password for **ADMIN**.

    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    ![Apex ADMIN](./images/apex-admin.png)

8. Click **Create Workspace**.

    ![Apex Workspace](./images/apex-workspace.png)

9. In the **How would you like to create your workspace?** screen, select **Existing Schema**.

    ![Apex Workspace](./images/create-workspace.png)

10. Type the following information:

    - Database User: **DEMO**. Use the search menu to find DEMO and select it. You can't type on this field.
    - Workspace Name: **DEMO**
    ```
    <copy>DEMO</copy>
    ```
    - Workspace Username: **DEMOWS**
    ```
    <copy>DEMOWS</copy>
    ```
    - Workspace Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    - Click **Create Workspace**

    ![Apex Workspace DEMO](./images/create-workspace-info.png)

11. Click **DEMO** in the middle of the page to **Sign in** as **DEMO** user.

    ![Apex Login DEMO](./images/apex-log-in-demo.png)

12. Click **Sign In** Page using the following information:

    - Workspace: **demo**
    ```
    <copy>demo</copy>
    ```
    - Username: **demows**
    ```
    <copy>demows</copy>
    ```
    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    ![Login DEMO](./images/log-in-demo-new.png)

    **Oracle APEX** uses low-code development to let you build data-driven apps quickly without having to learn complex web technologies. This also gives you access to Oracle REST Data Services, that allows developers to readily expose and/or consume RESTful Web Services by defining REST end points.

13. Go again to **Database actions** section if your browser tab has being closed.

    ![DB Actions](./images/db-actions.png)

14. **Sign out** as **ADMIN**.

    ![DB Actions ADMIN sign out](./images/sign-out-admin.png)

15. **Sign in** as **DEMO** user.

    - Username: **demo**
    ```
    <copy>demo</copy>
    ```
    - Password: **DBlearnPTS#22_**

    > **Note**: The password specified in this lab guide is just an example. Always use strong passwords.

    ![DB Actions DEMO sign in](./images/sign-in-demo.png)

    You should be connected now as **DEMO** user, check it on the right top corner side of the page.

    ![DB Actions DEMO](./images/database-actions-demo.png)


16. Click **Development** > **JSON**, and follow the tips. This is the interface you will use to manage your JSON collections in this document store.

    ![DB Actions JSON](./images/db-actions-json.png)

17. We will create a Collection to store JSON documents. Click **Create Collection**.

    ![DB Actions JSON Create Collection](./images/create-collection.png)

18. Provide the following information:

    - Collection Name: **SimpleCollection**
    ```
    <copy>SimpleCollection</copy>
    ```
    - Click **Create**

    ![DB Actions JSON Create Collection](./images/create-simple-collection.png)

    You can see the new Collection under the JSON Collection section page.

    ![DB Actions JSON Create Collection](./images/simple-collection.png)


You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Valentin Leonard Tabacaru, Database Product Management and Priscila Iruela, Technology Product Strategy Director
* **Contributors** - Victor Martin Alvarez, Technology Product Strategy Director
* **Last Updated By/Date** - Priscila Iruela, August 2023