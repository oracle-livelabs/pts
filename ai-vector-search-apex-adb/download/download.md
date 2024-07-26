# Download Embedding Model from Oracle Object Storage into Oracle Autonomous Database

## Introduction

In this lab you will download the embedding model from Oracle Object Storage to Autonomous Database. The embedding model is used to vectorize the source data. Oracle provides data management with the Oracle Object Storage and Oracle Autonomous Database (ADB). One of the features available is the ability to download files directly from Oracle Object Storage into Oracle ADB using the DBMS_CLOUD.GET_OBJECTS procedure.

## Objectives

By following this guide, you will:

- Create a credential object in Oracle ADB for accessing Oracle Object Storage.
- Grant necessary privileges to use DBMS_CLOUD procedures.
- Download the ONNX compliant embedding model from Oracle Object Storage into Oracle ADB using DBMS_CLOUD.GET_OBJECTS.
- Verify the downloaded model in Oracle ADB.
- Load the ONNX model into the database using DBMS_VECTOR.LOAD_ONNX_MODEL.
- Create credential using DBMS_VECTOR to access OCI GenAI service

## Prerequisites

Before we dive into the procedure, make sure you have the following:

1. **Oracle Cloud Account**: You need an active Oracle Cloud account with access to Oracle Object Storage and Oracle Autonomous Database.
2. **Object Storage Bucket**: Create a bucket in Oracle Object Storage and upload the files you want to download into Oracle ADB.
3. **Credentials**: Ensure you have the necessary credentials (access key and secret key) to access Oracle Object Storage.
4. **Oracle Autonomous Database**: Make sure you have an [Oracle Autonomous Database](https://medium.com/@bhenndricks/how-to-create-an-oracle-autonomous-database-c12d9a05096c) instance running.

## Step-by-Step Guide

### 1. Create Credential Object in Oracle ADB

First, create a credential object in your Oracle Autonomous Database that will store your Object Storage credentials. This is required for authenticating with Oracle Object Storage. Please set up your [secret keys](https://medium.com/@bhenndricks/secure-access-to-oracle-buckets-in-object-storage-a-step-by-step-guide-32f3242f35e2) 


Next head back to your ADB overview page we just created, and select Database Actions and then SQL. This will open up an editor for us to perform statements.
![alt text](images/sqldev.png)

Copy this statement and replace with your user and password for Oracle Cloud.

```sql
BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'OBJ_STORE_CRED',
    username => '<your_oci_user_name>',
    password => '<your_oci_passwordy>'
  );
END;
/
```

### 2. Grant Necessary Privileges

Ensure your database user has the necessary privileges to use DBMS_CLOUD procedures.

```sql
GRANT EXECUTE ON DBMS_CLOUD TO <your_database_user>;
```

Replace `<your_database_user>` with your actual database user.

### 3. Download ONNX embedding models Using DBMS_CLOUD.GET_OBJECTS

Now, use the DBMS_CLOUD.GET_OBJECTS procedure to download the ONNX embedding model files from your Oracle Object Storage bucket into Oracle ADB.  You will download two different models.

```sql
CREATE DIRECTORY staging AS 'stage';
```

Make sure your url looks similar to this
```sql
BEGIN
  DBMS_CLOUD.GET_OBJECT(
    credential_name => 'OBJ_STORE_CRED',
    object_uri => 'https://cloud.oracle.com/object-storage/buckets/yourtenancy/your_bucket_name/objects?region=us-phoenix-1',
    directory_name => 'staging',
    file_name => '<file_name_in_adb>'
  );
END;
/
```

Replace the placeholders as follows:
- `<region>`: Your Oracle Cloud region.
- `<namespace>`: Your Oracle Cloud Object Storage namespace.
- `<bucket>`: The name of your Object Storage bucket.
- `<file>`: The name of the file in your Object Storage bucket.
- `<file_name_in_adb>`: The name you want to give the file in Oracle ADB.

For example, if your object URI is 'https://oraclepartnersas.objectstorage.us-ashburn-1.oci.customer-oci.com/p/HP5q2dfCzDstMprLYpR5x0LbhJb_SyxGNgHj985fd8GELKb9j2aLcEwUUpKmV7zW/n/oraclepartnersas/b/onnx/o/tinybert.onnx', and you want to download it to ADB, the command will look like this:

```sql
BEGIN
  DBMS_CLOUD.GET_OBJECT(
    credential_name => 'OBJ_STORE_CRED',
    object_uri => 'https://oraclepartnersas.objectstorage.us-ashburn-1.oci.customer-oci.com/p/HP5q2dfCzDstMprLYpR5x0LbhJb_SyxGNgHj985fd8GELKb9j2aLcEwUUpKmV7zW/n/oraclepartnersas/b/onnx/o/tinybert.onnx',
    directory_name => 'staging',
    file_name => 'tinybert.onnx'
  );
END;
/
```

### 4. Verify the File in Oracle ADB

After downloading the file, you can verify its existence in Oracle ADB by listing the contents of the directory.

```sql
SELECT * FROM TABLE(DBMS_CLOUD.LIST_FILES('staging'));
```

This query will show you the files present in the specified directory, ensuring that your file has been successfully downloaded.

### 5. Load the ONNX Files into the Database

Once the ONNX files are downloaded and verified, you can load them into the database using DBMS_VECTOR.LOAD_ONNX_MODEL. This step involves loading the models from the downloaded files and configuring them for use in Oracle ADB.  

```sql
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
```
This code loads two ONNX models (tinybert.onnx and all-MiniLM-L6-v2.onnx) into the Oracle ADB, making them available as TINYBERT_MODEL and ALL_MINILM_L6V2MODEL respectively. The json configuration specifies how the models should handle input and output data.

By just changing the model from tinybert\_model to All\_MINILM\_L6V2MODEL, you will have different vectors for the same document. Each of the models are designed to search the vectors and get the best match according to their algorithms.  Tinybert has 128 dimensions while all-MiniL2-v2 has 384 dimensions.  Usually, the greater the number of dimensions, the higher the quality of the vector embeddings.  A larger number of vector dimensions also tends to result in slower performance.   You should choose an embedding model based on quality first and then consider the size and performance of the vector embedding model.  You may choose to use larger vectors for use cases where accuracy is paramount and smaller vectors where performance is the most important factor.

To verify the model exists in database run the following statement.

```sql
    SELECT MODEL_NAME, MINING_FUNCTION,
    ALGORITHM, ALGORITHM_TYPE, round(MODEL_SIZE/1024/1024) MB FROM user_mining_models; 
    
```

### 6. Create the credentials for ADB to access OCI GenAI service

Oracle's GenAI service is an LLM service from Oracle Cloud Infrastructure (OCI). The GenAI service provides access to several LLMs that you can pick from.  To enable ADB to access these services, authentication is required. 

1. From ADB Database Actions SQL Worksheet, enter the PLSQL procedure and replace the following with your ocid and key information you got from the previous lab.  Then click run to set the ADB credential to access the OCI GenAI service.

```
declare
  jo json_object_t;
begin
  dbms_vector.drop_credential('GENAI_CRED');
  jo := json_object_t();
  jo.put('user_ocid','ocid1.user.oc1..aabbalbbaa1112233aabb...');
  jo.put('tenancy_ocid','ocid1.tenancy.oc1..aaaaalbbbb1112233aaaab...');
  jo.put('compartment_ocid','ocid1.compartment.oc1..ababalabab1112233ababa...');
  jo.put('private_key','AAAaaaBBB11112222333...AAA111AAABBB222aaa1a...');
  jo.put('fingerprint','01:1a:a1:aa:12:a1:12:1a:ab:12:01:ab:...');
  dbms_vector.create_credential(
    credential_name   => 'GENAI_CRED',
    params            => json(jo.to_string));
end;
/

```

## Conclusion

Downloading files from Oracle Object Storage into Oracle Autonomous Database using DBMS_CLOUD.GET_OBJECTS is a straightforward process. Once your files are downloaded, you can upload the files, in this case the ONNX models, into Autonomous Database to embed the source data to vectors.
