# [common](#common)

The purpose of this role is to configure common things on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-common/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-common/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-common/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-common)|[![quality](https://img.shields.io/ansible/quality/57962)](https://galaxy.ansible.com/buluma/common)|[![downloads](https://img.shields.io/ansible/role/d/57962)](https://galaxy.ansible.com/buluma/common)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-common.svg)](https://github.com/buluma/ansible-role-common/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.common
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for common

# The selected hostname.
common_hostname: "{{ inventory_hostname }}"

# A list of nameservers to configure.
# common_nameservers:
#   - 1.1.1.1
#   - 1.0.0.1

# Fill /etc/hosts with all hosts in the play.
common_hosts: "{{ groups.all }}"

# Do you want to reboot on a hostname change?
common_reboot: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-common/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-common/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
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
| amazonlinux | set hostname: [Errno 2] No such file or directory: '/etc/sysconfig/network' |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-common/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
