module: bigip_selfip
short_description: Manage Self-IPs on a BIG-IP system
description:
  - Manage Self-IPs on a BIG-IP system
version_added: "2.2"
options:
  address:
    description:
      - The IP addresses for the new self IP. This value is ignored upon update
        as addresses themselves cannot be changed after they are created.
    required: False
    default: None
  allow_service:
    description:
      - Configure port lockdown for the Self IP. By default, the Self IP has a
        "default deny" policy. This can be changed to allow TCP and UDP ports
        as well as specific protocols. This list should contain C(protocol):C(port)
        values.
    required: False
    default: None
  name:
    description:
      - The self IP to create.
    required: True
    default: Value of C(address)
  netmask:
    description:
      - The netmasks for the self IP.
    required: True
  state:
    description:
      - The state of the variable on the system. When C(present), guarantees
        that the Self-IP exists with the provided attributes. When C(absent),
        removes the Self-IP from the system.
    required: False
    default: present
    choices:
      - absent
      - present
  traffic_group:
    description:
      - The traffic group for the self IP addresses in an active-active,
        redundant load balancer configuration.
    required: False
  vlan:
    description:
      - The VLAN that the new self IPs will be on.
    required: True
  route_domain:
    description:
        - The route domain id of the system.
          If none, id of the route domain will be "0" (default route domain)
    required: False
    default: none
    version_added: 2.3
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
  - Requires the netaddr Python package on the host.
extends_documentation_fragment: f5
requirements:
  - netaddr
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
'''

EXAMPLES = '''
- name: Create Self IP
  bigip_selfip:
      address: "10.10.10.10"
      name: "self1"
      netmask: "255.255.255.0"
      password: "secret"
      server: "lb.mydomain.com"
      user: "admin"
      validate_certs: "no"
      vlan: "vlan1"
  delegate_to: localhost

- name: Create Self IP with a Route Domain
  bigip_selfip:
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      validate_certs: "no"
      name: "self1"
      address: "10.10.10.10"
      netmask: "255.255.255.0"
      vlan: "vlan1"
      route_domain: "10"
      allow_service: "default"
  delegate_to: localhost

- name: Delete Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost

- name: Allow management web UI to be accessed on this Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
      allow_service:
          - "tcp:443"
  delegate_to: localhost

- name: Allow HTTPS and SSH access to this Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
      allow_service:
          - "tcp:443"
          - "tpc:22"
  delegate_to: localhost

- name: Allow all services access to this Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
      allow_service:
          - all
  delegate_to: localhost

- name: Allow only GRE and IGMP protocols access to this Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
      allow_service:
          - gre:0
          - igmp:0
  delegate_to: localhost

- name: Allow all TCP, but no other protocols access to this Self IP
  bigip_selfip:
      name: "self1"
      password: "secret"
      server: "lb.mydomain.com"
      state: "absent"
      user: "admin"
      validate_certs: "no"
      allow_service:
          - tcp:0
  delegate_to: localhost
'''
