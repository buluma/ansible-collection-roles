# [go](#go)

Go (language) installation for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-go/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-go/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-go/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-go)|[![quality](https://img.shields.io/ansible/quality/59163)](https://galaxy.ansible.com/buluma/go)|[![downloads](https://img.shields.io/ansible/role/d/59163)](https://galaxy.ansible.com/buluma/go)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-go.svg)](https://github.com/buluma/ansible-role-go/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-go.svg)](https://github.com/buluma/ansible-role-go/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-go.svg)](https://github.com/buluma/ansible-role-go/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.go

  tasks:
    - name: verify that Go is installed and available in the $PATH.
      command: go version
      environment:
        PATH: /usr/local/go/bin:{{ ansible_env.PATH }}
      changed_when: false
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
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
go_version: "1.17.3"
go_platform: linux
go_arch: amd64
go_tarball: go{{ go_version }}.{{ go_platform }}-{{ go_arch }}.tar.gz
go_download_url: https://dl.google.com/go/{{ go_tarball }}
go_checksum: '550f9845451c0c94be679faf116291e7807a8d78b43149f9506c1b15eb89008c'
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-go/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-go/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|all|
|amazon|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-go/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-go/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
