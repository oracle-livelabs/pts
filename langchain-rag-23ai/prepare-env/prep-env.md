# Lab preparation

## Introduction

This lab requires the OCI Compartment OCID to be set so it can access the OCI GenAI Service LLMs.

### Objectives

In this lab, you will:
* Retrieve the Compartment OCID
* Copy the Compartment OCID to the environment variable file

### Prerequisites

* Access to LiveLab environment running this workshop
* Access to Compartment OCID 

## Task 1: Retrieve the Compartment OCID

1. On LiveLabs before launching remote desktop, you should have copied the Compartment OCID and saved it.

 ![LiveLabs launch lab](images/lllaunchlab.png)

2. Once your noVNC session has started copy your OCID to the noVNC Clipboard.
   
  ![LiveLabs launch lab](images/copyocid.png) 

3. Open the **.env** file from the terminal with vi editor in the /home/oracle/AIdemo directory.

 ![vi editor](images/vienvpwd.png)

3. In vi editor, position the cursor right after the variable COMPARTMENT_OCID=

4. Hit **ESC** key in vi and type the **i** key to go to edit mode.  Delete the existing key if there is one.  Insert the OCID you copied to the Clipboard to COMPARTMENT_OCID=.  

5. Hit **ESC** key again, and type **:wq** to save the .env file.

 ![vi editor open](images/addocid.png)

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Author** - Milton Wan, Rajeev Rumale
* **Last Updated By/Date** -  Milton Wan, April 2024
