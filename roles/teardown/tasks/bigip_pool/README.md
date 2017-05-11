module: bigip_pool
short_description: "Manages F5 BIG-IP LTM pools"
description:
  - Manages F5 BIG-IP LTM pools via iControl SOAP API
version_added: 1.2
author:
  - Matt Hite (@mhite)
  - Tim Rupp (@caphrim007)
notes:
  - Requires BIG-IP software version >= 11
  - F5 developed module 'bigsuds' required (see http://devcentral.f5.com)
  - Best run as a local_action in your playbook
requirements:
  - bigsuds
options:
  description:
    description:
      - Specifies descriptive text that identifies the pool.
    required: false
    version_added: "2.3"
  state:
    description:
      - Pool/pool member state
    required: false
    default: present
    choices:
      - present
      - absent
    aliases: []
  name:
    description:
      - Pool name
    required: true
    default: null
    choices: []
    aliases:
      - pool
  partition:
    description:
      - Partition of pool/pool member
    required: false
    default: 'Common'
    choices: []
    aliases: []
  lb_method:
    description:
      - Load balancing method
    version_added: "1.3"
    required: False
    default: 'round_robin'
    choices:
      - round_robin
      - ratio_member
      - least_connection_member
      - observed_member
      - predictive_member
      - ratio_node_address
      - least_connection_node_address
      - fastest_node_address
      - observed_node_address
      - predictive_node_address
      - dynamic_ratio
      - fastest_app_response
      - least_sessions
      - dynamic_ratio_member
      - l3_addr
      - weighted_least_connection_member
      - weighted_least_connection_node_address
      - ratio_session
      - ratio_least_connection_member
      - ratio_least_connection_node_address
    aliases: []
  monitor_type:
    description:
      - Monitor rule type when monitors > 1
    version_added: "1.3"
    required: False
    default: null
    choices: ['and_list', 'm_of_n']
    aliases: []
  quorum:
    description:
      - Monitor quorum value when monitor_type is m_of_n
    version_added: "1.3"
    required: False
    default: null
    choices: []
    aliases: []
  monitors:
    description:
      - Monitor template name list. Always use the full path to the monitor.
    version_added: "1.3"
    required: False
    default: null
    choices: []
    aliases: []
  slow_ramp_time:
    description:
      - Sets the ramp-up time (in seconds) to gradually ramp up the load on
        newly added or freshly detected up pool members
    version_added: "1.3"
    required: False
    default: null
    choices: []
    aliases: []
  reselect_tries:
    description:
      - Sets the number of times the system tries to contact a pool member
        after a passive failure
    version_added: "2.2"
    required: False
    default: null
    choices: []
    aliases: []
  service_down_action:
    description:
      - Sets the action to take when node goes down in pool
    version_added: "1.3"
    required: False
    default: null
    choices:
      - none
      - reset
      - drop
      - reselect
    aliases: []
  host:
    description:
      - "Pool member IP"
    required: False
    default: null
    choices: []
    aliases:
      - address
  port:
    description:
      - Pool member port
    required: False
    default: null
    choices: []
    aliases: []
extends_documentation_fragment: f5
'''

EXAMPLES = '''
- name: Create pool
  bigip_pool:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      name: "my-pool"
      partition: "Common"
      lb_method: "least_connection_member"
      slow_ramp_time: 120
  delegate_to: localhost

- name: Modify load balancer method
  bigip_pool:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      name: "my-pool"
      partition: "Common"
      lb_method: "round_robin"

- name: Add pool member
  bigip_pool:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      name: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80

- name: Remove pool member from pool
  bigip_pool:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "absent"
      name: "my-pool"
      partition: "Common"
      host: "{{ ansible_default_ipv4["address"] }}"
      port: 80

- name: Delete pool
  bigip_pool:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "absent"
      name: "my-pool"
      partition: "Common"
