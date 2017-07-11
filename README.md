## Installing Ansible

[Installing Ansible on a Mac Documentation](docs/INSTALL.md)

## YAML Syntax Overview

[YAML Syntax Overview](https://learn.getgrav.org/advanced/yaml)

## Module Documentation

[Ansible Module Documents Used in this Collection](docs/MODULES.md)

## Social Coding with Github

[![Social Coding with Github](https://img.youtube.com/vi/vTiINnsHSc4/0.jpg)](https://youtu.be/vTiINnsHSc4 "Social Coding with Github")


## Useful vimrc macro for editing YaML files
```
autocmd FileType yaml setlocal ai ts=2 sw=2 et colorcolumn=1,3,5,7,9,11,13 nu
```
### To turn off colorized lines
```
set cc=
```

## [user_repos.json](misc/user_repos.json)
```
{
  "repos": [
    {
      "name":"munich-ansible_f5",
      "repo":"https://github.com/rabru/ansible_f5.git",
      "branch":"munich",
      "skip":false,
      "skipinstall":true
    }
  ]
}
```

## [F5 Super NetOps/DevOps Tools Container](https://hub.docker.com/r/f5devcentral/f5-super-netops-container/)

```
docker run -p 8080:80 -p 2222:22 --rm -it -v /Users/mcgonagle/Dropbox/_F5/super-netops-ansible-container/user_repos.json:/tmp/user_repos.json -e SNOPS_GH_BRANCH=develop f5devcentral/f5-super-netops-container:develop-ansible
```

## Running the Ansible Code
This Ansible code base comes with a shell helper script that runs the playbooks. 
```
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --all
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --onboarding
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --operation
$ANSIBLE_HOME_DIRECTORY/run_ansible.sh --teardown
```

## Ansible Variable Precedence

[Ansible 2.x Order of Variable Precedence](docs/PRECEDENCE.md)

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

```
$ANSIBLE_HOME_DIRECTORY/site.yml
$ANSIBLE_HOME_DIRECTORY/playbooks/onboarding.yml
$ANSIBLE_HOME_DIRECTORY/playbooks/operation.yml
$ANSIBLE_HOME_DIRECTORY/playbooks/teardown.yml
$ANSIBLE_HOME_DIRECTORY/playbooks/today.yml
```

## Ansible Library
Includes the BigIP Modules and distributes them for use. 

[F5 Network's Ansible Modules](https://github.com/F5Networks/f5-ansible/tree/devel/library)

## Infrastructure as Code Principles, Practices and Patterns
[Infrastructure as Code Benefits](docs/IAC.md)

## License
### Apache V2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
