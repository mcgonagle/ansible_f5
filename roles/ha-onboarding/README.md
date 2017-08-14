HA onboarding
=============
A role for onboarding an ha pair of F5 BigIP devices. 
Sets up a licensing, vlans, self-ip addresses, ntp, users, provision ASM, AFM and AVR and setup an HA pair of BIG-IPs

Requirements
------------
f5-sdk
bigsuds
suds
deepdiff
requests
netaddr
parimkiko

BIG-IP VE requirements
----------------------
Interface setup (all untagged):
1. mgmt vlan
2. external vlan
3. intrnal vlan
4. ha vlan

hosts setup
-----------
Setup a group of BIG-IPs in the hosts file and add one of the BIG-IPs in the master group list. this one will be handled as the master to build up the trust over it:

Example::
```
  [bigip-ha]
  10.10.86.30
  10.10.86.31
  [master]
  10.10.86.30
```

Variable setup of the Group
---------------------------
Example (group_vars/bigip-ha):
```json
  ---
  ext_floating_self_ip: "10.128.10.32"
  int_floating_self_ip: "10.10.10.32"
  device_group_name: "main_dg"
  ...
```

Variable setup of the master
----------------------------
Example (host_vars/10.10.86.30):
```
  ---
  mgmt_ip: 10.10.86.30

  license_key: "KIMDP-WTWAP-RXTXE-CZNAZ-PISRPAG"
  ext_self_ip: "10.128.10.30"
  ext_netmask: "255.255.255.0"

  int_self_ip: "10.10.10.30"
  int_netmask: "255.255.255.0"

  ha_self_ip: "1.1.1.30"
  ha_netmask: "255.255.255.0"

  hostname: "bigip-ha-a.demo.local"

  peer_host: "10.10.86.31"
  peer_hostname: "bigip-ha-b.demo.local"
  ...
```

Variable setup of the other BIG-IP in the cluster
-------------------------------------------------
Example (host_vars/10.10.86.31):
```
  ---
  mgmt_ip: 10.10.86.31

  license_key: "KIMDP-WTWAP-RXTXE-CZNAZ-PISRPAG"
  ext_self_ip: "10.128.10.31"
  ext_netmask: "255.255.255.0"

  int_self_ip: "10.10.10.31"
  int_netmask: "255.255.255.0"

  ha_self_ip: "1.1.1.31"
  ha_netmask: "255.255.255.0"

  hostname: "bigip-ha-b.demo.local"
  ...
```

Example Playbook
----------------
```
    - hosts: all
      gather_facts: False
      roles:
        - ha-operations
```

License
-------
Apache V2.0

Author Information
------------------
Ralf Bruenig (r.bruenig@f5.com)
