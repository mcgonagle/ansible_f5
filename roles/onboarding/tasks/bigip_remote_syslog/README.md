module: bigip_remote_syslog
short_description: Manipulate remote syslog settings on a BIG-IP.
description:
  - Manipulate remote syslog settings on a BIG-IP.
version_added: 2.4
options:
  remote_host:
    description:
      - Specifies the IP address, or hostname, for the remote system to
        which the system sends log messages.
    required: True
  remote_port:
    description:
      - Specifies the port that the system uses to send messages to the
        remote logging server. The default is C(514) when the C(state)
        option is C(present).
    required: False
    default: None
  local_ip:
    description:
      - Specifies the local IP address of the system that is logging.
    required: False
    default: None
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
extends_documentation_fragment: f5
requirements:
    - f5-sdk >= 2.2.0
    - ansible >= 2.3.0
author:
    - Tim Rupp (@caphrim007)
'''

EXAMPLES = '''
- name: Add a remote syslog server to log to
  bigip_remote_syslog:
      remote_host: "10.10.10.10"
      password: "secret"
      server: "lb.mydomain.com"
      user: "admin"
      validate_certs: "false"
  delegate_to: localhost

- name: Add a remote syslog server on a non-standard port to log to
  bigip_remote_syslog:
      remote_host: "10.10.10.10"
      remote_port: "1234"
      password: "secret"
      server: "lb.mydomain.com"
      user: "admin"
      validate_certs: "false"
  delegate_to: localhost
