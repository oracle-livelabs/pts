# Download Embedding Model from Oracle Object Storage into Oracle Autonomous Database

## Introduction

In this lab you will download the embedding model from Oracle Object Storage to Autonomous Database. The embedding model is used to vectorize the source data. Oracle provides data management with the Oracle Object Storage and Oracle Autonomous Database (ADB). One of the features available is the ability to download files directly from Oracle Object Storage into Oracle ADB using the DBMS\_CLOUD.GET\_OBJECTS procedure.

Estimated Time: 10 minutes

## Objectives

By following this guide, you will:

* Create a credential object in Oracle ADB for accessing Oracle Object Storage.
* Grant necessary privileges to use DBMS\_CLOUD procedures.
* Download the ONNX compliant embedding model from Oracle Object Storage into Oracle ADB using DBMS\_CLOUD.GET\_OBJECTS.
* Verify the downloaded model in Oracle ADB.
* Load the ONNX model into the database using DBMS\_VECTOR.LOAD\_ONNX\_MODEL.
* Create credential using DBMS\_VECTOR to access OCI GenAI service

## Prerequisites

Before we dive into the procedure, make sure you have the following:

1. **Oracle Cloud Account**: You need an active Oracle Cloud account with access to Oracle Object Storage and Oracle Autonomous Database.
2. **Object Storage Bucket**: Create a bucket in Oracle Object Storage and upload the files you want to download into Oracle ADB.
3. **Credentials**: Ensure you have the necessary credentials (access key and secret key) to access Oracle Object Storage.
4. **Oracle AI Database 26ai**: Make sure you have an Oracle AI Database 26ai

## Task 1: Login to Oracle Cloud

1. From your browser login into Oracle Cloud

## Task 2: Provision ADW

   Provision the Autonomous Data Warehouse Databasewith the steps below.

1. Select your assigned Region from the upper right of the OCI console.

2. From the hamburger menu (top left side), select Oracle AI Database and chose Autonomous AI Database.
![alt text](images/createadw4.png)

3. Select your Compartment. You may have to drill in (click "+") to see your compartment.

4. Click Create Autonomous AI Database.
  ![alt text](images/createadw1.png)

5. Enter any unique name (maybe your name) for your display and database name.
   The display name is used in the  Console UI to identify your database.
  ![alt text](images/createadw2.png)

6. Ensure Transaction Processing workload type is selected.

7. Choose database version 26ai.

8. Configure the database with **2 cores and 1 TB storage**.

9. Check Auto scaling.

10. Enter a password. The username is always ADMIN. (Note: remember your password)

11. Select Allow secure access from everywhere for this workshop.  
    As a best practice when you deploy your own application, you should select network access to be from Virtual cloud network.  
  ![alt text](images/createadw3.png)

12. Click Create.


    Your console will show that ADW is provisioning. This will take about 2 or 3 minutes to complete.

    You can check the status of the provisioning in the Work Request.

## Task 3: Create Credential Object in Oracle ADB

1. First, create a credential object in your Oracle Autonomous Database that will store your Object Storage credentials. This is required for authenticating with Oracle Object Storage.

Next head back to your ADB console, and select Database Actions and then SQL. Log in as ADMIN. This will open up an editor for us to perform statements.
![alt text](images/sqldev.png)

Copy this statement and replace with your username and password for Oracle Cloud.

```sql
<copy>
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'OBJ_STORE_CRED',
    username => '<your_oci_user_name>',
    password => '<your_oci_password>'
  );
END;
/
</copy>
```

## Task 4: Grant Necessary Privileges and Create VECTOR User

From ADMIN user, run the following to create the VECTOR user and ensure it has the necessary privileges to use DBMS packages:

```sql
<copy>
-- Create VECTOR user
CREATE USER VECTOR IDENTIFIED BY <password>;
GRANT CONNECT TO VECTOR;
ALTER USER VECTOR QUOTA UNLIMITED ON DATA;
GRANT CREATE SESSION TO VECTOR;
GRANT RESOURCE TO VECTOR;
GRANT DB_DEVELOPER_ROLE TO VECTOR;
GRANT CREATE MINING MODEL TO VECTOR;

-- Resource Principal must be enabled for Object Storage access
EXEC DBMS_CLOUD_ADMIN.ENABLE_RESOURCE_PRINCIPAL('VECTOR');

-- Correct schema references for ADB
GRANT EXECUTE ON C##CLOUD$SERVICE.DBMS_CLOUD TO VECTOR;
GRANT EXECUTE ON SYS.DBMS_VECTOR TO VECTOR;
GRANT EXECUTE ON CTXSYS.DBMS_VECTOR_CHAIN TO VECTOR;
GRANT EXECUTE ON DBMS_CLOUD_AI TO VECTOR;

-- Directory access for file operations
GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO VECTOR;

-- Additional DBMS_CLOUD packages for Object Storage
GRANT EXECUTE ON DBMS_CLOUD_OCI_OBS_OBJECT TO VECTOR;
GRANT EXECUTE ON DBMS_CLOUD_OCI_OBS_BUCKET TO VECTOR;

-- Network ACL for external API access (if using external LLM services)
BEGIN
  DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
    host => '*',
    ace => xs$ace_type(
      privilege_list => xs$name_list('connect'),
      principal_name => 'VECTOR',
      principal_type => xs_acl.ptype_db
    )
  );
END;
/
</copy>
```

