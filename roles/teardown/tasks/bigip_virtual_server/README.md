module: bigip_virtual_server
short_description: "Manages F5 BIG-IP LTM virtual servers"
description:
  - "Manages F5 BIG-IP LTM virtual servers via iControl SOAP API"
version_added: "2.1"
author:
  - Etienne Carriere (@Etienne-Carriere)
  - Tim Rupp (@caphrim007)
notes:
  - "Requires BIG-IP software version >= 11"
  - "F5 developed module 'bigsuds' required (see http://devcentral.f5.com)"
  - "Best run as a local_action in your playbook"
requirements:
  - bigsuds
options:
  state:
    description:
      - Virtual Server state
      - Absent, delete the VS if present
      - C(present) (and its synonym enabled), create if needed the VS and set
        state to enabled
      - C(disabled), create if needed the VS and set state to disabled
    required: false
    default: present
    choices:
      - present
      - absent
      - enabled
      - disabled
    aliases: []
  partition:
    description:
      - Partition
    required: false
    default: 'Common'
  name:
    description:
      - Virtual server name
    required: true
    aliases:
      - vs
  destination:
    description:
      - Destination IP of the virtual server (only host is currently supported).
        Required when state=present and vs does not exist.
    required: true
    aliases:
      - address
      - ip
  port:
    description:
      - Port of the virtual server. Required when state=present and vs does
        not exist. If you specify a value for this field, it must be a number
        between 0 and 65535.
    required: false
    default: None
  all_profiles:
    description:
      - List of all Profiles (HTTP,ClientSSL,ServerSSL,etc) that must be used
        by the virtual server
    required: false
    default: None
  all_policies:
    description:
      - List of all policies enabled for the virtual server.
    required: false
    default: None
    version_added: "2.3"
  all_rules:
    version_added: "2.2"
    description:
      - List of rules to be applied in priority order
    required: false
    default: None
  enabled_vlans:
    version_added: "2.2"
    description:
      - List of vlans to be enabled. When a VLAN named C(ALL) is used, all
        VLANs will be allowed.
    required: false
    default: None
  pool:
    description:
      - Default pool for the virtual server
    required: false
    default: None
  snat:
    description:
      - Source network address policy
    required: false
    choices:
      - None
      - Automap
      - Name of a SNAT pool (eg "/Common/snat_pool_name") to enable SNAT with the specific pool
    default: None
  default_persistence_profile:
    description:
      - Default Profile which manages the session persistence
    required: false
    default: None
  fallback_persistence_profile:
    description:
      - Specifies the persistence profile you want the system to use if it
        cannot use the specified default persistence profile.
    required: false
    default: None
    version_added: "2.3"
  route_advertisement_state:
    description:
      - Enable route advertisement for destination
    required: false
    default: disabled
    version_added: "2.3"
  description:
    description:
      - Virtual server description
    required: false
    default: None
extends_documentation_fragment: f5
'''

EXAMPLES = '''
- name: Add virtual server
  bigip_virtual_server:
      server: lb.mydomain.net
      user: admin
      password: secret
      state: present
      partition: MyPartition
      name: myvirtualserver
      destination: "{{ ansible_default_ipv4['address'] }}"
      port: 443
      pool: "{{ mypool }}"
      snat: Automap
      description: Test Virtual Server
      all_profiles:
          - http
          - clientssl
      enabled_vlans:
          - /Common/vlan2
  delegate_to: localhost

- name: Modify Port of the Virtual Server
  bigip_virtual_server:
      server: lb.mydomain.net
      user: admin
      password: secret
      state: present
      partition: MyPartition
      name: myvirtualserver
      port: 8080
  delegate_to: localhost

- name: Delete virtual server
  bigip_virtual_server:
      server: lb.mydomain.net
      user: admin
      password: secret
      state: absent
      partition: MyPartition
      name: myvirtualserver
  delegate_to: localhost
'''
