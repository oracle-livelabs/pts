# Set Connectivity Between Primary And Standby Host

## Introduction
In a Data Guard configuration, information is transmitted in both directions between the primary and standby databases. This requires basic configuration, network tuning and opening of ports at both primary and standby databases site. 

Estimated Time: 30 minutes

### Objectives
- Open the 1521 port for both hosts.
- Enable ssh connect for the oracle user.
- Configure the Name Resolution.
- Prompt-less SSH configure.

### Prerequisites

This lab assumes you have already completed the following labs:

- Setup Environment For Primary And Standby
- Prepare Primary Database

In this Lab, you can use 2 terminal windows, one connected to the primary host, the other connected to the standby host. 

## **Task 1:** Open The 1521 Port For Both Database Hosts

1. Connect to the both hosts with **opc** user. Use putty tool (Windows) or command line (Mac, Linux).

    ```
    <copy>ssh -i labkey opc@xxx.xxx.xxx.xxx</copy>
    ```

2. Copy and run the following command to open the 1521 port on both side.

    ```
    <copy>
    sudo firewall-cmd --zone=public --add-port=1521/tcp --permanent
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all
    </copy>
    ```

   

## **Task 2:** Enable SSH Connect For The Oracle User

1. Work as opc user, edit the ssh configure file on both side

    ```
    <copy>sudo vi /etc/ssh/sshd_config</copy>
    ```

2. Add the following lines in the end of the file.

    ```
    <copy>
    AllowUsers oracle
    AllowUsers opc
    </copy>
    ```

3. Restart the ssh service.

    ```
    <copy>sudo systemctl restart sshd.service</copy>
    ```


## Task 3: Name Resolution Configure

1. Connect as the opc user. Edit `/etc/hosts` on both sides.

    ```
    <copy>sudo vi /etc/hosts</copy>
    ```

   

2. Add the primary and standby host public ip and hostname in the file like the following:

    ```
    <copy>
    xxx.xxx.xxx.xxx primary.subnet1.primaryvcn.oraclevcn.com primary
    xxx.xxx.xxx.xxx  standby.subnet1.standbyvcn.oraclevcn.com standby
    </copy>
    ```

   



## **Task 4:** Prompt-less SSH Configure

Now you will configure the prompt-less ssh for oracle users between the primary and the standby.

1. su to **oracle** user in both side.

    ```
    <copy>sudo su - oracle</copy>
    ```

2. Configure prompt-less ssh from the primary to the standby.

    - From the primary side, generate the ssh key, and cat the public key, copy all the content in the id_rsa.pub

    ```
    [oracle@primary ~]$ <copy>ssh-keygen -t rsa</copy>
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/oracle/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/oracle/.ssh/id_rsa.
    Your public key has been saved in /home/oracle/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:2S***LP4Rs***hus8UQaG8 oracle@adgstudent1
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
    ```

    ```
    [oracle@primary ~]$ <copy>cat .ssh/id_rsa.pub</copy>
    ssh-rsaAAAA***
    ...
    ***IbTNY+k1sfHwyuUl oracle@workshop 
    ```

    

    - From the standby side, edit the `authorized_keys` file, copy all the content in the id_rsa.pub into it, save and close

    ```
    <copy>
    mkdir .ssh
    vi .ssh/authorized_keys
    </copy>
    ```

    - Change mode of the file.

    ```
    <copy>chmod 600 .ssh/authorized_keys</copy>
    ```

       

    - From primary side, test the connection from the primary to the standby, using the public ip or hostname of the standby hosts.

    ```
    [oracle@primary ~]$ <copy>ssh oracle@standby echo Test success</copy>
    The authenticity of host '158.101.136.61 (158.101.136.61)' can't be established.
    ECDSA key fingerprint is SHA256:c3ghv***...***BVdaRLx4.
    ECDSA key fingerprint is MD5:a8:***...***ac:4c.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '158.101.136.61' (ECDSA) to the list of known hosts.
    Test success
    [oracle@primary ~]$ 
    ```

3. Configure prompt-less ssh from the standby to primary.

    - From the standby side, generate the ssh key, and cat the public key, copy all the content in the id_rsa.pub.

    ```
    [oracle@standby ~]$ <copy>ssh-keygen -t rsa</copy>
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/oracle/.ssh/id_rsa): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /home/oracle/.ssh/id_rsa.
    Your public key has been saved in /home/oracle/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:60bMH***...***HCQxIM oracle@dbstby
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
    ```
    
    ```
    [oracle@standby ~]$ <copy>cat .ssh/id_rsa.pub</copy>
    ssh-rsa AAAAB3***
    ...
    ***kIPaTfSlgx0E1 oracle@dbstby
    [oracle@standby ~]$ 
    ```
    
    
    
    - From the primary side, edit the `authorized_keys` file, copy all the content in the `id_rsa.pub` into it, save and close
    
    ```
    <copy>vi .ssh/authorized_keys</copy>
    ```
    
    - Change mode of the file.
    
    ```
    <copy>chmod 600 .ssh/authorized_keys</copy>
    ```
    
    - From the standby side, test the connection from standby to primary, using the public ip or hostname of the primary hosts.
    
    ```
    [oracle@standby ~]$ <copy>ssh oracle@primary echo Test success</copy>
    The authenticity of host '140.238.18.190 (140.238.18.190)' can't be established.
    ECDSA key fingerprint is SHA256:1GMD***...***SBc8c.
    ECDSA key fingerprint is MD5:ff:***...***5d:5c.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added '140.238.18.190' (ECDSA) to the list of known hosts.
    Test success
    [oracle@standby ~]$ 
    ```

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Minqiao Wang, Oct 2020 
* **Last Updated By/Date** - Minqiao Wang, Feb 2023



