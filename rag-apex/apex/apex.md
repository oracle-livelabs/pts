# Setup Apex Service

## Introduction

In this lab we will setup an Oracle APEX (Application Express) service with Oracle Autonomous Database for web application development. APEX provides a powerful and user-friendly platform to build scalable, secure, and highly functional web applications. This guide will walk you through the process of setting up an APEX service, creating a workspace, and preparing for application deployment.

## Objectives

By following this guide, you will:

- Set up an Oracle APEX service on your ADB instance.
- Create a new APEX workspace and schema.
- Login to your APEX instance.
- Import and configure a pre-built application in APEX.

## Step-by-Step Guide

### 1. Set Up Oracle APEX Service

1. Go to your ADB instance you created.
2. Click on **Database Actions** and select **View All Database Actions**.
![alt text](/images/databaseactions.png) 
1. Click on the **Development** tab.
2. Click **APEX** on the left-hand side.
![alt text](/images/dbactionsapex.png)
1. Click **Create Workspace** and type in your password you created with the ADB instance.
![alt text](images/dbactionscreateworkspace.png)
![alt text](images/dbactionspassword.png)
1. Enter your desired values for the workspace name, username, and password. Click **Create Workspace**.
![alt text](images/dbactionscredentials.png)
1. Select **New Schema**.
![alt text](images/dbactionsnewschema.png)

### 2. Log In to Your APEX Instance

1. Head back to the Autonomous Database you created.
2. Click on the APEX instance name.
![alt text](images/dbaccessapexinstance.png)
1. Click **Launch APEX**.
![alt text](images/dbactionlaunchapex.png)
1. Enter the credentials you created with your workspace:
   - **Workspace Name**: Enter your workspace name.
   - **Username**: Your user you created for the workspace.
   - **Password**: The password you created in the workspace for that user.
2. Click on **App Builder** located on the left of the dashboard.
![alt text](images/dbactionsappbuilder.png)
1. Select **Import** and upload the [SQL file](images/f100.sql) we obtained to access the pre-configured application. 
![alt text](images/dbactionsimport.png)
1. Confirm changes to move on to the next part.

## Conclusion

By setting up the Oracle APEX service and creating a workspace, you have laid the foundation for developing robust applications with Oracle Autonomous Database. Importing and configuring a pre-built application in APEX allows you to quickly leverage existing functionalities and customize them according to your requirements. 
