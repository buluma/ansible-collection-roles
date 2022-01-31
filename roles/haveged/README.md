# [haveged](#haveged)

Install and configure haveged on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-haveged/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-haveged/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-haveged/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-haveged)|[![quality](https://img.shields.io/ansible/quality/23407)](https://galaxy.ansible.com/buluma/haveged)|[![downloads](https://img.shields.io/ansible/role/d/23407)](https://galaxy.ansible.com/buluma/haveged)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-haveged.svg)](https://github.com/buluma/ansible-role-haveged/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.haveged
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
    - role: buluma.epel
    - role: buluma.sysctl
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ansible-role-haveged

# Set write_wakeup_threshold of daemon interface to nnn bits.
haveged_write_wakeup_threshold: 1024
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-haveged/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.sysctl](https://galaxy.ansible.com/buluma/sysctl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-sysctl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-haveged/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| opensuse | Idempotency issue with start and enable haveged |
| ubuntu | Idempotency issue with start and enable haveged |
| amazonlinux | Dependency buluma.sysctl does not work. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-haveged/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
