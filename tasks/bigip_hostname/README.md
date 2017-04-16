module: bigip_hostname
short_description: Manage the hostname of a BIG-IP.
description:
  - Manage the hostname of a BIG-IP.
version_added: "2.3"
options:
  hostname:
    description:
      - Hostname of the BIG-IP host.
    required: true
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
extends_documentation_fragment: f5
requirements:
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
  - Matthew Lam (@mryanlam)
'''

EXAMPLES = '''
- name: Set the hostname of the BIG-IP
  bigip_hostname:
      hostname: "bigip.localhost.localdomain"
      password: "admin"
      server: "bigip.localhost.localdomain"
      user: "admin"
  delegate_to: localhost
