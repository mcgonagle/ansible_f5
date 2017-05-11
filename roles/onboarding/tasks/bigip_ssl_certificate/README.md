module: bigip_ssl_certificate
short_description: Import/Delete certificates from BIG-IP
description:
  - This module will import/delete SSL certificates on BIG-IP LTM.
    Certificates can be imported from certificate and key files on the local
    disk, in PEM format.
version_added: 2.2
options:
  cert_content:
    description:
      - When used instead of 'cert_src', sets the contents of a certificate directly
        to the specified value. This is used with lookup plugins or for anything
        with formatting or templating. Either one of C(key_src),
        C(key_content), C(cert_src) or C(cert_content) must be provided when
        C(state) is C(present).
    required: false
  key_content:
    description:
      - When used instead of 'key_src', sets the contents of a certificate key
        directly to the specified value. This is used with lookup plugins or for
        anything with formatting or templating. Either one of C(key_src),
        C(key_content), C(cert_src) or C(cert_content) must be provided when
        C(state) is C(present).
    required: false
  state:
    description:
      - Certificate and key state. This determines if the provided certificate
        and key is to be made C(present) on the device or C(absent).
    required: true
    default: present
    choices:
      - present
      - absent
  partition:
    description:
      - BIG-IP partition to use when adding/deleting certificate.
    required: false
    default: Common
  name:
    description:
      - SSL Certificate Name.  This is the cert/key pair name used
        when importing a certificate/key into the F5. It also
        determines the filenames of the objects on the LTM
        (:Partition:name.cer_11111_1 and :Partition_name.key_11111_1).
    required: true
  cert_src:
    description:
      - This is the local filename of the certificate. Either one of C(key_src),
        C(key_content), C(cert_src) or C(cert_content) must be provided when
        C(state) is C(present).
    required: false
  key_src:
    description:
      - This is the local filename of the private key. Either one of C(key_src),
        C(key_content), C(cert_src) or C(cert_content) must be provided when
        C(state) is C(present).
    required: false
  passphrase:
    description:
      - Passphrase on certificate private key
    required: false
notes:
  - Requires the f5-sdk Python package on the host. This is as easy as pip
    install f5-sdk.
  - This module does not behave like other modules that you might include in
    roles where referencing files or templates first looks in the role's
    files or templates directory. To have it behave that way, use the Ansible
    file or template lookup (see Examples). The lookups behave as expected in
    a role context.
extends_documentation_fragment: f5
requirements:
    - f5-sdk >= 1.5.0
    - BIG-IP >= v12
author:
    - Tim Rupp (@caphrim007)
'''

EXAMPLES = '''
- name: Import PEM Certificate from local disk
  bigip_ssl_certificate:
      name: "certificate-name"
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      cert_src: "/path/to/cert.crt"
      key_src: "/path/to/key.key"
  delegate_to: localhost

- name: Use a file lookup to import PEM Certificate
  bigip_ssl_certificate:
      name: "certificate-name"
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "present"
      cert_content: "{{ lookup('file', '/path/to/cert.crt') }}"
      key_content: "{{ lookup('file', '/path/to/key.key') }}"
  delegate_to: localhost

- name: "Delete Certificate"
  bigip_ssl_certificate:
      name: "certificate-name"
      server: "lb.mydomain.com"
      user: "admin"
      password: "secret"
      state: "absent"
  delegate_to: localhost
'''

RETURN = '''
cert_name:
    description: The name of the certificate that the user provided
    returned:
        - created
    type: string
    sample: "cert1"
key_filename:
    description:
        - The name of the SSL certificate key. The C(key_filename) and
          C(cert_filename) will be similar to each other, however the
          C(key_filename) will have a C(.key) extension.
    returned:
        - created
    type: string
    sample: "cert1.key"
key_checksum:
    description: SHA1 checksum of the key that was provided.
    return:
        - changed
        - created
    type: string
    sample: "cf23df2207d99a74fbe169e3eba035e633b65d94"
key_source_path:
    description: Path on BIG-IP where the source of the key is stored
    return: created
    type: string
    sample: "/var/config/rest/downloads/cert1.key"
cert_filename:
    description:
        - The name of the SSL certificate. The C(cert_filename) and
          C(key_filename) will be similar to each other, however the
          C(cert_filename) will have a C(.crt) extension.
    returned:
        - created
    type: string
    sample: "cert1.crt"
cert_checksum:
    description: SHA1 checksum of the cert that was provided.
    return:
        - changed
        - created
    type: string
    sample: "f7ff9e8b7bb2e09b70935a5d785e0cc5d9d0abf0"
cert_source_path:
    description: Path on BIG-IP where the source of the certificate is stored.
    return: created
    type: string
    sample: "/var/config/rest/downloads/cert1.crt"
'''
