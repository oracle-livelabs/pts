# Oracle Base Database Service features

## Introduction

Oracle Cloud Infrastructure offers single-node DB systems on either bare metal or virtual machines, and 2-node RAC DB systems on virtual machines.

Estimated Time: 4 hours 30 minutes

### Objectives

In this workshop you will:
* Provision OCI resources
* Prepare for application data
* Manage database service
* Back up and recover your data
* Deploy disaster recovery
* Patch and update components
* Use command line interface

### Prerequisites

This workshop assumes you have:
* Access to Oracle Cloud Infrastructure
    * Provided by the instructor for instructor-led workshops
* Access to a laptop or a desktop with
    * Microsoft Remote Desktop software
    * Putty or OpenSSH, PuttyGen, and web browser

## Task 1: Generate SSH Keys (optional)

1. This task will get you ready for the Oracle Base Database Service labs.  It is recommended to download several software tools to access the Oracle Base Database Service, like Puttygen and Putty, however this is not mandatory.  This workshop and the labs that follow support either Windows clients or Linux clients.

1. Keys are part of the key pairs used to securely connect to the Oracle Database Cloud.  By default Oracle Cloud uses the secure key infrastructure for connectivity from a client.
    - id_rsa – private key on Linux client
    - id_rsa.ppk – private key for Putty client
    - id_rsa.pub – public key installed on the Oracle Cloud server

2. If you are using a Linux client, immediately change the file permissions on **id_rsa** using the change mode command.

    ````
    <copy>
    chmod 600 id_rsa
    </copy>
    ````

    >**Note** : The instructor may provide you a pre-created set of keys.

3. Generate your own Public and Private Keys. This section shows you how to create your own public and private key.  Once created, the public key is placed on the cloud server, and the private key is distributed to the clients to unlock the public key during the client connection to the server.

### Key Generation From a Windows Client (Windows only)

1. Create a Public Key and a Private Key using Puttygen.exe

    ![Puttygen no key](./images/puttygen-no-key.png "")

2. Click Generate and move the mouse around the blank area to generate randomness.

    ![Puttygen generate](./images/puttygen-generate.png "")

3. Select all and copy the generated Public Key.  You may need to scroll down to copy the entire key.  Open a text editor and paste the entire key and save the file as mykey.pub.  You will upload this public key to the Cloud Service later.

    >**Note** : The Save public key does not save the public key in the right format, you must copy and paste the generated public key.

4. Click Save Private Key to your laptop with a name of mykey.ppk and in a directory of your choosing. You can optionally create a key passphrase.  The passphrase is used for extra security whereby when you connect, it will prompt for the passphrase.  You can use SSH-2 RSA as the type of key to generate.

    ![Puttygen save keys](./images/puttygen-save-keys.png "")

### Key Generation From a Linux Client (Linux only)

1. Open a new terminal window.

2. Type

    ````
    <copy>
    ssh-keygen –t rsa
    </copy>
    ````

3. You can hit enter for the default or enter a new file name when prompted with:

    ````
    Enter file in which to save the key (/home/demo/.ssh/id_rsa):
    ````

4. You can also enter in a passphrase for additional security to unlock the private key.  Hit return here, we will not have a passphrase.

    ````
    Enter a passphrase (empty for no passphrase):
    ````

5. For example, you should see the following:

    ````
    ssh-keygen -t rsa
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/demo/.ssh/id_rsa): /home/demo/.ssh/mykey
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /home/demo/.ssh/mykey.
    Your public key has been saved in /home/demo/.ssh/mykey.pub.
    The key fingerprint is:
    ````

    Now you are ready to upload the public key to the Oracle Database Cloud Server when creating the instance.

    You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2022

## Need help?

Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
