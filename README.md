# NAGIOS-ANSIBLE
- This Ansible playbook installs Nagios Core monitoring tool on an Ubuntu 14.04.4 LTS Virtual Machine (VM) which is intended to serve as a **Monitoring Server.** 
- It also installs Nagios Remote Plugin Executor (NRPE) which allows you to add and remotely monitor any Linux/Unix services or network devices.

**Note**:
If you will like to add a new host to the Monitoring server, so that it will be monitored, there is another [repository](https://github.com/andela-ayusuf/nagios-ansible-remote) that helps with with that.

**Requirements**

- Before running this Ansible playbook, you must have Ansible installed locally. You can find out about how to install Ansible [here](http://docs.ansible.com/ansible/intro_installation.html).
- The private key to the VM which is to be configured is also a requirement.
- It is also important to note that before installing Nagios Core on a VM, you must have Linux, Apache, MySql and PHP (LAMP) stack already configured on the VM. If you need help configuring LAMP stack, go [here](https://github.com/andela-ayusuf/lamp-stack-config-mgt).


**Clone This Project**
```
git clone https://github.com/andela-ayusuf/nagios-ansible.git
```

**Variables**

You will need to update the variables files i.e. **vars.yml** and **vars.rb** files with the appropriate variables. Currently there are only dummy variables in the variable files and these will not work. The **inventory.ini** file also has to be updated with the public IP address of the VM which is about to be configured.


**Running The Project**

From your terminal, cd into this project directory:

```
$ cd nagios-ansible
```
Run the playbook:
```
$ ansible-playbook playbook.nagios.yml -i inventory.ini --private-key=path/to/private/key
```
OR
```
$ cucumber features/install.feature
```

With that done you have a Nagios Core monitoring tool configured on your VM.

**Issues**

If you happen to run into any problems while using this playbook or you would like to make contributions to it, please endeavour to open an issue [here](https://github.com/andela-ayusuf/nagios-ansible/issues).

Best regards :)