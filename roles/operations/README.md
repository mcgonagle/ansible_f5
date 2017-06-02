operations
=========

A role for operating an F5 BigIP device. Setups a nodes, pool, adds nodes to pools, vips, iRules and iApps.

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

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
