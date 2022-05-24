# Understand customer insurance use case

## Introduction

Before starting the lab exercises, let's examine the use case and understand what we are trying to achieve with machine learning.  

We are using customer insurance data for a business selling insurance.  The data contains over 15,000 customer information records such as name, customer ID, age, marital status, income, and meaningful business information such as whether the customer bought the insurance and whether the customer is considered to have business value with an attribute called lifetime value or LTV. We can use historical records to make predictions with machine learning.  An employee of the business has been keeping records of the customers on a table with the name CUST\_INSUR\_LTV for many years and is ready to be exploited by marketing and data science areas.

The insurance business wants to analyze four business cases to get demographics about a set of customers who have bought one or are historically known to have insurance; this is represented field  BUY_INSURANCE=Yes in their database, intending to get to know your customers and your market better and can launch new campaigns in the marketing area. Therefore they need to know the demographics of your typical and atypical customers that have bought insurance.

### Business Objectives

* Find the most atypical members of this customer group.
* Discover the common demographic characteristics of the most typical customers with insurance.
* Compute how typical or What probability of purchase have a given new/hypothetical customer is, And grant it to sellers like a tool to qualify better their potential clients since the first contact.
* Identify rows that are most atypical in the input dataset. Consider each type of marital status to be separate, so the most anomalous rows per marital status group should be returned.

### Prerequisites

* Access the Oracle database containing the customer insurance table and run the scripts to configure the user and prepare data.


You may now **proceed to the next lab**


## Acknowledgements
* **Authors** - Adrian Castillo Mendoza, Milton Wan, Valentin Leonard Tabacaru, Rajeev Rumale.
* **Last Updated By/Date** -  Adrian Castillo Mendoza, March 2022.
