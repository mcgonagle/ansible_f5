## Ansible 2.x Order of Variable Precedence

* role defaults
* inventory INI or script group vars
* inventory group_vars/all
* playbook group_vars/all
* inventory group_vars/*
* playbook group_vars/*
* inventory INI or script host vars
* inventory host_vars/*
* playbook host_vars/*
* host facts
* play vars
* play vars_prompt
* play vars_files
* role vars (defined in role/vars/main.yml)
* block vars (only for tasks in block)
* task vars (only for the task)
* role (and include_role) params
* include params
* include_vars
* set_facts / registered vars
* extra vars (always win precedence)
