operations
=========
A role for operating an F5 BigIP device. Sets up nodes, pools, adds nodes to pools, vips, iRules and iApps.

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
### bigip_node
* host="10.0.2.167"
* name="member1"
* monitor="/Common/icmp"

### bigip_pool
* name="pool1"
* monitor="/Common/http_head_f5"

### bigip_pool_member
* host="member1"
* pool="pool1"
* port="8080"

### big_virtual_server
* description="foo-vip"
* destination="10.0.2.183"
* name="foo-vip"
* destination="10.0.2.183"
* name="vip1"
* pool="pool1"
* port="80"
* snat="Automap"
* all_profiles="http"
* all_rules="Bodgeit_Rewrite"

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
