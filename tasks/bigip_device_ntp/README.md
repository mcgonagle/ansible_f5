module: bigip_device_ntp
short_description: Manage NTP servers on a BIG-IP
description:
  - Manage NTP servers on a BIG-IP
version_added: "2.2"
options:
  ntp_servers:
    description:
      - A list of NTP servers to set on the device. At least one of C(ntp_servers)
        or C(timezone) is required.
    required: false
    default: []
  state:
    description:
      - The state of the NTP servers on the system. When C(present), guarantees
        that the NTP servers are set on the system. When C(absent), removes the
        specified NTP servers from the device configuration.
    required: false
    default: present
    choices:
      - absent
      - present
  timezone:
    description:
      - The timezone to set for NTP lookups. At least one of C(ntp_servers) or
        C(timezone) is required.
    default: UTC
    required: false
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
extends_documentation_fragment: f5
requirements:
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
'''

EXAMPLES = '''
- name: Set NTP server
  bigip_device_ntp:
      ntp_servers:
          - "192.0.2.23"
      password: "secret"
      server: "lb.mydomain.com"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost

- name: Set timezone
  bigip_device_ntp:
      password: "secret"
      server: "lb.mydomain.com"
      timezone: "America/Los_Angeles"
      user: "admin"
      validate_certs: "no"
  delegate_to: localhost
