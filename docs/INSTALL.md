# ansible_f5

## Overview

This repository provides the foundation for working with F5 devices and Ansible.
The architecture of the modules makes inherent use of the BIG-IP SOAP and REST
APIs as well as the tmsh API where required.

These modules are freely provided to the open source community for automating
BIG-IP device configurations using Ansible. Support for the modules is provided
on a best effort basis by the F5 community. Please file any bugs, questions or
enhancement requests using [Github Issues](https://github.com/F5Networks/f5-ansible/issues)

### Requirements

* [Ansible 2.2.0 or greater][installing]
* Advanced shell for user account enabled - Note this requierment it caught me and took me a while to realize.
* [bigsuds Python Client 1.0.4 or later][bigsuds]
* [f5-sdk Python Client, latest available][f5-sdk]

### Documentation
Pip does not come pre-installed on a mac. To install run 

```
sudo easy_install pip
sudo pip install --upgrade pip
```

Next, make sure virtualenv is installed.

```
pip install virtualenv
```

This will make available to you a virtualenv command. You can use that it make a virtual environment for your Ansible installation.

```
virtualenv ansible2
```

In your current working directory, you will find a new directory called ansible2. In this directory resides a copy of Python that is configured to install any modules inside of that local directory. Via this method, we can install Python modules without stomping on the system wide ones.

To use this new location, you must activate it.

```
. ansible2/bin/activate
```

You should see your prompt change so that the name of the virtualenv is prefixing the normal prompt. For example.

```
(ansible2) tom@tompro:~/Ansible/ansible-f5>
```

Now that our virtualenv is active, all future Python commands (such as pip) will install modules into the virtualenv. So let’s install the development copy of ansible.

```
pip install git+git://github.com/ansible/ansible.git@devel
```

You should be able to verify that you are running the new version of Ansible by using the –version argument to the ansible command, like so.

```
ansible --version
```

You should be presented with output that resembles the following

```
ansible --version
ansible 2.3.0
  config file =
  configured module search path = Default w/o overrides
```

I had to set the PYTHONPATH to find the bigsuds and suds modules.

```
export PYTHONPATH=/Users/tom/ansible2/lib/python2.7/site-packages 
```

I also had to set the **validate_certs: "false"** in my site.yml for each bigip module call. As of Python 2.7.9, python won't work with self signed certificates, which I use in my lab environment. 

Several of the BigIP ansible modules depend on Bigsuds, and or the Python F5-SDK. Make sure to install both via pip.

```
pip install bigsuds
pip install f5-sdk
```

## ansible-vault
```
sudo pip install ansible-vault
```

Create the ansible-vault file
```
ansible-vault create password.yml
```

Edit the ansible-vault file
```
ansible-vault edit password.yml
```
Contents of the ansible-vault file
```
    username: admin
    password: admin
```

Run the ansible-playbook command with the ansible-vault file 
```
ansible-playbook site.yml --ask-vault-pass -e @password.yml -vvv
```
ansible-vault password for file password.yml is ```password```


