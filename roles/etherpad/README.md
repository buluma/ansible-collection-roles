# [etherpad](#etherpad)

Install and configure Etherpad on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-etherpad/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-etherpad/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-etherpad/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-etherpad)|[![quality](https://img.shields.io/ansible/quality/57893)](https://galaxy.ansible.com/buluma/etherpad)|[![downloads](https://img.shields.io/ansible/role/d/57893)](https://galaxy.ansible.com/buluma/etherpad)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-etherpad.svg)](https://github.com/buluma/ansible-role-etherpad/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  vars:
    etherpad_port: 9002

  roles:
    - role: buluma.etherpad
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
    - role: buluma.epel
    - role: buluma.npm
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for etherpad

etherpad_version: "1.8.16"

etherpad_installation_destination: /opt

etherpad_port: 9001
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-etherpad/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.npm](https://galaxy.ansible.com/buluma/npm)|[![Build Status GitHub](https://github.com/buluma/ansible-role-npm/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-npm/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-npm/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-npm)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-etherpad/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|bullseye|
|fedora|all|
|ubuntu|focal|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | Not idempotent on starting the service. |
| ubuntu | Your npm version "3.5.2" is too old. npm 3.10.x or higher is required. |
| amazonlinux | Failed to set execute bit on remote files |
| debian:testing | The repository 'https://deb.nodesource.com/node_10.x bullseye Release' does not have a Release file. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-etherpad/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
