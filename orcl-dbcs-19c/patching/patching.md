# Patch and update components

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

Please take a moment to watch the video below to learn how to perform the Database Lifecycle Task using the OCI Console, and then afterwards, follow the steps shown.

[Update a VM DB System Demo] (youtube:rKKnu153kww)

1. On Oracle cloud console, click on main menu **≡**, then **Oracle Base Database** under Oracle Database. Click **WS-DB** DB System.

2. Click the database name link **WSDB** in the bottom table called Databases. View **Database Version** field on the Database Information Page.

    - Database Version: 19.7.0.0.0

3. Click on **View** link next to Database Version value.

4. Make sure DB System and Database are selected on the left menu under Scope. Verify if there are available updates in the DB System and Database tables.

    DB System: WS-DB
    | Update description | Type | State | Component | Version | Last successful precheck | Release date |
    |:----------|:----------|:----------|:----------|:----------|:----------|:----------|
    |Oct 2022 19c Db System patch | Patch | Available | GI patch | 19.17.0.0.0 | Wed, Nov 2, 2022, 10:45:22 UTC | Fri, Oct 21, 2022, 17:09:27 UTC |
Jul 2022 19c Db System patch	Patch
Available	GI patch	19.16.0.0.0	Mon, Oct 31, 2022, 08:51:46 UTC	Tue, Jul 19, 2022, 01:00:00 UTC

    Database: WSDB
    | Patch description | Type | State | Version | Release date |
    |:----------|:----------|:----------|:----------|:----------|
    | Oct 2022 19c Database patch | Patch | Available | 19.17.0.0.0 | Fri, Oct 21, 2022, 17:11:06 UTC |
    | Jul 2022 19c Database patch | Patch | Available | 19.16.0.0.0 | Tue, Jul 19, 2022, 01:00:00 UTC |

## Task 2: Precheck and apply DB System update

1. At the end of the DB System update row, click **⋮** > **Run precheck**. Click **Run precheck** in the Confirm dialog. Patch state is now Checking.

2. Click on **Update History** on the left menu. View the first row in the Database System table, with Checking State. Wait until it finishes with State Precheck Passed.

3. Click on **Updates** on the left menu. Click on **⋮** > **Apply**. Click **Apply patch** in the confirm dialog. Patch state is now Applying.

4. Click on **Update History** on the left menu. View the first row in the Database System table, with Applying State. Wait until it finishes with State Applied.


## Task 3: Precheck and apply Database update

1. Click on **Update History** on the left menu.

2. At the end of the Database update row, click **⋮** > **Precheck**. Click **Run precheck** in the Confirm dialog. Patch state is now Checking.

3. Click on **Update History** on the left menu. View the first row in the Database table below, with Checking State. Wait until it finishes with State Precheck Passed.

4. Click on **Updates** on the left menu. Click on **⋮** > **Apply**. Click **OK** in the confirm dialog. Patch state is now Applying.

5. Click on **Update History** on the left menu. View the first row in the Database table, with Applying State. Wait until it finishes with State Applied.

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022
