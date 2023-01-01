# [bind](#bind)

Setup ISC BIND as an authoritative DNS server for one or more domains (primary and/or secondary).

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-bind/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bind/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-bind/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bind)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/bind)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/bind)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bind.svg)](https://github.com/buluma/ansible-role-bind/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bind.svg)](https://github.com/buluma/ansible-role-bind/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bind.svg)](https://github.com/buluma/ansible-role-bind/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.bind"
      ansible.builtin.include_role:
        name: "buluma.bind"
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for bind

# List of zones for which this name server is authoritative
bind_zones: []

# List of acls.
bind_acls: []

# Key binding for secondary servers
bind_dns_keys: []
#  - name: primary_key
#    algorithm: hmac-sha256
#    secret: "azertyAZERTY123456"

# List of IPv4 address of the network interface(s) to listen on. Set to "any"
# to listen on all interfaces
bind_listen_ipv4:
  - "127.0.0.1"

# The list of ports to listen on for IPv4 addresses
bind_listen_ipv4_port:
  - 53

# List of IPv6 address of the network interface(s) to listen on.
bind_listen_ipv6:
  - "::1"

# The list of ports to listen on for IPv6 addresses
bind_listen_ipv6_port:
  - 53

# List of hosts that are allowed to query this DNS server.
bind_allow_query:
  - "localhost"

# A key-value list mapping server-IPs to TSIG keys for signing requests
bind_key_mapping: {}

# Determines whether recursion should be allowed. Typically, an authoritative
# name server should have recursion turned OFF.
bind_recursion: false
bind_allow_recursion:
  - "any"

# Allows BIND to be set up as a caching name server
bind_forward_only: false

# List of name servers to forward DNS requests to.
bind_forwarders: []

# DNS round robin order (random or cyclic)
bind_rrset_order: "random"

# statistics channels configuration
bind_statistics_channels: false
bind_statistics_port: 8053
bind_statistics_host: 127.0.0.1
bind_statistics_allow:
  - "127.0.0.1"

# DNSSEC configuration
bind_dnssec_enable: true
bind_dnssec_validation: true

bind_extra_include_files: []

# SOA information
bind_zone_ttl: "1W"
bind_zone_time_to_refresh: "1D"
bind_zone_time_to_retry: "1H"
bind_zone_time_to_expire: "1W"
bind_zone_minimum_ttl: "1D"

# File mode for primary zone files (needs to be something like 0660 for dynamic updates)
bind_zone_file_mode: "0640"

# DNS64 support
bind_dns64: false
bind_dns64_clients:
  - "any"

# Set Python version
bind_python_version: "{{ bind_default_python_version }}"

# Log file
bind_log: "data/named.run"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bind/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.sysctl](https://galaxy.ansible.com/buluma/sysctl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-sysctl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bind/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|
|el|all|
|ubuntu|all|

The minimum version of Ansible required is 2.1o, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-bind/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-bind/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
