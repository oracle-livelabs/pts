# Prepare setup

## Introduction
This lab will show you how to download the Oracle Resource Manager (ORM) stack zip file needed to setup the resource needed to run this workshop. This workshop requires a compute instance and a Virtual Cloud Network (VCN).

Estimated Time: 15 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:HI9iczwKwJ4)

### Objectives
-   Download ORM stack need to create Compute Instance(Virtual Machine) for this workshop.

### Prerequisites
This lab assumes you have:
- An Oracle Cloud Infrastructure (OCI) account
- Have sufficient quota for in your tenancy to create VM and VCN.

## Task 1: Download Oracle Resource Manager (ORM) stack zip file
1.  Click on the link below to download the Resource Manager zip file you need to build your environment: [omlvm-mkplc-freetier.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/sDX34HYvxdv1GjdCplfdYt-HSj9NBe4rjsXgltW0Ax5VPGmhSlGBpqm3wVVvhFxR/n/oraclepartnersas/b/omlvm-mkplc-freetier/o/omlvm-mkplc-freetier.zip)

2.  Save in your downloads folder.

We strongly recommend using this stack to create a self-contained/dedicated VCN with your instance(s). Skip to *Step 3* to follow our recommendations. If you would rather use an exiting VCN then proceed to the next step as indicated below to update your existing VCN with the required Egress rules.

## Task 2: Setup Compute   

1. Using the details from the two steps above, proceed to the lab *Environment Setup* to setup your workshop environment using Oracle Resource Manager (ORM) and one of the following options:
  -  Create Stack:  *Compute + Networking*
  -  Create Stack:  *Compute only* with an existing VCN where security lists have been updated as per *Step 2* above

    You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
* **Contributors** - Meghana Banka, Rene Fontcha, Narayanan Ramakrishnan
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021
