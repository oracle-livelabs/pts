# Introduction

![Intro Application Continuity made simple with Universal Connection Pool](./images/intro.png)

## About this Workshop

**Application Continuity** makes planned maintenance activities and unplanned outages transparent for end-users by recovering the in-flight work of impacted database sessions.

Run this hands-on workshop to learn how to use RAC services, configure Fast Application Notification, Draining and Application Continuity from an Oracle connection pool (UCP). UCP provides explicit request boundaries on check-out and check-in of connections, which makes Application Continuity easy to use.

This workshop is based on a compute instance (a demo application) connected to a 2-node DBCS RAC.
The demo application is a simple Java program using a 21c client. Its code shows how to create and use a Universal Connection Pool to the RAC.

It demonstrates:
*	How to set up UCP (good for ISVs).
*	How to set up ONS & FAN (required for Application Continuity and Transparent Application Continuity ).
*	How to configure and use database services to make planned maintenance as well as other outages transparent to applications.

The demo program allows to interrupt a transaction at will and show whether or not it is transparently replayed on a different node of the RAC.

Estimated Workshop Time: 2 hours (This estimate is for the entire workshop - it is the sum of the estimates provided for each of the labs included in the workshop.)


### Objectives

This workshop has three objectives:

* Understand how to configure the client-server Environment (database services, connection pool, etc.)
* Show Application Continuity in action
* Show how to use database services and Application Continuity for Planned Maintenance

The demo program allows to interrupt a transaction at will and show whether or not it is transparently replayed on a different node of the RAC.


### Prerequisites

This lab assumes you have:
* An Oracle LiveLabs sandbox environment
* Or an Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account - You can check Getting Started section for more information.

Here is a video to help with the Oracle Trial Sign Up Process:
[](youtube:4U-0SumNz6w)

**At this point, you are ready to start learning! Please proceed.**


## Acknowledgements
* **Author** - François Pons, Senior Principal Product Manager
* **Contributors** - Andrei Manoliu, Principal Product Manager
* **Last Updated By/Date** - François Pons, July 2022
