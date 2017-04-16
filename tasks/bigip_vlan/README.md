hort_description: Manage VLANs on a BIG-IP system
description:
  - Manage VLANs on a BIG-IP system
version_added: "2.2"
options:
  description:
    description:
      - The description to give to the VLAN.
  tagged_interfaces:
    description:
      - Specifies a list of tagged interfaces and trunks that you want to
        configure for the VLAN. Use tagged interfaces or trunks when
        you want to assign a single interface or trunk to multiple VLANs.
    required: false
    aliases:
      - tagged_interface
  untagged_interfaces:
    description:
      - Specifies a list of untagged interfaces and trunks that you want to
        configure for the VLAN.
    required: false
    aliases:
      - untagged_interface
  name:
    description:
      - The VLAN to manage. If the special VLAN C(ALL) is specified with
        the C(state) value of C(absent) then all VLANs will be removed.
    required: true
  state:
    description:
      - The state of the VLAN on the system. When C(present), guarantees
        that the VLAN exists with the provided attributes. When C(absent),
        removes the VLAN from the system.
    required: false
    default: present
    choices:
      - absent
      - present
  tag:
    description:
      - Tag number for the VLAN. The tag number can be any integer between 1
        and 4094. The system automatically assigns a tag number if you do not
        specify a value.
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
  - Requires BIG-IP versions >= 12.0.0
extends_documentation_fragment: f5
requirements:
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
  - Wojciech Wypior (@wojtek0806)
'''

EXAMPLES = '''
- name: Create VLAN
  bigip_vlan:
      name: "net1"
      password: "secret"
      server: "lb.mydomain.com"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost

- name: Set VLAN tag
  bigip_vlan:
      name: "net1"
      password: "secret"
      server: "lb.mydomain.com"
      tag: "2345"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost

- name: Add VLAN 2345 as tagged to interface 1.1
  bigip_vlan:
      tagged_interface: 1.1
      name: "net1"
      password: "secret"
      server: "lb.mydomain.com"
      tag: "2345"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost

- name: Add VLAN 1234 as tagged to interfaces 1.1 and 1.2
  bigip_vlan:
      tagged_interfaces:
          - 1.1
          - 1.2
      name: "net1"
      password: "secret"
      server: "lb.mydomain.com"
      tag: "1234"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost
'''
