# Clean up (optional)

## Introduction

In this lab we will cleanup the infrastructure that we used to run this workshop.

The main two elements that we will cleanup are the **Autonomous JSON Database** where you stored the JSON documents that we ingested our Python apps with, and **Compute instance** using an image from the marketplace including the libraries need to execute the scripts needed to create and execute applications in Python.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:

* Terminate Oracle Autonomous JSON Database (AJD)
* Terminate Compute Node for development

### Prerequisites

* An Oracle Cloud Infrastructure (OCI) account


## Task 1: Terminate the Oracle Autonomous JSON Database (AJD)

1. **Click** on main menu ≡, then Oracle Database > **Autonomous JSON Database**.

    ![Oracle Console AJD](./images/oracle-console-ajson.png)

2. Click your **XXX0AJD** Autonomous JSON Database instance.

    ![Oracle Console AJD](./images/ajd-list.png)

3. Click **More Actions** > **Terminate**.

    ![Oracle Console AJD](./images/ajd-terminate.png)

4. To confirm, enter the name of the database that you want to terminate:

    ```
    <copy>XXX0AJD</copy>
    ```

5. Click **Terminate Autonomous Database**.

    ![Oracle Console AJD](./images/terminate-ajd.png)

## Task 2: Terminate the Compute Node for development

1. Click on main menu ≡, then Compute > **Instances**.

    ![Oracle Console AJD](./images/menu-compute-instances.png)

2. Click your **XXX0VM** compute instance.

    ![Oracle Console AJD](./images/compute-list.png)

3. Click **More Actions** > **Terminate**.

    ![Oracle Console AJD](./images/compute-terminate.png)

4. Check **Permanently delete the attached boot volume** check-box.

5. Click **Terminate instance** button.

    ![Oracle Console AJD](./images/terminate-instance.png)

**Congratulations! Well done!**

## Acknowledgements
* **Author** - Valentin Leonard Tabacaru, Database Product Management and Priscila Iruela, Technology Product Strategy Director
* **Contributors** - Victor Martin Alvarez, Technology Product Strategy Director
* **Last Updated By/Date** - Priscila Iruela, April 2023
