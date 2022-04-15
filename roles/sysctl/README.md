# [sysctl](#sysctl)

Configure sysctl on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-sysctl/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|[![quality](https://img.shields.io/ansible/quality/58001)](https://galaxy.ansible.com/buluma/sysctl)|[![downloads](https://img.shields.io/ansible/role/d/58001)](https://galaxy.ansible.com/buluma/sysctl)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-sysctl.svg)](https://github.com/buluma/ansible-role-sysctl/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.sysctl
      sysctl_items:
        - name: net.ipv4.ip_forward
          value: 1
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
# defaults file for sysctl

# Verify token value with the sysctl command and set with -w if necessary
sysctl_set: yes

# if yes, performs a /sbin/sysctl -p if the sysctl_file is updated.
# If no, does not reload sysctl even if the sysctl_file is updated
sysctl_reload: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-sysctl/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-sysctl/png/requirements.png "Dependencies")

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
| Alpine | directory /etc/security is not writable (check presence, access rights, use sudo) |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-sysctl/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
