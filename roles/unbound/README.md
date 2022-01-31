# [unbound](#unbound)

Install and configure unbound on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-unbound/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-unbound/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-unbound/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-unbound)|[![quality](https://img.shields.io/ansible/quality/45335)](https://galaxy.ansible.com/buluma/unbound)|[![downloads](https://img.shields.io/ansible/role/d/45335)](https://galaxy.ansible.com/buluma/unbound)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-unbound.svg)](https://github.com/buluma/ansible-role-unbound/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.unbound
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
    - role: buluma.buildtools
    - role: buluma.core_dependencies
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for unbound

# What version to download/install.
unbound_version: "1.13.2"

# Where to unpack unbound.
unbound_temporary_directory: /tmp

# The interface to listen on.
unbound_interface: "127.0.0.1"

# The port to listen on.
unbound_port: 53
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-unbound/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-unbound/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|34, 35|
|opensuse|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | Idempotence test failed: start and enable unbound |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-unbound/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
