# Oracle Base Database Service patches and updates

## Introduction

The Oracle Base Database Service patching feature simplifies the steps required to patch your DB systems and databases. You can use the Oracle Cloud Infrastructure console and APIs to view applicable patches for your DB system or database home and submit a patching request. The Oracle Base Database Service will then run the end-to-end patching steps for you while displaying the status.

You can view all patches that have been applied, and if required, re-apply a patch.

Oracle Base Database Service specific patches for DB systems and database homes can be applied. Only the latest patch is available for DB systems while database homes supports both latest and older patches. You can find the list of currently available DB system and database home patches in the [Oracle Cloud Infrastructure technical documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/Database/Tasks/patchingDB.htm).

Estimated Time: 15 minutes

### Objectives

In this lab you will:
* Check available software updates
* Run a Pre-Check task to verify update compatibility
* Execute the Apply Patch procedure on your DB System

### Prerequisites

This lab assumes you have:
* Provisioned Oracle Base Database Service

## Task 1: Check Available Updates

1. On Oracle cloud console, click on main menu ≡, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System.

2. Click the database name link **WSDB** in the bottom table called Databases. View Database Version field on the Database Information Page.

    - Database Version: 19.7.0.0.0

3. At the bottom of this page, click on **Updates**.

4. Verify if there are available updates in the table.

    | Patch Description | State | Version  |
    |:----------|:----------|:----------|
    | Jul 2020 19c Database patch    | Available    | 19.8.0.0.200714    |

## Task 2: Pre-Check Update Compatibility

1. At the end of the update row, click ⋮ > **Precheck**. Click **Run Precheck** in the Confirm dialog. Patch state is now Checking.

2. Click on **Work Requests**. View the last one in the table:

    - Operation: Patch DB Home
    - Status: In Progress...
    - % Complete: 15%

3. Click on **Patch DB Home** link. Review the Workrequest Information page. Under Resources, click on the links to view more information about this execution:

    - Log Messages (2)
    - Error Messages (0)
    - Associated Resources (2)

4. Wait for the Work Requests to become 100% complete.

5. You can use the breadcrumbs links in the upper section of the page to navigate to superior levels: Overview > Bare Metal, VM and Exadata > DB Systems > DB System Details > Database Home Details > Database Details. Click **Database Details**, wait for Status to become Available.

## Task 3: Apply Patch

1. At the bottom of this page, click again on **Updates**. At the end of the patch row, click ⋮ > **Apply**. Click **OK** in the Confirm dialog. Patch state is now Applying.

2. Click on **Work Requests**. View the last one in the table:

    - Operation: Patch DB Home
    - Status: In Progress...
    - % Complete: 15%

3. Click on **Patch DB Home** link having Status In Progress... Review the Workrequest Information page. Under Resources, click on the links to view more information about this execution:

    - Log Messages (2)
    - Error Messages (0)
    - Associated Resources (2)

4. Wait for the Work Requests to become 100% complete.

5. You can use the breadcrumbs links in the upper section of the page to navigate to superior levels: Overview > Bare Metal, VM and Exadata > DB Systems > DB System Details > Database Home Details > Database Details. Click **Database Details**.

6. Review Database Version field on the Database Information Page. Now it should display the new version, after applying the patch.

    - Database Version: 19.8.0.0.0

7. At the bottom of this page, click **Update History**. Review the list of patches applied to this Database Service instance.

    | Description | State | Operation Type |
    |:----------|:----------|:----------|
    | Jul 2020 19c Database patch | Applied | Apply |
    | Jul 2020 19c Database patch | Precheck Passed | Precheck |

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
