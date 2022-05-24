# Test the Data Guard Switchover

## Introduction
We will test the Data Guard configuration across regions by switching the roles of the primary and standby database.  Switchover can be used to perform planned maintenance of the primary database.

Estimated lab time:  5 minutes
Estimated wait time: 15 minutes for Switchover

### Objective
- Perform a switchover

## Task 1: Test Switchover
1. Navigate to the Data Guard Associations of the primary database.

2. Click the 3-dot action menu on right and select Switchover


   The process will begin to make the standby database the primary.
    ![image-20210121222215264](./images/image-20210121222215264.png)

3. Enter the database password for sys when prompted.



    ![image-20210121225450775](./images/image-20210121225450775.png)



    ![image-20210121225530925](./images/image-20210121225530925.png)



    ![image-20210121225620549](./images/image-20210121225620549.png)

In a few minutes the roles will be changed and the standby database will become the primary.  The switchover use case can be used for planned maintenance operations in the primary region.

End of workshop.

## Acknowledgements
* **Author** - Milton Wan, Database Product Management, Dec 2020
* **Last Updated By/Date** - Milton Wan, Jun 2021
