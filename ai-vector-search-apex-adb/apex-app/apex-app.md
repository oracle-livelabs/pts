# APEX Application Setup

## Introduction

Set up the APEX application to interact with Oracle Cloud Infrastructure (OCI) data sources. This lab will walk you through the process of setting up web credentials, configuring REST data sources, and updating application definitions.

Estimated Time: 10 minutes

## Objectives

By following this guide, you will:

* Insert OCI credentials.
* Set up REST data sources to connect with OCI.
* Update application definitions and substitutions for proper configuration.


### Task 1: Insert OCI Credentials in APEX

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
4. Click apply changes.
![alt text](images/editociaccessconfig.png)

### Task 2: Set Up REST Data Sources

Here we will be doing some repetitive work but it will be pretty easy. So we will edit all 3 of these source names the same exact way and methodology. I will showcase an example of one so you are aware of what to do after you finish one go ahead and complete it for the other two sources.

1. Go back to App Builder and open the application Vector Apex and click **Shared Components**.
![alt text](images/sharedcomponents.png)
2. Click **REST Data Sources**.
![alt text](images/restdatasources.png)
3. Edit each REST data source (`Bucket V3`, `list_buckets`, `list_objects_in_bucket`) as follows:
![alt text](images/editrestdatasources.png)

#### For `Bucket V3`:

1. Open the `Bucket V3` REST data source, and click the pencil icon to edit the remote server.
![alt text](images/editremoteserver.png)
2. Edit the remote server and plug in the pre-authenticated request URL.
3. Grab the pre-authenticated request URL from your bucket and plug it into the box where it says endpoint URL. Ensure it is in the format `https://objectstorage.us-ashburn-1.oraclecloud.com/p/-j_vl5Rra_FHPSt1Qx6lVjOdguVRDOjRdqZI/n/xyz`. Make sure the URL cuts off at the point where it mentions your tenancy (e.g., `xyz`). Click **Save Changes**.
![alt text](/images/urlpathprefix.png)
4. Open the same editing page again, copy the static identifier, and paste it into the name of this REST data source. The name should reflect what the static identifier has. Click **Save Changes**.
5. The rest of the URL: `/b/apex_file_storage/o/` will be used to plug into the URL path prefix underneath the base URL.
6. Ensure the URL format cuts off at the tenancy point.
7. Repeat the same steps for the other two sources `list_buckets` and `list_objects_in_bucket`.
8. Save changes.

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

### Task 3: Change Application Definition Substitution

1. Click on your application and select **Edit Application Definition** in the top right corner above export/import.
![alt text](images/applicationdefinition.png)
2. Click on the **Substitution** tab.
![alt text](images/substitution.png)
3. Edit the value for `BUCKET_PAR` to replace the existing value with the PAR endpoint from your bucket.
4. Click **Apply Changes**.
![alt text](images/editbucketpar.png)

## Conclusion

By completing these steps, you have successfully set up your APEX application, configured the necessary web credentials, set up REST data sources, and updated the application definition. This ensures that your application is fully integrated with Oracle Cloud Infrastructure and ready for further development and deployment.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Blake Hendricks, Milton Wan
* **Last Updated By/Date** -  July 2024