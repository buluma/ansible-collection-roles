# [nomad](#nomad)

Install and configure Nomad.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-nomad/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nomad/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nomad/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nomad)|[![quality](https://img.shields.io/ansible/quality/58247)](https://galaxy.ansible.com/buluma/nomad)|[![downloads](https://img.shields.io/ansible/role/d/58247)](https://galaxy.ansible.com/buluma/nomad)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nomad.svg)](https://github.com/buluma/ansible-role-nomad/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.nomad
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.core_dependencies
    - role: buluma.hashicorp
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for nomad

# You can install nomad using a package in this role. If you have installed
# nomad manually, set this to `no`.
nomad_install_package: yes

# Set this to "yes" for a server.
nomad_server: yes

# Configuration items for the Nomad server
nomad_server_data_dir: /tmp/server
nomad_server_bind_addr: "0.0.0.0"
nomad_server_log_level: INFO

# How many servers and agents are expected?
nomad_server_bootstrap_expect: 1

# This this to "yes" for an agent.
nomad_agent: no

# Configuration items for the Nomad agent
nomad_agent_log_level: INFO
nomad_agent_data_dir: /tmp/agent
nomad_agent_name: "{{ inventory_hostname }}"

nomad_agent_servers:
  - name: "127.0.0.1"
    port: 4647
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nomad/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.hashicorp](https://galaxy.ansible.com/buluma/hashicorp)|[![Build Status GitHub](https://github.com/buluma/ansible-role-hashicorp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-hashicorp/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-hashicorp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-hashicorp)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nomad/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|bullseye|
|fedora|34, 35|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nomad/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
