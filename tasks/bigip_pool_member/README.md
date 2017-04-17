module: bigip_pool_member
short_description: Manages F5 BIG-IP LTM pool members
description:
  - Manages F5 BIG-IP LTM pool members via iControl SOAP API
version_added: 1.4
author:
  - Matt Hite (@mhite)
  - Tim Rupp (@caphrim007)
notes:
  - Requires BIG-IP software version >= 11
  - F5 developed module 'bigsuds' required (see http://devcentral.f5.com)
  - Best run as a local_action in your playbook
  - Supersedes bigip_pool for managing pool members
requirements:
  - bigsuds
options:
  state:
    description:
      - Pool member state
    required: true
    default: present
    choices:
      - present
      - absent
  session_state:
    description:
      - Set new session availability status for pool member
    version_added: 2.0
    required: false
    default: null
    choices:
      - enabled
      - disabled
  monitor_state:
    description:
      - Set monitor availability status for pool member
    version_added: 2.0
    required: false
    default: null
    choices:
      - enabled
      - disabled
  pool:
    description:
      - Pool name. This pool must exist.
    required: true
  partition:
    description:
      - Partition
    required: false
    default: 'Common'
  host:
    description:
      - Pool member IP
    required: true
    aliases:
      - address
      - name
  port:
    description:
      - Pool member port
    required: true
  connection_limit:
    description:
      - Pool member connection limit. Setting this to 0 disables the limit.
    required: false
    default: null
  description:
    description:
      - Pool member description
    required: false
    default: null
  rate_limit:
    description:
      - Pool member rate limit (connections-per-second). Setting this to 0
        disables the limit.
    required: false
    default: null
  ratio:
    description:
      - Pool member ratio weight. Valid values range from 1 through 100.
        New pool members -- unless overridden with this value -- default
        to 1.
    required: false
    default: null
  preserve_node:
    description:
      - When state is absent and the pool member is no longer referenced
        in other pools, the default behavior removes the unused node
        o bject. Setting this to 'yes' disables this behavior.
    required: false
    default: 'no'
    choices:
      - yes
      - no
    version_added: 2.1
extends_documentation_fragment: f5
'''

EXAMPLES = '''
- name: Add pool member
  bigip_pool_member:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      pool: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80
      description: "web server"
      connection_limit: 100
      rate_limit: 50
      ratio: 2
  delegate_to: localhost

- name: Modify pool member ratio and description
  bigip_pool_member:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      pool: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80
      ratio: 1
      description: "nginx server"
  delegate_to: localhost

- name: Remove pool member from pool
  bigip_pool_member:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "absent"
      pool: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80
  delegate_to: localhost


# The BIG-IP GUI doesn't map directly to the API calls for "Pool ->
# Members -> State". The following states map to API monitor
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

- name: Force pool member offline
  bigip_pool_member:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      session_state: "disabled"
      monitor_state: "disabled"
      pool: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80
  delegate_to: localhost