Enable the Rest Access for the Vector User:

```sql
<copy>
-- REST ENABLE
BEGIN
    ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'VECTOR',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'vector',
        p_auto_rest_auth=> FALSE
    );
    -- ENABLE DATA SHARING
    C##ADP$SERVICE.DBMS_SHARE.ENABLE_SCHEMA(
            SCHEMA_NAME => 'VECTOR',
            ENABLED => TRUE
    );
    commit;
END;
/
</copy>
```

Create an ACL for making sure that package DBMS_VECTOR_CHAIN works as intended:

```sql
<copy>
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host => '*',
        ace => xs$ace_type(
          privilege_list => xs$name_list('connect'),
          principal_name => 'VECTOR',
          principal_type => xs_acl.ptype_db
        )
    );
END;
/
</copy>
```

## Task 5: Option 1 - Create the credential for ADB to access OCI GenAI Service

### OCI GenAI Service

The OCI GenAI service provides access to several LLMs including Cohere and Llama. API authentication is required.

1. From ADB Database Actions SQL Worksheet, login as VECTOR user and run the SQL below. Replace the following with your OCI information you obtained from Lab 0:

   * `<your ocid1.user goes here>` - Your User OCID
   * `<your ocid1.tenancy goes here>` - Your Tenancy OCID
   * `<your compartment ocid1.compartment goes here>` - Your Compartment OCID
   * `<your API private key goes here>` - Your private key (Important: entire key on one line)
   * `<your fingerprint goes here>` - Your fingerprint

**Important Note:** Put the private key all on a single line with no line breaks.

```sql
<copy>
DECLARE
  jo json_object_t;
BEGIN
  jo := json_object_t();
  jo.put('user_ocid','<your ocid1.user goes here>');
  jo.put('tenancy_ocid','<your ocid1.tenancy goes here>');
  jo.put('compartment_ocid','<your compartment ocid1.compartment goes here>');
  jo.put('private_key','<your API private key goes here>');
  jo.put('fingerprint','<your fingerprint goes here>');
  
  dbms_vector.create_credential(
    credential_name => 'OCI_CRED',
    params          => json(jo.to_string)
  );
END;
/
</copy>
```

For example:

```
DECLARE
  jo json_object_t;
BEGIN
  jo := json_object_t();
  jo.put('user_ocid','ocid1.user.oc1..aaaaaaaawfpzqgzsrvb4mh6hcld2hrckadyae5y...cvza');
  jo.put('tenancy_ocid','ocid1.tenancy.oc1..aaaaaaaafj37mytx22oquorcznlfuh77...zrq');
  jo.put('compartment_ocid','ocid1.compartment.oc1..aaaaaaaaqdp7dblf6tb3gpzbuknvgfgkedtio...yfa');
  jo.put('private_key','MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCP1QXxJxzVj4SXozdfrfIr...A4Iw=');
  jo.put('fingerprint','e3:e5:ab:61:99:51:29:1f:60:2a:ad...5b:a5');
  
  dbms_vector.create_credential(
    credential_name => 'OCI_CRED',
    params          => json(jo.to_string)
  );
END;
/
```


## Task 5: Option 2 - Create the credential for ADB to access OpenAI


### OpenAI

For OpenAI, run the following procedure:

```sql
<copy>
DECLARE
  jo json_object_t;
BEGIN
  jo := json_object_t();
  jo.put('access_token', '<your OpenAI API key goes here>');
  
  dbms_vector.create_credential(
    credential_name   => 'OPENAI_CRED',
    params            => json(jo.to_string)
  );
END;
/
</copy>
```


## Task 6: Download ONNX embedding models Using `DBMS_CLOUD.GET_OBJECTS`

Now log in as VECTOR user, use the `DBMS_CLOUD.GET_OBJECTS` procedure to download the ONNX embedding model files from the Oracle Object Storage bucket into Oracle ADB.

