HA onboarding of vCMP guests
============================
This is a role for onboarding a ha pair of vCMP guests. First the needed vlans will be configured on the hosts and the vCMP guests are deployed. 
Afterwards we will configure self-ip addresses, ntp, users, provision ASM, AFM and AVR and setup the HA pair.

This role is also able to handle a lost Guest system. This could be the case, when the host went down, or you erased the guest, because it was not well functioning. In this case you can select a new target host and restart the playbook to recover the missing guest in the HA setup. At the end, the configuration will be synced over and the HA pair is recovered.

Module Requirements
-------------------
f5-sdk
bigsuds
suds
deepdiff
requests
netaddr
parimkiko

BIG-IP vCMP host requironments
----------------------------
The iso images for the guest installation need to be already available on the target host. If you would like to upload a selected iso automatically, you need to manage a repository from which you can upload the images to the host.
The used trunk need to be configured and connected. Alternatively, you can use an interface.
The used tagged vlans need to be preconfigured on the switch site or the setup need to be added to the playbook.

hosts setup
-----------
Setup a group of BIG-IPs in the hosts file with the mgmt IPs of the devices of the ha-pair. This one will be handled as the master to build up the trust over it:

Example::
```
[vcmp-ha]
172.29.86.64
172.29.86.65
```

Variable setup of the Group
---------------------------

In the group_vars directory we create a file for the group to specify global vars for floating self IPs and device group name. The master will define the mgmt ip of the devise from which we will create the trust.
For the vCMP guest deployment we need additional to specify the installation image and the vlan parameters.

Example (group_vars/vcmp-ha):
```json
  ---
  master: "172.29.86.64"
  device_group_name: "main_dg"

  #image: "BIGIP-13.0.0.0.0.1645.iso"
  image: "BIGIP-12.1.2.0.0.249.iso"
  #image: "BIGIP-12.1.1.0.0.184.iso"
  hotfix: "none"

  # Vlans of the guest
  ext_vlan_name: "external_82"
  ext_vlan_tag: "82"
  int_vlan_name: "internal"
  int_vlan_tag: "10"
  ha_vlan_name: "ha"
  ha_vlan_tag: "112"

  # floating self ips
  ext_floating_self_ip: "172.29.82.60"
  int_floating_self_ip: "10.82.64.2"
  ...
```

Variable setup of the devices
-----------------------------
Example (host_vars/172.29.86.64):
```
  ---
  hostname: "RaB-ha-a.demo.local"
  vcmp_guest_name: "RaB_ha_a"

  mgmt_ip: "172.29.86.64"
  mgmt_net: "24"
  mgmt_gateway: "172.29.86.1"

  peer_host: "172.29.86.65"
  peer_hostname: "RaB-ha-b.demo.local"

  # Host information
  vcmp_host: "172.29.86.240"
  trunk_name: "1.1"
  cores_per_slot: "2"

  # IP Setting for the guest
  ext_self_ip: "172.29.82.64"
  ext_netmask: "255.255.255.0"
  ext_gateway: "172.29.82.1"
  int_self_ip: "10.82.64.1"
  int_netmask: "255.0.0.0"
  ha_self_ip: "1.1.1.64"
  ha_netmask: "255.255.255.0"
  ...
```

Example Playbook
----------------
```
    - hosts: vcmp-ha
      gather_facts: False
      roles:
        - vcmp_ha_operations
```

License
-------
Apache V2.0

Author Information
------------------
Ralf Bruenig (r.bruenig@f5.com)
