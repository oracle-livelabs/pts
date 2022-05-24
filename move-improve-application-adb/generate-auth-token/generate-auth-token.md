# Generate the Auth Token #

## Introduction

Auth tokens are Oracle-generated token strings that you can use to authenticate with third-party APIs or to Oracle services like the Oracle Object Store. Each user created in the IAM service automatically has the ability to create, update, and delete their own auth tokens in the Console or the API.

Estimated Time: 5 minutes

### Objective

* Generate Auth token.

### Prerequisite

* Web browser

### Disclaimer
The following is intended to outline our general product direction. It is intended for information purposes only, and may not be incorporated into any contract. It is not a commitment to deliver any material, code, or functionality, and should not be relied upon in making purchasing decisions. The development, release, and timing of any features or functionality described for Oracle’s products remains at the sole discretion of Oracle.


## Task 1: Generate the Auth Token ##



1.  View the user's details:
    - If you're creating an auth token for yourself: Open the **Profile** menu ( ![User menu icon](./images/usermenu.png) ) and click **User Settings**.
    - If you're an administrator creating an auth token for another user: In the Console, click **Identity**, and then click **Users**. Locate the user in the list, and then click the user's name to view the details.
       ![](./images/user-profile-icon.png)
       ![](./images/user-settings.png)

2.  On the left side of the page, click **Auth Tokens**.
       ![](./images/generate-token.png)

3.  Click **Generate Token**.

4.  Enter a description that indicates what this token is for, for example, "Object store password token".

5.  Click **Generate Token**.The new token string is displayed.
      ![](./images/copy-token.png)

6. Copy the token string immediately, because you can't retrieve it again after closing the dialog box.

    If you're an administrator creating an auth token for another user, you need to securely deliver it to the user by providing it verbally, printing it out, or sending it through a secure email service.

  You may now proceed to the next lab.

## Acknowledgements ##

- **Author** - Milton Wan, Satyabrata Mishra - Database Product Management, August 2021
