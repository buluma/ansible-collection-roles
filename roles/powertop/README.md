# [powertop](#powertop)

Install powertop on your system and optimize at boot.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-powertop/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-powertop/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-powertop/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-powertop)|[![quality](https://img.shields.io/ansible/quality/39345)](https://galaxy.ansible.com/buluma/powertop)|[![downloads](https://img.shields.io/ansible/role/d/39345)](https://galaxy.ansible.com/buluma/powertop)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-powertop.svg)](https://github.com/buluma/ansible-role-powertop/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.powertop
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

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.


## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-powertop/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-service/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-service)|

## [Dependencies](#dependencies)

Most roles require some kind of preparation, this is done in `molecule/default/prepare.yml`. This role has a "hard" dependency on the following roles:

- buluma.service
## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-powertop/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| EL | No package matching 'powertop' found available, installed or updated |
| amazonlinux:1 | No package matching 'powertop' found available, installed or updated |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-powertop/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
