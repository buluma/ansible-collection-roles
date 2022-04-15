# [reboot](#reboot)

The purpose of this role is to well, reboot your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-reboot/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-reboot/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-reboot/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-reboot)|[![quality](https://img.shields.io/ansible/quality/57907)](https://galaxy.ansible.com/buluma/reboot)|[![downloads](https://img.shields.io/ansible/role/d/57907)](https://galaxy.ansible.com/buluma/reboot)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-reboot.svg)](https://github.com/buluma/ansible-role-reboot/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.reboot
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
# defaults file for reboot

# Some operating systems can determine if a reboot is required. This
# parameter can be set to always reboot.
reboot_always: no

# How long to wait before sending a reboot.
reboot_delay: 4

# Number of seconds to wait before checking if the machine is up.
reboot_up_delay: 8

# You can specify a message for rebooting, easier for auditing.
reboot_message: "Ansible role buluma.reboot initiated a reboot."
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-reboot/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-reboot/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-reboot/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
