# [logstash](#logstash)

Logstash for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-logstash/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-logstash/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-logstash/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-logstash)|[![quality](https://img.shields.io/ansible/quality/54974)](https://galaxy.ansible.com/buluma/logstash)|[![downloads](https://img.shields.io/ansible/role/d/54974)](https://galaxy.ansible.com/buluma/logstash)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-logstash.svg)](https://github.com/buluma/ansible-role-logstash/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-logstash.svg)](https://github.com/buluma/ansible-role-logstash/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-logstash.svg)](https://github.com/buluma/ansible-role-logstash/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    logstash_enabled_on_boot: false

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: Use Java 8 on Debian/Ubuntu.
      set_fact:
        java_packages:
          - openjdk-8-jdk
      when: ansible_os_family == 'Debian'

  roles:
    - buluma.java
    - buluma.elasticsearch
    - buluma.logstash
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
logstash_version: '7.x'

logstash_package: logstash

logstash_listen_port_beats: 5044

logstash_elasticsearch_hosts:
  - http://localhost:9200

logstash_local_syslog_path: /var/log/syslog
logstash_monitor_local_syslog: true

logstash_dir: /usr/share/logstash

logstash_ssl_dir: /etc/pki/logstash
logstash_ssl_certificate_file: ""
logstash_ssl_key_file: ""

logstash_enabled_on_boot: true

logstash_install_plugins:
  - logstash-input-beats
  - logstash-filter-multiline
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-logstash/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|
|[buluma.elasticsearch](https://galaxy.ansible.com/buluma/elasticsearch)|[![Build Status GitHub](https://github.com/buluma/ansible-role-elasticsearch/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-elasticsearch/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-elasticsearch/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-elasticsearch)|
|[buluma.logstash](https://galaxy.ansible.com/buluma/logstash)|[![Build Status GitHub](https://github.com/buluma/ansible-role-logstash/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-logstash/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-logstash/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-logstash)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-logstash/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-logstash/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-logstash/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
