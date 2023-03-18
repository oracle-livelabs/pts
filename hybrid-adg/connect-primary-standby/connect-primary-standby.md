# Set connectivity between on-premise host and cloud host

## Introduction
In a Data Guard configuration, information is transmitted in both directions between primary and standby databases. This requires basic configuration, network tuning and opening of ports at both primary and standby databases. 

Estimated Lab Time: 10 minutes

### Objectives

-   Name Resolution Configure
-   Prompt-less SSH configure

### Prerequisites

This lab assumes you have already completed the following labs:

- Prepare on-premise Database
- Provision DBCS on OCI

In this lab, you can use 2 terminal windows, one connected to the on-premise host, the other connected to the cloud host. 

## Task 1: Name Resolution Configure

1. Connect as the opc user.

    ```
    ssh -i labkey opc@xxx.xxx.xxx.xxx
    ```

2. Edit `/etc/hosts` on both sides.

   ```
   <copy>sudo vi /etc/hosts</copy>
   ```

   From on-premise side, add the cloud host **public ip** and host name in the file like the following:

      ```
      xxx.xxx.xxx.xxx standby.***.***.oraclevcn.com  standby
      ```

   From the cloud side, add the on-premise host **public ip** and host name in the file like the following:

      ```
      xxx.xxx.xxx.xxx primary.subnet1.primaryvcn.oraclevcn.com primary
      ```

   


## Task 2: Prompt-less SSH configure

Now you will configure the prompt-less ssh for oracle users between on-premise and the cloud.

1. su to **oracle** user in both side.

    ```
    <copy>sudo su - oracle</copy>
    ```

2. Configure prompt-less ssh from on-premise to cloud.

- From on-premise side, generate the ssh key
     ```
     [oracle@primary ~]$ <copy>ssh-keygen -t rsa</copy>
     Generating public/private rsa key pair.
     Enter file in which to save the key (/home/oracle/.ssh/id_rsa): 
     Enter passphrase (empty for no passphrase): 
     Enter same passphrase again: 
     Your identification has been saved in /home/oracle/.ssh/id_rsa.
     Your public key has been saved in /home/oracle/.ssh/id_rsa.pub.
     The key fingerprint is:
     SHA256:2S+UtAXQdwgNLRA7hjLP4RsMfDM0pW3p75hus8UQaG8 oracle@adgstudent1
     The key's randomart image is:
     +---[RSA 2048]----+
     |      o.==+= .   |
     |   . . * oo.= .  |
     |    = X O .o..   |
     |     @ O * +     |
     |      * E =      |
     |       + = .     |
     |      .   = .    |
     |        o= .     |
     |       o=o.      |
     +----[SHA256]-----+
     [oracle@primary ~]$ 
     ```
- Cat the public key, copy all the content in the id_rsa.pub

    ```
    [oracle@primary ~]$ <copy>cat .ssh/id_rsa.pub</copy>
     ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCLV6NiFi8hEKP2uLSh7AEeKm4MZmPPIzO/HlMw3Kk......kAxgd1UeuFS0pIiejutqbPSeppu9X......    cbutoVRGPcP1xc43ut9oUWk8reBEyDj8X2bgeafG+KeXD6YRh53lqIbTNYz+k1sfHwyuUl oracle@workshop
    ```

  

- From cloud side, edit the `authorized_keys` file, copy all the content in the id_rsa.pub into it, save and close
    ```
    <copy>vi .ssh/authorized_keys</copy>
    ```
- From on-premise side, test the connect from on-premise to cloud, using the public ip or hostname of the cloud hosts.
    ```
    [oracle@primary ~]$ <copy>ssh oracle@standby echo Test success</copy>
    The authenticity of host '158.101.136.61 (158.101.136.61)' can't be established.
    ECDSA key fingerprint is SHA256:c3ghvWrZxvOnJc6aKWIPbFC80h65cZCxvQxBVdaRLx4.
    ECDSA key fingerprint is MD5:a8:34:53:0f:3e:56:64:56:72:a1:cb:47:18:44:ac:4c.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '158.101.136.61' (ECDSA) to the list of known hosts.
    Test success
    [oracle@primary ~]$ 
    ```
3. Configure prompt-less ssh from cloud to on-premise.

- From cloud side, generate the ssh key
    ```
    [oracle@standby ~]$ <copy>ssh-keygen -t rsa</copy>
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/oracle/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/oracle/.ssh/id_rsa.
    Your public key has been saved in /home/oracle/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:60bMHAglf6pIHKjDnQAm+35L79itld48VVg1+HCQxIM oracle@dbstby
    The key's randomart image is:
    +---[RSA 2048]----+
    |o.  ...     +o+o.|
    |+o  .o     E *...|
    |o..  ....    o=  |
    |ooo.. .o.   . .. |
    |o.+o  .+S.   .   |
    | + . .  =o  .    |
    |  o +  .+  .     |
    |   o = =.o.      |
    |    o.=o+ o.     |
    +----[SHA256]-----+
    
    [oracle@standby ~]$ 
    ```
- Cat the public key, copy all the content in the id_rsa.pub.

    ```
    [oracle@standby ~]$ <copy>cat .ssh/id_rsa.pub</copy>
     ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC61WzEm1bYRkPnFf96Loq/eRGJKiSkeh9EFg3NzMBUmRq4rSWMsMkIkrLmrJUNF8I5tFMnSV+AQZ......iKm8f7pPlqnxpf1QdO8lswMvInW......    mxqxAjP0KWDFlSZ3aNm4ESS3ZPaTfSlgx0E1 oracle@standby
    ```

  

- From on-premise side, edit the `authorized_keys` file, copy all the content in the `id_rsa.pub` into it, save and close
    ```
    <copy>vi .ssh/authorized_keys</copy>
    ```
- Change mode of the file.
    ```
    <copy>chmod 600 .ssh/authorized_keys</copy>
    ```
- From cloud side, test the connect from cloud to on-premise, using the public ip or hostname of the on-premise hosts.
    ```
    [oracle@standby ~]$ <copy>ssh oracle@primary echo Test success</copy>
    The authenticity of host '140.238.18.190 (140.238.18.190)' can't be established.
    ECDSA key fingerprint is SHA256:1GMD9btUlIjLABsTsS387MUGD4LrZ4rxDQ8eyASBc8c.
    ECDSA key fingerprint is MD5:ff:8b:59:ac:05:dd:27:07:e1:3f:bc:c6:fa:4e:5d:5c.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '140.238.18.190' (ECDSA) to the list of known hosts.
    Test success
    [oracle@dbstby ~]$ 
    ```
You may proceed to the next lab.

## Acknowledgements
* **Author** - Minqiao Wang, Oracle China
* **Last Updated By/Date** - Minqiao Wang, Mar 2023

