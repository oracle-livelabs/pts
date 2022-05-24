# Introduction

## Oracle Database Backup Service

Oracle Database Backup Service (ODBS) is a backup-as-a-service offering that enables customers to store their backups securely in the Oracle cloud. ODBS provides a transparent, scalable, efficient, and elastic cloud storage platform for Oracle database backups. The client side Oracle Database Cloud Backup Module which is used with Recovery Manager (RMAN) transparently handles the backup and restore operations.

In this workshop, you will learn how to backup and recover your on-premise database to the OCI.

Estimated Time: 2.5 hours

### Objectives

- Install the Oracle Database Cloud Backup Module onto the VM image provided in the workshop. The database provided is used as our “On-Premise” example.

- Configure RMAN to support the Oracle Database Cloud Backup Module. Then, backup the database and take a restore point to be used for Point-In-Time-Recovery.

- Do a destructive operation to the database and then Restore and Recover to a specific Point-In-Time.

### Prerequisites

- An on-premise database version 11.2.0.4 or later (if you don't have it, you can create one by following the workshop)
- OCIDs for tenancy, user and compartment
- An OCI account with proper privileges to access the object storage in OCI
    * Please view this workshop's LiveLabs landing page to see which environments are supported
    
    >**Note:** If you have a **Free Trial** account, when your Free Trial expires, your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available.
**[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)**

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Minqiao Wang, Database Product Management, PTS China - April 2020
- **Adapted by** -  Yaisah Granillo, Cloud Solution Engineer
- **Last Updated By/Date** - Arabella Yao, Product Manager, Database Product Management, March 2022