```sql
<copy>
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'OBJ_STORE_CRED',
    username => '<your_oci_user_name>',
    password => '<your_oci_password>'
  );
END;
/
</copy>
```

Create the staging directory:

```sql
<copy>
CREATE DIRECTORY staging AS 'stage';
</copy>
```

Download the ONNX models:

```sql
<copy>
BEGIN
  DBMS_CLOUD.GET_OBJECT(
    credential_name => 'OBJ_STORE_CRED',
    object_uri => '<URL to onnx model>',
    directory_name => 'staging',
    file_name => '<file_name_in_adb>'
  );
END;
/
</copy>
```

URL to all-MiniLM-L6-v2.onnx is:
<https://objectstorage.us-phoenix-1.oraclecloud.com/p/0RzlHqjY36-DSHZeYl9XovR9MxrvvCWIsx0-yp95d--Re-93qY4HHl7BVWFQBiJu/n/oraclepartnersas/b/huggingface-models/o/all-MiniLM-L6-v2.onnx>

URL to tinybert.onnx is:
<https://objectstorage.us-phoenix-1.oraclecloud.com/p/aQ46zsq4mIUySbYW9klMXIxuMrTzBYAUQtH4aXKmsZxTkp5Hy1vhTCbXlyUaxbpg/n/oraclepartnersas/b/huggingface-models/o/tinybert.onnx>

For example, to get tinybert.onnx and download it to ADB:

```sql
<copy>
BEGIN
  DBMS_CLOUD.GET_OBJECT(
    credential_name => 'OBJ_STORE_CRED',
    object_uri => 'https://objectstorage.us-phoenix-1.oraclecloud.com/p/bUxqKjZhI2qvtRK624QITVHb2vl4wquaSzaYQe7wf21KqV2Rr7EBwRjaeUFnH-AQ/n/oraclepartnersas/b/huggingface-models/o/tinybert.onnx',
    directory_name => 'staging',
    file_name => 'tinybert.onnx'
  );
END;
/
</copy>
```

By choosing different embedding models, you will have different vectors for the same document. Tinybert has 128 dimensions while all-MiniLM-L6-v2 has 384 dimensions. Usually, the greater the number of dimensions, the higher the quality of the vector embeddings, but this results in slower performance. Choose an embedding model based on your quality and performance requirements.

## Task 7: Verify the File in Oracle ADB


After downloading the file, verify its existence in Oracle ADB by listing the contents of the directory:

```sql
<copy>
SELECT * FROM TABLE(DBMS_CLOUD.LIST_FILES('staging'));
</copy>
```

This query will show you the files present in the specified directory, ensuring that your file has been successfully downloaded.

## Task 8: Load the ONNX Files into the Database

Once the ONNX files are downloaded and verified, load them into the database using DBMS\_VECTOR.LOAD\_ONNX\_MODEL:

```sql
<copy>
BEGIN
  DBMS_VECTOR.LOAD_ONNX_MODEL(
    'staging',
    'tinybert.onnx',
    'TINYBERT_MODEL',
    json('{"function":"embedding","embeddingOutput":"embedding","input":{"input":["DATA"]}}')
  );

  DBMS_VECTOR.LOAD_ONNX_MODEL(
    'staging',
    'all-MiniLM-L6-v2.onnx',
    'ALL_MINILM_L6V2MODEL',
    json('{"function":"embedding","input":{"input":["DATA"]}}')
  );
END;
/
</copy>
```

This code loads two ONNX models into Oracle ADB, making them available as TINYBERT\_MODEL and ALL\_MINILM\_L6V2MODEL respectively. The JSON configuration specifies how the models should handle input and output data.

## Task 9: Verify Model exists in the Database

Verify the model exists in database by running:

```sql
<copy>
SELECT MODEL_NAME, MINING_FUNCTION,
       ALGORITHM, ALGORITHM_TYPE, round(MODEL_SIZE/1024/1024) MB 
FROM user_mining_models;
</copy>
```


## Summary

In this lab we granted privileges to your database user to run the needed PLSQL procedures and functions. We created objects to authenticate to LLM services. We also downloaded embedding models from Oracle Object Storage using DBMS\_CLOUD.GET\_OBJECTS and loaded them into Oracle AI Database 26ai with DBMS\_VECTOR.LOAD\_ONNX\_MODEL.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Authors** - Blake Hendricks, Vijay Balebail, Milton Wan
* **Last Updated By/Date** -  Blake Hendricks, June 2025
* **Last Updated By/Date** -  Andrei Manoliu, October 2025
