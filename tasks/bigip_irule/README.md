module: bigip_irule
short_description: Manage iRules across different modules on a BIG-IP.
description:
  - Manage iRules across different modules on a BIG-IP.
version_added: "2.2"
options:
  content:
    description:
      - When used instead of 'src', sets the contents of an iRule directly to
        the specified value. This is for simple values, but can be used with
        lookup plugins for anything complex or with formatting. Either one
        of C(src) or C(content) must be provided.
  module:
    description:
      - The BIG-IP module to add the iRule to.
    required: true
    choices:
      - ltm
      - gtm
  partition:
    description:
      - The partition to create the iRule on.
    required: false
    default: Common
  name:
    description:
      - The name of the iRule.
    required: true
  src:
    description:
      - The iRule file to interpret and upload to the BIG-IP. Either one
        of C(src) or C(content) must be provided.
    required: true
  state:
    description:
      - Whether the iRule should exist or not.
    required: false
    default: present
    choices:
      - present
      - absent
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as
    pip install f5-sdk.
extends_documentation_fragment: f5
requirements:
  - f5-sdk
author:
  - Tim Rupp (@caphrim007)
'''

EXAMPLES = '''
- name: Add the iRule contained in template irule.tcl to the LTM module
  bigip_irule:
      content: "{{ lookup('template', 'irule.tcl') }}"
      module: "ltm"
      name: "MyiRule"
      password: "secret"
      server: "lb.mydomain.com"
      state: "present"
      user: "admin"
  delegate_to: localhost

- name: Add the iRule contained in static file irule.tcl to the LTM module
  bigip_irule:
      module: "ltm"
      name: "MyiRule"
      password: "secret"
      server: "lb.mydomain.com"
      src: "irule.tcl"
      state: "present"
      user: "admin"
  delegate_to: localhost
