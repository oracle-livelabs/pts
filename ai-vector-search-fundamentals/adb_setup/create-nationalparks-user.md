# Create and Enable a Database User in Database Actions

## Introduction

This lab walks you through the steps to get started with Database Actions. You will create the NATIONALPARKS user and provide that user the access to run the Getting Started with AI Vector Search lab. You will then load the ONNX models, create the NATIONALPARKS schema, and then setup up the APEX demo that will be used in the last lab.

Estimated time: 10 minutes

### Objectives

- Learn how to setup the required database roles in Database Actions.
- Learn how to create a database user in Database Actions.
- Load the ONNX embedding models
- Import the NATIONALPARKS schema
- Import the APEX workspace and application

### Prerequisites

- Oracle Cloud account
- Provisioned Autonomous Database


## Task 1: Login to Database Actions

Although you can connect to your Oracle Autonomous Database using desktop tools like Oracle SQL Developer, you can conveniently access the browser-based SQL Worksheet directly from your Autonomous Database console.

1. If you are not logged in to the Oracle Cloud Console, log in and select **Oracle Database** from the navigation menu and then **Autonomous Database** from the **Overview** column, make sure you are in the right compartment where your ADB is provisioned, and select your database display name, **[](var:db_display_name)** if you used the recommended name in the Create an Autonomous Database lab, in the **Display name** column.

    ![Oracle Home page left navigation menu.](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/oci-navigation-adb.png " ")


    ![Autonomous Databases homepage.](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/oci-adb-list-with-db.png " ")

2. In your ADB database's details page, click the **Database Actions** button and then choose the **View all database actions** option.

    ![Click Database Actions button.](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/adb-dbactions-goto.png " ")

    Logging in from the OCI service console expects that you are the ADMIN user. Log in as ADMIN, or your admin user, if you are not automatically logged in.

3. The Database Actions page opens. In the **Development** box, click **SQL**.

    ![Click SQL.](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/adb-dbactions-click-sql.png " ")

4.  The first time you open SQL Worksheet, a series of pop-up informational boxes may appear, providing you a tour that introduces the main features. If not, click the Tour button (labeled with binoculars symbol) in the upper right corner. Click **Next** to take a tour through the informational boxes.

    ![SQL Worksheet.](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/adb-sql-worksheet-opening-tour.png " ")

## Task 2: Create a database user

Now create the **NATIONALPARKS** user and provide Database Actions access for this user.

When you create a new Autonomous Database, you automatically get an account called ADMIN that is your super administrator user. In this task we will need to create a separate new user for the lab. This section will guide you through this process using the "New User" wizard within the Database Actions set of tools.

1. Navigate to the Details page of the Autonomous Database you previously provisioned. In this example, the database name is **[](var:db_name)**, but yours may be different depending on what name you chose. Click the **Database Actions -> Database Users** button.

    ![Click Database Actions](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/goto-database-users-from-console.png "Click Database Actions")

  You will automatically be logged in as the ADMIN user, or you may be prompted to provide the username and password of the administrator you specified when you created the Autonomous Database instance.

