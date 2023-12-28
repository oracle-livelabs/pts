# Introduction

## About this Workshop
In this workshop you will be using a compute instance in OCI to simulate the on-premise database, which is deployed in one region (For example: Seoul). The standby cloud database is deployed in another region (For example: Tokyo). The primary and the standby database communicate through public internet.

Estimated Workshop Time: 5 hours

### About ADG
Oracle’s Maximum Availability Architecture (Oracle MAA) is the best practices blueprint for data protection and availability for Oracle databases deployed on private, public or hybrid clouds. Data Guard and Active Data Guard provide disaster recovery (DR) for databases with recovery time objectives (RTO) that cannot be met by restoring from backup. Customers use these solutions to deploy one or more synchronized replicas (standby databases) of a production database (the primary database) in physically separate locations to provide high availability, comprehensive data protection, and disaster recovery for mission-critical data. 

An effective disaster recovery plan can be costly due to the need to establish, equip and manage a remote data center. The Oracle Cloud offers a great alternative for hosting standby databases for customers who do not have a DR site or who prefer not to deal with the cost or complexity of managing a remote data center. Existing production databases remain on-premises and standby databases used for DR are deployed on the Oracle Cloud. This mode of deployment is commonly referred to as a hybrid cloud implementation. 

### Benefits of Hybrid Standby in the Cloud 

1. Cloud data center and infrastructure is managed by Oracle 

2. Cloud provides basic system life cycle operations including bursting and shrinking resources 

3. Oracle Data Guard provides disaster recovery, data protection and ability to offload activity for higher utilization and return on investment. 

4. When configured with MAA practices, RTO of seconds with automatic failover when configured with Data Guard Fast-Start failover and RPO less than a second for Data Guard with ASYNC transport or RPO zero for Data Guard in SYNC or FAR SYNC configurations 

### Objectives

In this lab, you will:
* Provision a Compute instance as the on-premise primary database
* Provision a DBCS as the standby database
* Setup the ADG between primary and standby.
* Test the ADG including DML redirection and switchover.
* Failover and reinstate the instance.

### Prerequisites

* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported

## Learn More
- [Oracle Data Guard](https://www.oracle.com/database/technologies/high-availability/dataguard.html)
- [Oracle Database 19c](https://www.oracle.com/database/)

## Acknowledgements
* **Author** - Minqiao Wang
* **Last Updated By/Date** - Minqiao Wang, Dec 2023

