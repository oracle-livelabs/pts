# APEX Application Setup

## Introduction

Set up the APEX application to interact with Oracle Cloud Infrastructure (OCI) data sources. This lab will walk you through the process of setting up web credentials, configuring REST data sources, and updating application definitions.

## Objectives

By following this guide, you will:

- Insert OCI credentials.
- Set up REST data sources to connect with OCI.
- Update application definitions and substitutions for proper configuration.

## Step-by-Step Guide

### Step 1: Insert OCI Credentials in APEX

1. Go to the APEX application, click **App Builder**, and then **Workspace Utilities**.
![alt text](images/editworkspaceutil.png)
2. Click **Web Credentials** and then **OCI API Access**.
![alt text](images/editwebcredentials.png)
![alt text](images/editociaccess.png)
3. Replace the following with the credentials saved earlier:
    - **OCI User ID**
    - **OCI Private Key** (remove the -----BEGIN RSA PRIVATE KEY----- and -----END RSA PRIVATE KEY----- lines)
    - **OCI Tenancy ID**
    - **OCI Public Key Fingerprint**
4. Click to confirm the changes.
![alt text](images/editociaccessconfig.png)


### Step 1.2 Set Up Remote Server

1. Open Workspace Utilities in the Apex Application.
2. Click On Remote Servers
3. Click on the "remote server" and edit the base url to reflect your Object storage preauth url. 

### Step 2: Set Up REST Data Sources

Here we will be doing some repetitive work but it will be pretty easy. So we will edit all 3 of these sources names the same exact way and methodology. I will showcase an example of one so you are aware of what to do after you finish one go ahead and complete it for the other two sources here goes:

1. Open the application and click **Shared Components**.
![alt text](images/sharedcomponents.png)
2. Click **REST Data Sources**.
![alt text](images/restdatasources.png)
3. Edit each REST data source (`Bucket V3`, `list_buckets`, `list_objects_in_bucket`) as follows:
![alt text](images/editrestdatasources.png)

#### For `Bucket V3`:

1. Open the `Bucket V3` REST data source, and click the pencil icon to edit the remote server.
![alt text](images/editremoteserver.png)
2. Edit the remote server and plug in the pre-authenticated request URL.
3. Grab the pre-authenticated request URL from your bucket and plug it into the box where it says endpoint URL. Ensure it is in the format `https://objectstorage.us-ashburn-1.oraclecloud.com/p/-j_vl5Rra_FHPSt1Qx6lVjOdguVRDOjRdqZI/n/oraclepartnersas`. Make sure the URL cuts off at the point where it mentions your tenancy (e.g., `oraclepartnersas`). Click **Save Changes**.
![alt text](/images/urlpathprefix.png)
4.  Click **Save Changes**.
5. The rest of the URL: `/b/apex_file_storage/o/` will be used to plug into the URL path prefix underneath the base URL.
6. Ensure the URL format cuts off at the tenancy point. Make sure to change the remote server to the server we just created. You want to do this for all three rest data sources as well. 
7. Repeat the same steps for the other two sources `list_buckets` and `list_objects_in_bucket`.
8. Save changes.
Make sure you 
#### For `list_buckets`:

1. Edit the `list_buckets` REST data source.
2. Click on the parameters section and update the `compartmentid` with your PROD compartment ID.
![alt text](images/listbucketsparameters.png)
3. Save changes.

#### For `list_objects_in_bucket`:

1. Edit the `list_objects_in_bucket` REST data source.
2. Click on the parameters section and update the `bucket_name` value to reflect the name of the bucket you created earlier.
![alt text](images/listobjectsinbucketparameters.png)
3. Save changes.

### Step 3: Change Application Definition Substitution

1. Click on your application and select **Edit Application Definition** in the top right corner above export/import.
![alt text](images/applicationdefinition.png)
2. Click on the **Substitution** tab.
![alt text](images/substitution.png)
3. Edit the value for `BUCKET_PAR` to replace the existing value with the PAR endpoint from your bucket.
4. Click **Apply Changes**.
![alt text](images/editbucketpar.png)

Go Back to your ADB that we just created. Open up the SQL Developer under Database actions. Copy and paste this statement. Make sure you replace your wksp_(plug in your workspace name from apex) tag with the respective workspace name you designated for this apex app earlier

```sql
GRANT ALL ON MY_BOOKS TO WKSP_AIDEMO;
```

```SQL
GRANT EXECUTE ON GENERATE_TEXT_RESPONSE2 TO WKSP_AIDEMO;
```
```SQL
SQL> EXEC DBMS_CLOUD.CREATE_CREDENTIAL('OPENAI_CRED', 'OPENAI', '<your api token>');
```
## Conclusion

By completing these steps, you have successfully set up your APEX application, configured the necessary web credentials, set up REST data sources, and updated the application definition. This ensures that your application is fully integrated with Oracle Cloud Infrastructure and ready for further development and deployment.
