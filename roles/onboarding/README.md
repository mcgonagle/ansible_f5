onboarding
=========
A role for onboarding an F5 BigIP device. 
Sets up a licensing, vlans, self-ip addresses, ntp, users, partitions, snmp, and provision ASM.

Requirements
------------
f5-sdk
bigsuds
suds
deepdiff
requests
netaddr
parimkiko

Role Variables
--------------
### bigip_license
* key = "TNCDO-GRKLJ-HVWUT-XCGTD-EFJJFNQ"

### bigip_vlan
* name = "external"
* untagged_interface = "1.1"

### bigip_selfip
* name = "10.0.1.10"
* address = "10.0.1.10"
* netmask = "255.255.255.0"
* vlan_name = "external"
* route_domain = "0"
* traffic_group = "traffic-group-local-only"

### bigip_device_ntp
* ntp_server1 = "time.apple.com"
* ntp_server2 = "time.nist.gov"

### bigip_device_ntp
* timezone = "America/New_York"

### bigip_user
* username_credential = "tom"
* password_credential = "password"
* full_name = "Thomas A. McGonagle"
* partition_access = "all:admin"
* update_password = "on_create"

### bigip_partition
* name = "foo"

### bigip_snmp_trap
* name = "trap"
* community = "community"
* destination = "trap.localdomain"
* snmp_version = "2c"

### bigip_provision
* module = "asm"
* level = "nominal"

Dependencies
------------
None

Example Playbook
----------------
    - hosts: all
      gather_facts: False
      roles:
        - operations

License
-------
Apache V2.0

Author Information
------------------
Thomas A. McGonagle (t.mcgonagle@f5.com)
