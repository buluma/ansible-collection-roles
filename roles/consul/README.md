# [consul](#consul)

Install and configure consul on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-consul/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-consul/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-consul/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-consul)|[![quality](https://img.shields.io/ansible/quality/57874)](https://galaxy.ansible.com/buluma/consul)|[![downloads](https://img.shields.io/ansible/role/d/57874)](https://galaxy.ansible.com/buluma/consul)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-consul.svg)](https://github.com/buluma/ansible-role-consul/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-consul.svg)](https://github.com/buluma/ansible-role-consul/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-consul.svg)](https://github.com/buluma/ansible-role-consul/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.consul
      consul_bootstrap_expect: 1
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
    - role: buluma.core_dependencies
    - role: buluma.hashicorp
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for consul

# You can install consul using a package in this role. If you have installed
# consul manually, set this to `no`.
consul_install_package: yes

# This flag controls the datacenter in which the agent is running.
consul_datacenter: dc1

# This flag provides a data directory for the agent to store state.
consul_data_dir: /opt/consul

# The address to which Consul will bind client interfaces, including the HTTP and DNS servers
consul_client_addr: "0.0.0.0"

# Enables the built-in web UI server and the required HTTP routes.
consul_ui: yes

# This flag is used to control if an agent is in server or client mode.
consul_server: yes

# This flag provides the number of expected servers in the datacenter.
# consul_bootstrap_expect: 3

# Specifies the secret key to use for encryption of Consul network traffic.
# consul_encrypt: "GEZzRM+2P+FiUcyrx9Fte8NbwtTlX3NA"

# Similar to -join but allows retrying a join until it is successful.
# consul_retry_join:
#   - consul.domain.internal

# The address that should be bound to for internal cluster communications.
# consul_bind_addr: "{{ ansible_default_ipv4.address }}"

# The advertise address is used to change the address that we advertise to other nodes in the cluster.
# consul_advertise_addr: "{{ ansible_default_ipv4.address }}"

# You can define service that Consul should manage.
# consul_services:
#   - name: web
#     tags:
#       - rails
#     port: 80
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-consul/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.hashicorp](https://galaxy.ansible.com/buluma/hashicorp)|[![Build Status GitHub](https://github.com/buluma/ansible-role-hashicorp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-hashicorp/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-hashicorp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-hashicorp)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-consul/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|debian|bullseye|
|el|all|
|fedora|34, 35|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-consul/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-consul/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
