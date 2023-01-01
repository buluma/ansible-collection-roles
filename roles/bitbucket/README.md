# [bitbucket](#bitbucket)

Ansible Role for Atlassian Bitbucket Installation

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-bitbucket/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bitbucket/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-bitbucket/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bitbucket)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/bitbucket)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/bitbucket)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.bitbucket
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - name: buluma.bootstrap
    - name: buluma.git
    - name: buluma.java
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---

# PostgreSQL JDBC release.
postgresql_jdbc_release: "42.3"

# PostgreSQL JDBC version.
postgresql_jdbc_version: "{{ _postgresql_jdbc_version[postgresql_jdbc_release] }}"

# PostgreSQL JDBC download details.
postgresql_jdbc_download: "{{ _postgresql_jdbc_download[postgresql_jdbc_version] }}"

# Bitbucket release.
bitbucket_release: "7.21"

# Bitbucket version.
bitbucket_version: "{{ _bitbucket_version[bitbucket_release] }}"

# Bitbucket download details.
bitbucket_download: "{{ _bitbucket_download[bitbucket_version] }}"

# Owner and group for Bitbucket.
bitbucket_owner: "bitbucket"
bitbucket_group: "bitbucket"

# Bitbucket home directory.
bitbucket_home: "/var/atlassian/application-data/bitbucket"

# Bitbucket installation directory.
bitbucket_catalina: "/opt/atlassian/bitbucket"

# JVM minimal and maximum memory usage.
bitbucket_jvm_minimum_memory: "2048m"
bitbucket_jvm_maximum_memory: "2048m"

# Proxy and context path setup.
bitbucket_catalina_connector_proxyname: ~
bitbucket_catalina_connector_proxyport: ~
bitbucket_catalina_connector_scheme: "http"
bitbucket_catalina_connector_secure: "false"
bitbucket_catalina_context_path: ~

# Atlassian Support recommended JVM arguments.
bitbucket_jvm_support_recommended_args: >-
  -Datlassian.plugins.enable.wait=300
  -XX:+UnlockExperimentalVMOptions
  -XX:+UseCGroupMemoryLimitForHeap
  -XX:MaxRAMFraction=1

# Session timeout (in mintues).
bitbucket_session_timeout: "120"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bitbucket/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bitbucket/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|all|
|opensuse|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-bitbucket/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-bitbucket/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
