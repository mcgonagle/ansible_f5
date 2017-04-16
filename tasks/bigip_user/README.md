module: bigip_user
short_description: Manage user accounts and user attributes on a BIG-IP.
description:
  - Manage user accounts and user attributes on a BIG-IP.
version_added: "2.2"
options:
  full_name:
    description:
      - Full name of the user.
    required: false
  username_credential:
    description:
      - Name of the user to create, remove or modify.
    required: true
    aliases:
      - name
  password_credential:
    description:
      - Set the users password to this unencrypted value.
        C(password_credential) is required when creating a new account.
    default: None
    required: false
  shell:
    description:
      - Optionally set the users shell.
    required: false
    default: None
    choices:
      - bash
      - none
      - tmsh
  partition_access:
    description:
      - Specifies the administrative partition to which the user has access.
        C(partition_access) is required when creating a new account.
        Should be in the form "partition:role". Valid roles include
        C(acceleration-policy-editor), C(admin), C(application-editor), C(auditor)
        C(certificate-manager), C(guest), C(irule-manager), C(manager), C(no-access)
        C(operator), C(resource-admin), C(user-manager), C(web-application-security-administrator),
        and C(web-application-security-editor). Partition portion of tuple should
        be an existing partition or the value 'all'.
    required: false
    default: None
    type: list
  state:
    description:
      - Whether the account should exist or not, taking action if the state is
        different from what is stated.
    required: false
    default: present
    choices:
      - present
      - absent
  update_password:
    description:
      - C(always) will allow to update passwords if the user chooses to do so.
        C(on_create) will only set the password for newly created users.
    required: false
    default: on_create
    choices:
      - always
      - on_create
notes:
   - Requires the requests Python package on the host. This is as easy as
     pip install requests
   - Requires BIG-IP versions >= 12.0.0
extends_documentation_fragment: f5
requirements:
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
  - Wojciech Wypior (@wojtek0806)
'''

EXAMPLES = '''
- name: Add the user 'johnd' as an admin
  bigip_user:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      username_credential: "johnd"
      password_credential: "password"
      full_name: "John Doe"
      partition_access: "all:admin"
      update_password: "on_create"
      state: "present"
  delegate_to: localhost

- name: Change the user "johnd's" role and shell
  bigip_user:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      username_credential: "johnd"
      partition_access: "NewPartition:manager"
      shell: "tmsh"
      state: "present"
  delegate_to: localhost

- name: Make the user 'johnd' an admin and set to advanced shell
  bigip_user:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      name: "johnd"
      partition_access: "all:admin"
      shell: "bash"
      state: "present"
  delegate_to: localhost

- name: Remove the user 'johnd'
  bigip_user:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      name: "johnd"
      state: "absent"
  delegate_to: localhost

- name: Update password
  bigip_user:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      username_credential: "johnd"
      password_credential: "newsupersecretpassword"
  delegate_to: localhost
'''
