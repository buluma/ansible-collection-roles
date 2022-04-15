# [nfs](#nfs)

NFS installation for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-nfs/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-nfs/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-nfs/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-nfs)|[![quality](https://img.shields.io/ansible/quality/58767)](https://galaxy.ansible.com/buluma/nfs)|[![downloads](https://img.shields.io/ansible/role/d/58767)](https://galaxy.ansible.com/buluma/nfs)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-nfs.svg)](https://github.com/buluma/ansible-role-nfs/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-nfs.svg)](https://github.com/buluma/ansible-role-nfs/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-nfs.svg)](https://github.com/buluma/ansible-role-nfs/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.nfs
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---

- hosts: all
  roles:
    - name: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
nfs_exports: []

nfs_rpcbind_state: started
nfs_rpcbind_enabled: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-nfs/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-nfs/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-nfs/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
