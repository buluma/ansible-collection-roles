# [hostname](#hostname)

Install dependencies and configure the hostname on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-hostname/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-hostname/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-hostname/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-hostname)|[![quality](https://img.shields.io/ansible/quality/58802)](https://galaxy.ansible.com/buluma/hostname)|[![downloads](https://img.shields.io/ansible/role/d/58802)](https://galaxy.ansible.com/buluma/hostname)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-hostname.svg)](https://github.com/buluma/ansible-role-hostname/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-hostname.svg)](https://github.com/buluma/ansible-role-hostname/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-hostname.svg)](https://github.com/buluma/ansible-role-hostname/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.hostname
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
# defaults file for hostname

# The hostname to set. By default whatever the inventory is set to.
hostname: "{{ inventory_hostname_short }}"

# Should the machine be rebooted when the hostname is changed?
hostname_reboot: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-hostname/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-hostname/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-hostname/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