2.  You can see that your ADMIN user appears as the current user. And, several other system users may already exist. On the right-hand side, click the **+ Create User** button.

    ![Create User button highlighted on the Database Users page](https://oracle-livelabs.github.io/common/building-blocks/tasks/adb/images/db-actions-click-create-user.png " ")

4. The **Create User** form will appear on the right-hand side of your browser window. Use the settings below to complete the form:

- User Name: **NATIONALPARKS**
- Password:  **Welcome_12345**
- Quota on tablespace DATA: UNLIMITED

- Leave the **Password Expired** toggle button as off (Note: this controls whether the user is prompted to change their password when they next log in).
- Leave the **Account is Locked** toggle button as off. 

- Leave the **Graph** toggle button as off.
- Toggle the **Web Access** button to **On**.
- Leave the **OML** button as off.
- Toggle the **REST, GraphQL, MondoDB, and Web access** button to **On**.

- Click **Create User** at the bottom of the form.

    ![The Create User dialog](images/adb_user_create.png " ")

## Task 3: Grant database privileges

1. Switch back to the **SQL | Oracle Database Actions** window.

  ![SQL worksheet](images/sql_admin_worksheet.png)

2. Proceed with **Grant privileges** by copying and pasting the following into the Database Actions SQL window:

    ```sql
    <copy>
    -- ADD ROLES
    GRANT CONNECT TO NATIONALPARKS;
    GRANT RESOURCE TO NATIONALPARKS;


    -- REST ENABLE
    BEGIN
      ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'NATIONALPARKS',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'nationalparks',
        p_auto_rest_auth=> TRUE
      );
      -- ENABLE DATA SHARING
      C##ADP$SERVICE.DBMS_SHARE.ENABLE_SCHEMA(
        SCHEMA_NAME => 'NATIONALPARKS',
        ENABLED => TRUE
      );
      commit;
    END;
    /

    -- QUOTA
    GRANT ORDS_RUNTIME_ROLE TO nationalparks;
    GRANT EXECUTE ON dbms_cloud TO nationalparks;
    GRANT EXECUTE ON dbms_cloud_ai TO nationalparks;
    GRANT EXECUTE ON dbms_vector TO nationalparks;
    GRANT EXECUTE ON DBMS_NETWORK_ACL_ADMIN TO nationalparks;
    GRANT READ,WRITE ON directory data_pump_dir TO nationalparks;
    GRANT CREATE mining model TO nationalparks;
    GRANT SELECT ON sys.v_$vector_memory_pool TO nationalparks;
    GRANT SELECT ON sys.v_$vector_index TO nationalparks;
    </copy>
    ```

    **Note:** Run the entire script by clicking on the "Run Script" button.

    ![grant privileges](images/grant_privileges.png " ")

3. Confirm that you can login with the new user.

  This will require that you log out of the ADMIN user, click on the down error next to the ADMIN user name at the top right of the screen and click "Sign Out". You should then sign in as the NATIONALPARKS user with the password of "Welcome_12345".

  ![NATIONALPARKS](images/nationalparks_login.png)

  For details, see the ["Create Users on Autonomous Database with Database Actions"](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/adbsb/manage-users-create.html#GUID-DD0D847B-0283-47F5-9EF3-D8252084F0C1) section in the documentation.

## Task 4: Import ONNX Models

1. Now that you are logged in as the NATIONALPARKS user bring up a Database Actions SQL worksheet. You can do this by selecting the **Development** tab and the **SQL** option from the pop-up menu or navigate to the main menu in the upper left corner of the screen and choose **SQL** from the **</> Development** menu.

  ![sqldev browser](images/sql_np_worksheet.png " ")

2. Copy the ONNX models to the DATA\_PUMP\_DIR directory and load into the database by copying the script below, paste it into the Database Actions SQL window and then click on the "Run Script" button:

    ```sql
    <copy>
    begin
      dbms_cloud.get_object(
        object_uri=>'https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/all_MiniLM_L12_v2.onnx',
        directory_name=>'DATA_PUMP_DIR',
        file_name=>'all_MiniLM_L12_v2.onnx'
      );
    end;
    /
    begin
      dbms_cloud.get_object(
        object_uri=>'https://objectstorage.us-ashburn-1.oraclecloud.com/p/Fi6_7TWwA2VkaSHTl76t2TiSUkdAfL7C8aR_3S_WIPMGth0XWXyPDzutxTD63oAk/n/oradbclouducm/b/bucket-vector/o/Sample_Employee_Handbook.pdf',
        directory_name=>'DATA_PUMP_DIR',
        file_name=>'Sample_Employee_Handbook.pdf'
      );
    end;
    /
    </copy>
    ```

  ![import onnx files](images/import_onnx.png " ")

## Task 5: Import Tables into NATIONALPARKS schema

1. As the NATIONALPARKS user you will import the NATIONALPARKS schema in the next step.

2. Import the NATIONALPARKS tables by copying the script below and pasting it into the Database Actions SQL window and click run script:

    ```sql
    <copy>
    DECLARE
      l_job_state      VARCHAR2(1000);
      l_job_handle     NUMBER;
      dumpFile         VARCHAR2(1024)  := 'https://objectstorage.us-ashburn-1.oraclecloud.com/p/_ixVvYet-j7csDKdAgh-E70r1LKw9GYLWZEPkcAzjOklSmvl9KlFOIEFKOIZOIgo/n/oradbclouducm/b/bucket-vector/o/natparks2.dmp';
      logFile          VARCHAR2(1024)  := 'natparks2_imp.log';
      logDir           VARCHAR2(20)     := 'DATA_PUMP_DIR';
      objStor_uri      VARCHAR2(1024)  := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/oradbclouducm/b/bucket-vector/o/';
      logType          NUMBER          := dbms_datapump.ku$_file_type_log_file;
    BEGIN
      l_job_handle := DBMS_DATAPUMP.OPEN(OPERATION=>'IMPORT', JOB_MODE=>'FULL', JOB_NAME=>'IMP_DP_1', VERSION => 'LATEST');
      DBMS_DATAPUMP.ADD_FILE(HANDLE => l_job_handle, FILENAME => dumpFile, DIRECTORY => logDir);
      DBMS_DATAPUMP.ADD_FILE(HANDLE => l_job_handle, FILENAME => logFile, DIRECTORY => logDir, FILETYPE => logType);
      DBMS_DATAPUMP.START_JOB(HANDLE => l_job_handle, SKIP_CURRENT => 0, ABORT_STEP => 0);
      DBMS_DATAPUMP.WAIT_FOR_JOB(HANDLE => l_job_handle, JOB_STATE => l_job_state);
      DBMS_DATAPUMP.DETACH(HANDLE => l_job_handle);
    END;
    /
    </copy>
    ```

## Task 6: Import APEX Demo Workspace and Application

1. Go to the ADB page and click on the Developers Tools icon at the top of the page and select "Cloud Shell" to create a cloud shell environment.

    ![create cloudshell](images/cloudshell_selection.png)

    You can expand the cloudshell window by clicking on the slanted double arrows if you want to make the window bigger.

    ![expand cloudshell](images/create_cloudshell.png)

2. Copy the APEX workspace and application files from object storage to the local directory:

    ```
    <copy>
    wget https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/apex_workspace.sql
    wget https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/apex_natparks_demo.sql
    wget https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles/apex_benny_benefits.sql
    </copy>
    ```
  ![copy apex files](images/copy_apex_files.png)

3. Create a wallet zip file and unzip for TNS connection to the database:

    ```
    oci db autonomous-database generate-wallet --autonomous-database-id <Insert your OCID here> --file adb.zip --password  Welcome_12345
    ```

    Don't forget that you have to insert your OCID for the autonomous-database-id above.
    The OCID can be obtained from the ADB General Information section in the ADB page:

    ![create wallet](images/create_wallet_file.png)
    
    You can then unzip your zip file to get the tnsnames.ora file.

    ```
    <copy>
    unzip adb.zip
    </copy>
    ```

    ![unzip wallet](images/unzip_wallet.png)

    You can list the tnsnames.ora file for the TNS alias' available. You should be able to use the "**trainingdatabase**\_low" TNS alias to connect to the database with SQLcl in the next step if you followed our naming guidelines. Otherwise use the one that fits the name you chose.

    ![list tnsnames](images/list_tnsnames.png)

4. Connect to SQLcl with the ADMIN user using the TNS string from the tnsnames.ora file created in the previous step:

    ```
    sql ADMIN/Training4ADW@<insert your TNS alias here>
    -- Use this to prevent getting a remote server error message.
    BEGIN
       -- first set the workspace
       apex_util.set_workspace(p_workspace => 'NATIONALPARKS');
    
        apex_application_install.set_remote_server(
            p_static_id => 'oci_gen_ai',
            p_base_url => 'https://inference.generativeai.us-chicago-1.oci.oraclecloud.com');
    END;
    /
    @apex_workspace.sql
    @apex_natparks_demo.sql
    @apex_benny_benefits.sql
    BEGIN
       -- This is required to set the OCIDs for the new environment
       -- so that the GenAI access will work
       
       -- first set the workspace
       apex_util.set_workspace(p_workspace => 'NATIONALPARKS');
    
      -- set_persistent_credentials for "credentials_for_oci_gen_ai"
      -- p_credential_static_id = Static ID
      -- p_client_id = OCI User ID
      -- p_client_secret = OCI Private Key
      -- p_namespace = OCI Tenancy OCID
      -- p_fingerprint = OCI Public Key Fingerprint
      --
      apex_credential.set_persistent_credentials (
          p_credential_static_id => 'credentials_for_oci_gen_ai',
          p_client_id => 'ocid1.user.oc1..  ',
          p_client_secret => '  ',
         p_namespace => 'ocid1.tenancy.oc1..  ',
         p_fingerprint => '  ' );
    END;
    /
    ```

    ![run sqlcl](images/run_sqlcl.png)


You may now **proceed to the next lab**

## Acknowledgements

- **Author** - Andy Rivenes, Product Manager, AI Vector Search
- **Contributors** - David Start
- **Last Updated By/Date** - Andy Rivenes, Product Manager, AI Vector Search, February 2026
