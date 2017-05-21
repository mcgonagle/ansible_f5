# Installing Ansible

[Installing Ansible on a Mac Documentation](docs/INSTALL.md)

## Module Documentation

[To Do](docs/MODULES.md)

## Useful vimrc macro for editing YaML files
```
autocmd FileType yaml setlocal ai ts=2 sw=2 et colorcolumn=1,3,5,7,9,11,13 nu
```

## user_repos.json 
```
{
  "repos": [
    {
      "name":"mcgonagle-ansible_f5",
      "repo":"https://github.com/mcgonagle/ansible_f5.git",
      "branch":"master",
      "skip":false,
      "skipinstall":true
    }
  ]
}
```

## Running the Ansible Code
This Ansible code base comes with a shell helper script that runs the playbooks. 
```
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --all
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --onboarding
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --operation
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --teardown
```

## Ansible Vault
This code base leverages the ansible vault tool and includes an encrypted password protected file. 
To edit the username and password run:
```
ansible-vault edit password.yml
```
The password for the password file is *password*

## Ansible Roles
This ansible repository is organized into roles. Roles are collections of templates, files, tasks,
and variables. Tasks are organized based on the particular module they are implementing. For example,
the bigip_device_ntp module is a subdirectory under the onboarding role and has a task 
set_ntp.yml (*roles/tasks/bigip_device_ntp/set_ntp.yml*).

## Ansible Playbooks
The playbooks in in the ansible playbook directory include the roles.

## Ansible Library
Includes the BigIP Modules and distributes them for use. 

## Infrastructure as Code Principles, Practices and Patterns
[Infrastructure as Code Benefits](docs/IAC.md)
