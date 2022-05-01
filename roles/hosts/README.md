# [hosts](#hosts)

Ansible role that dynamically creates the hosts file.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-hosts/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-hosts/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-hosts/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-hosts)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/hosts)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/hosts)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-hosts.svg)](https://github.com/buluma/ansible-role-hosts/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-hosts.svg)](https://github.com/buluma/ansible-role-hosts/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-hosts.svg)](https://github.com/buluma/ansible-role-hosts/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.hosts
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for buluma.hosts

# Path to the host file on the target system.
hosts_file: /etc/hosts

# Backup the hosts file before changing it.
hosts_backup: false

# Group owner of hosts file.
hosts_group: root

# Owner of hosts file.
hosts_owner: root

# Settings for SElinux.
hosts_serole: object_r
hosts_setype: net_conf_t
hosts_seuser: system_u
hosts_selevel: s0

# Access permission hosts file.
hosts_mode: 0644

# Creates a 172.0.0.1 entry for the server name.
hosts_hostname_loopback: true

# Inserts all hosts in the Ansible Inventory
# file into the Hosts file
hosts_inventory_to_hosts: false

# If this option and the hosts_inventory_to_hosts is enabled it writes all private ip addresses from the inventory into the hosts
hosts_all_private: true

# If this option and the hosts_inventory_to_hosts is enabled it writes all public ip addresses from the inventory into the hosts.
hosts_all_public: false

# Ipv6 localhost entries are set automatically.
# Setting false it can be prevented.
hosts_ipv6: true

# Set ipv4 address (could be override by what you want)
hosts_ipv4_address: "{{ hostvars[inventory_hostname]['ansible_default_ipv4']['address'] }}"

# List of network cards that should not be added to the hosts file.
hosts_exludes_interfaces:
  - 'vet*'
  - 'docker'
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-hosts/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-hosts/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-hosts/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-hosts/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
