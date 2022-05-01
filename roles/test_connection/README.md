# [test_connection](#test_connection)

Test connection possibilities to your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-test_connection/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-test_connection/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-test_connection/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-test_connection)|[![quality](https://img.shields.io/ansible/quality/57961)](https://galaxy.ansible.com/buluma/test_connection)|[![downloads](https://img.shields.io/ansible/role/d/57961)](https://galaxy.ansible.com/buluma/test_connection)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-test_connection.svg)](https://github.com/buluma/ansible-role-test_connection/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-test_connection.svg)](https://github.com/buluma/ansible-role-test_connection/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-test_connection.svg)](https://github.com/buluma/ansible-role-test_connection/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  gather_facts: no

  roles:
    - role: buluma.test_connection
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
# defaults file for test_connection

# What host to save the results to.
test_connection_report_host: localhost

# What directory to save results to.
test_connection_report_directory: /tmp

# The timeout to wait for a connection.
test_connection_timeout: 5
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-test_connection/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-test_connection/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-test_connection/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-test_connection/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
