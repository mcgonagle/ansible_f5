module: bigip_node
short_description: "Manages F5 BIG-IP LTM nodes"
description:
  - "Manages F5 BIG-IP LTM nodes via iControl SOAP API"
version_added: "1.4"
author:
  - Matt Hite (@mhite)
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
      - Pool member state
    required: true
    default: present
    choices: ['present', 'absent']
    aliases: []
  session_state:
    description:
      - Set new session availability status for node
    version_added: "1.9"
    required: false
    default: null
    choices: ['enabled', 'disabled']
    aliases: []
  monitor_state:
    description:
      - Set monitor availability status for node
    version_added: "1.9"
    required: false
    default: null
    choices: ['enabled', 'disabled']
    aliases: []
  partition:
    description:
      - Partition
    required: false
    default: 'Common'
    choices: []
    aliases: []
  name:
    description:
      - "Node name"
    required: false
    default: null
    choices: []
  monitor_type:
    description:
      - Monitor rule type when monitors > 1
    version_added: "2.2"
    required: False
    default: null
    choices: ['and_list', 'm_of_n']
    aliases: []
  quorum:
    description:
      - Monitor quorum value when monitor_type is m_of_n
    version_added: "2.2"
    required: False
    default: null
    choices: []
    aliases: []
  monitors:
    description:
      - Monitor template name list. Always use the full path to the monitor.
    version_added: "2.2"
    required: False
    default: null
    choices: []
    aliases: []
  host:
    description:
      - "Node IP. Required when state=present and node does not exist. Error when state=absent."
    required: true
    default: null
    choices: []
    aliases: ['address', 'ip']
  description:
    description:
      - "Node description."
    required: false
    default: null
    choices: []
extends_documentation_fragment: f5
'''

EXAMPLES = '''
- name: Add node
  bigip_node:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      partition: "Common"
      host: "10.20.30.40"
      name: "10.20.30.40"

# Note that the BIG-IP automatically names the node using the
# IP address specified in previous play's host parameter.
# Future plays referencing this node no longer use the host
# parameter but instead use the name parameter.
# Alternatively, you could have specified a name with the
# name parameter when state=present.

- name: Add node with a single 'ping' monitor
  bigip_node:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      partition: "Common"
      host: "10.20.30.40"
      name: "mytestserver"
      monitors:
        - /Common/icmp
  delegate_to: localhost

- name: Modify node description
  bigip_node:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      partition: "Common"
      name: "10.20.30.40"
      description: "Our best server yet"
  delegate_to: localhost

- name: Delete node
  bigip_node:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "absent"
      partition: "Common"
      name: "10.20.30.40"

# The BIG-IP GUI doesn't map directly to the API calls for "Node ->
# General Properties -> State". The following states map to API monitor
# and session states.
#
# Enabled (all traffic allowed):
# monitor_state=enabled, session_state=enabled
# Disabled (only persistent or active connections allowed):
# monitor_state=enabled, session_state=disabled
# Forced offline (only active connections allowed):
# monitor_state=disabled, session_state=disabled
#
# See https://devcentral.f5.com/questions/icontrol-equivalent-call-for-b-node-down

- name: Force node offline
  bigip_node:
      server: "lb.mydomain.com"
      user: "admin"
      password: "mysecret"
      state: "present"
      session_state: "disabled"
      monitor_state: "disabled"
      partition: "Common"
      name: "10.20.30.40"
