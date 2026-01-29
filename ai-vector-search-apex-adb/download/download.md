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

## Task 4: Grant Necessary Privileges

From ADMIN user, run the following to ensure your database user has the necessary privileges to use DBMS packages. We are using the user VECTOR when creating the schema objects.  If you use a different user, be sure to use the correct schema user during table creation in the subsequent lab.

```sql
<copy>
CREATE USER VECTOR identified by <password>;
GRANT CONNECT to VECTOR;
ALTER USER VECTOR QUOTA UNLIMITED ON DATA;
GRANT CREATE SESSION to VECTOR;
GRANT RESOURCE to VECTOR;
GRANT DB_DEVELOPER_ROLE to VECTOR;
GRANT EXECUTE ON DBMS_CLOUD TO VECTOR;
GRANT EXECUTE ON DBMS_VECTOR TO VECTOR;
GRANT EXECUTE ON DBMS_VECTOR_CHAIN TO VECTOR;
GRANT CREATE ANY DIRECTORY TO VECTOR;
GRANT EXECUTE ON DBMS_CLOUD_AI TO VECTOR;
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


Last, but not least, we need to create an ACL for making sure that package DBMS_VECTOR_CHAIN (which does a direct callout to internet from PL/SQL without going through APEX webservices packages) works as intended. You can run this as admin:

```sql
<copy>
BEGIN

    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host => 'specific_host_or_ip', -- Restrict to a specific host or IP range so it is not wide open. You can use '*' if you want it open to any connection. 
        ace => xs$ace_type(privilege_list => xs$name_list('http'),
                           principal_name => 'specific_user_or_role', -- Restrict to a specific user or role. For example, "Public"
                           principal_type => xs_acl.ptype_db)
    );

END;

/
</copy>
```

## Task 5: Option 1 - Create the credential for ADB to access OCI GenAI Service

### OCI GenAI Service

The OCI GenAI service provides access to several LLMs including Cohere and Llama.  
API authentication is required.

1. From ADB Database Actions SQL Worksheet or SQL Developer, login as VECTOR user and copy and run the SQL below and replace the following with your ocid and key information you got from the previous lab.

Important Note: Open your private key and copy the private key all onto a single line.

```sql
<copy>
declare
  jo json_object_t;
begin
  jo := json_object_t();
  jo.put('user_ocid','<your ocid1.user goes here>');
  jo.put('tenancy_ocid','<your ocid1.tenancy goes here>');
  jo.put('compartment_ocid','<your compartment ocid1.compartment goes here>');
  jo.put('private_key','<your API private key goes here>');
  jo.put('fingerprint','<your fingerprint goes here>');
  dbms_vector.create_credential(
    credential_name   => 'GENAI_CRED',
    params            => json(jo.to_string));
end;
/
</copy>
```

For example:

```
declare
 jo json_object_t;
begin
 jo := json_object_t();
 jo.put('user_ocid','ocid1.user.oc1..aaaaaaaawfpzqgzsrvb4mh6hcld2hrckadyae5y...cvza');
 jo.put('tenancy_ocid','ocid1.tenancy.oc1..aaaaaaaafj37mytx22oquorcznlfuh77...zrq');
 jo.put('compartment_ocid','ocid1.compartment.oc1..aaaaaaaaqdp7dblf6tb3gpzbuknvgfgkedtio...yfa');
 jo.put('private_key','MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCP1QXxJxzVj4SXozdfrfIr...A4Iw=');
 jo.put('fingerprint','e3:e5:ab:61:99:51:29:1f:60:2a:ad...5b:a5');
 dbms_vector.create_credential(
 credential_name => 'GENAI_CRED',
 params => json(jo.to_string));
end;
/
```


## Task 5: Option 2 - Create the credential for ADB to access OpenAI


### OpenAI

For OpenAI, run the following procedure:

```sql
<copy>

declare
  jo json_object_t;
begin
  jo := json_object_t();
  jo.put('access_token', '<your OpenAI API key goes here>');
  dbms_vector.create_credential(
    credential_name   => 'OPENAI_CRED',
    params            => json(jo.to_string));
