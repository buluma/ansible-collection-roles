# [checkmk_agent](#checkmk_agent)

Install the checkmk agent and a selection of plugins

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-checkmk_agent/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-checkmk_agent/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-checkmk_agent/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-checkmk_agent)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/checkmk_agent)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/checkmk_agent)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-checkmk_agent.svg)](https://github.com/buluma/ansible-role-checkmk_agent/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-checkmk_agent.svg)](https://github.com/buluma/ansible-role-checkmk_agent/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-checkmk_agent.svg)](https://github.com/buluma/ansible-role-checkmk_agent/pulls/)|

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
    - role: buluma.checkmk_agent
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
    - role: buluma.python_pip
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for checkmk_agent
checkmk_server: localhost
checkmk_site_name: cmk
checkmk_purge_xinetd: true
checkmk_pub_key: ''
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-checkmk_agent/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-checkmk_agent/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|debian|all|
|el|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-checkmk_agent/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-checkmk_agent/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
