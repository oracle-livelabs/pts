# Introduction

## About This Workshop
This workshop focuses on Creating Active Data Guard 19c on cloud compute systems. It will be similar to creating Active Data Guard on-premises. After creating the systems, you can proceed to the Active Data Guard Fundamentals LiveLab to explore the features such as DML redirect, automatic block media recovery. In this Lab, You will using a compute instance in OCI to simulate the primary database, which is deployed in one region (For example: Seoul). Another compute instance in OCI to simulate the standby database which can be deployed in another region (For example: Tokyo). The primary and the standby database communicate through public internet. 

Estimated Time: 4 hours

### About Product/Technology
Oracle’s Maximum Availability Architecture (Oracle MAA) is the best practices blueprint for data protection and availability for Oracle databases deployed on private, public or hybrid clouds. Data Guard and Active Data Guard provide disaster recovery (DR) for databases with recovery time objectives (RTO) that cannot be met by restoring from backup. Customers use these solutions to deploy one or more synchronized replicas (standby databases) of a production database (the primary database) in physically separate locations to provide high availability, comprehensive data protection, and disaster recovery for mission-critical data. 
- [Oracle Data Guard](https://www.oracle.com/database/technologies/high-availability/dataguard.html)
- [Oracle Database 19c](https://www.oracle.com/database/)

### Objectives
In this lab, you will:
* Provision a primary and standby environment for ADG.
* Setup the ADG between primary and standby.
* Test the ADG and perform a switchover.
* Failover and reinstate the instance.

### Prerequisites
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account

## Acknowledgements
* **Author** - Minqiao Wang, Oct 2020
* **Last Updated By/Date** - Minqiao Wang, Oct 2021
