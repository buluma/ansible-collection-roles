# [erlang](#erlang)

Install and configure erlang on your systems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-erlang/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-erlang/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-erlang/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-erlang)|[![quality](https://img.shields.io/ansible/quality/59572)](https://galaxy.ansible.com/buluma/erlang)|[![downloads](https://img.shields.io/ansible/role/d/59572)](https://galaxy.ansible.com/buluma/erlang)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-erlang.svg)](https://github.com/buluma/ansible-role-erlang/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-erlang.svg)](https://github.com/buluma/ansible-role-erlang/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-erlang.svg)](https://github.com/buluma/ansible-role-erlang/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.erlang"
      ansible.builtin.include_role:
        name: "buluma.erlang"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for erlang
erlang_ppa_repo: 'deb http://packages.erlang-solutions.com/{{ ansible_distribution | lower }} {{ ansible_distribution_release | lower }} contrib'
erlang_ppa_key: 'http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc'
erlang_ppa_key_id: 'A14F4FCA'
erlang_rpm_key: 'http://packages.erlang-solutions.com/rpm/erlang_solutions.asc'
erlang_yum_repo_path: '/etc/yum.repos.d'
erlang_yum_repo_name: 'Centos $releasever - $basearch - Erlang Solutions'
erlang_yum_repo_baseurl: 'http://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch'
erlang_yum_repo_gpgcheck: '1'
erlang_yum_repo_enabled: '1'
erlang_packages:
  - erlang
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-erlang/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-erlang/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|7, 8|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-erlang/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-erlang/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
