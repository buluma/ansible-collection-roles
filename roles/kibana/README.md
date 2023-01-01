# [kibana](#kibana)

Kibana for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-kibana/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-kibana/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-kibana/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-kibana)|[![quality](https://img.shields.io/ansible/quality/54764)](https://galaxy.ansible.com/buluma/kibana)|[![downloads](https://img.shields.io/ansible/role/d/54764)](https://galaxy.ansible.com/buluma/kibana)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.kibana
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
    - role: buluma.core_dependencies
    - role: robertdebock.elastic_repo
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Elastic offers both "oss" (Apache 2.0 license) and "elastic"
# (Elastic license). Select the type here. Either "oss" or "elastic"
kibana_type: oss

# The IP addres to bind on.
kibana_server_host: "0.0.0.0"

# The TCP port to bind on.
kibana_server_port: 5601

# A list of elasticsearch urls.
kibana_elasticsearch_hosts:
  - "http://localhost:9200"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-kibana/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[robertdebock.elasticsearch](https://galaxy.ansible.com/buluma/robertdebock.elasticsearch)|[![Build Status GitHub](https://github.com/buluma/robertdebock.elasticsearch/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/robertdebock.elasticsearch/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/robertdebock.elasticsearch/badges/master/pipeline.svg)](https://gitlab.com/buluma/robertdebock.elasticsearch)|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[robertdebock.elastic_repo](https://galaxy.ansible.com/buluma/robertdebock.elastic_repo)|[![Build Status GitHub](https://github.com/buluma/robertdebock.elastic_repo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/robertdebock.elastic_repo/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/robertdebock.elastic_repo/badges/master/pipeline.svg)](https://gitlab.com/buluma/robertdebock.elastic_repo)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-kibana/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|all|
|debian|all|
|el|7, 8|
|fedora|all|
|ubuntu|focal, bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-kibana/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-kibana/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
