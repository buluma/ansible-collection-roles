# [metricbeat](#metricbeat)

Install and configure Metricbeat, manage Metricbeat modules.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-metricbeat/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-metricbeat/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-metricbeat/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-metricbeat)|[![quality](https://img.shields.io/ansible/quality/58806)](https://galaxy.ansible.com/buluma/metricbeat)|[![downloads](https://img.shields.io/ansible/role/d/58806)](https://galaxy.ansible.com/buluma/metricbeat)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-metricbeat.svg)](https://github.com/buluma/ansible-role-metricbeat/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.metricbeat
      metricbeat_elasticsearch_password: "My-P@s5w0rd."
      metricbeat_modules:
        - name: system
          state: enabled
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
    - role: buluma.elastic_repo
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for metricbeat

# The version of metricbeat to install.
metricbeat_version: "7.15.2"

# A list of modules to enable.
metricbeat_modules: []

# A list of elasticsearch hosts.
metricbeat_elasticsearch_hosts:
  - "http://localhost:9200"

# The username for elasticsearch.
metricbeat_elasticsearch_username: elastic

# The password for elasticsearch.
metricbeat_elasticsearch_password: ""

# The URL for Kibana.
metricbeat_kibana_host: "http://localhost:5601"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-metricbeat/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.elastic_repo](https://galaxy.ansible.com/buluma/elastic_repo)|[![Build Status GitHub](https://github.com/buluma/ansible-role-elastic_repo/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-elastic_repo/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-elastic_repo/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-elastic_repo)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-metricbeat/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-metricbeat/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-metricbeat/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