end;
/
</copy>
```


## Task 6: Download ONNX embedding models Using `DBMS_CLOUD.GET_OBJECTS`

Now log in as VECTOR or `<your_database_user>`, use the `DBMS_CLOUD.GET_OBJECTS` procedure to download the ONNX embedding model files from the Oracle Object Storage bucket into Oracle ADB.  You will download two different models.

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

Run to create the staging directory.

```sql
<copy>
CREATE DIRECTORY staging AS 'stage';
</copy>
```

Run to get the onnx models.

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

For example, to get tinybert.onnx and download it to ADB, the command will look like this:

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

By just changing the model from tinybert\_model to All\_MINILM\_L6V2MODEL, you will have different vectors for the same document. Each of the models are designed to search the vectors and get the best match according to their algorithms.  Tinybert has 128 dimensions while all-MiniL2-v2 has 384 dimensions.  Usually, the greater the number of dimensions, the higher the quality of the vector embeddings.  A larger number of vector dimensions also tends to result in slower performance.   You should choose an embedding model based on quality first and then consider the size and performance of the vector embedding model.  You may choose to use larger vectors for use cases where accuracy is paramount and smaller vectors where performance is the most important factor.

By just changing the model from tinybert\_model to All\_MINILM\_L6V2MODEL, you will have different vectors for the same document. Each of the models are designed to search the vectors and get the best match according to their algorithms.  Tinybert has 128 dimensions while all-MiniL2-v2 has 384 dimensions.  Usually, the greater the number of dimensions, the higher the quality of the vector embeddings.  A larger number of vector dimensions also tends to result in slower performance.   You should choose an embedding model based on quality first and then consider the size and performance of the vector embedding model.  You may choose to use larger vectors for use cases where accuracy is paramount and smaller vectors where performance is the most important factor.


## Task 7: Verify the File in Oracle ADB


After downloading the file, you can verify its existence in Oracle ADB by listing the contents of the directory.

```sql
<copy>
SELECT * FROM TABLE(DBMS_CLOUD.LIST_FILES('staging'));
</copy>
```

This query will show you the files present in the specified directory, ensuring that your file has been successfully downloaded.

## Task 9: Verify Model exists in the Database
## Task 8: Load the ONNX Files into the Database

Once the ONNX files are downloaded and verified, you can load them into the database using DBMS\_VECTOR.LOAD\_ONNX\_MODEL. This step involves loading the models from the downloaded files and configuring them for use in Oracle ADB.  

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

This code loads two ONNX models (tinybert.onnx and all-MiniLM-L6-v2.onnx) into the Oracle ADB, making them available as TINYBERT\_MODEL and ALL\_MINILM\_L6V2MODEL respectively. The json configuration specifies how the models should handle input and output data.

By just changing the model from tinybert\_model to All\_MINILM\_L6V2MODEL, you will have different vectors for the same document. Each of the models are designed to search the vectors and get the best match according to their algorithms.  Tinybert has 128 dimensions while all-MiniL2-v2 has 384 dimensions.  Usually, the greater the number of dimensions, the higher the quality of the vector embeddings.  A larger number of vector dimensions also tends to result in slower performance.   You should choose an embedding model based on quality first and then consider the size and performance of the vector embedding model.  You may choose to use larger vectors for use cases where accuracy is paramount and smaller vectors where performance is the most important factor.

To verify the model exists in database run the following statement.

```sql
<copy>
    SELECT MODEL_NAME, MINING_FUNCTION,
    ALGORITHM, ALGORITHM_TYPE, round(MODEL_SIZE/1024/1024) MB FROM user_mining_models; 
</copy>
```


## Summary

In this lab we granted privileges to your database user to run the needed PLSQL procedures and functions. We created objects to authenticate to LLM services.  We also downloaded embedding models from Oracle Object Storage using DBMS\_CLOUD.GET\_OBJECTS and loaded them into Oracle AI Database 26ai with DBMS\_VECTOR.LOAD\_ONNX\_MODEL.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Authors** - Blake Hendricks, Vijay Balebail, Milton Wan
* **Last Updated By/Date** -  Blake Hendricks, June 2025
* **Last Updated By/Date** -  Andrei Manoliu, October 2025
