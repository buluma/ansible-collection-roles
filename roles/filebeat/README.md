# [filebeat](#filebeat)

Filebeat for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-filebeat/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-filebeat/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-filebeat/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-filebeat)|[![quality](https://img.shields.io/ansible/quality/54982)](https://galaxy.ansible.com/buluma/filebeat)|[![downloads](https://img.shields.io/ansible/role/d/54982)](https://galaxy.ansible.com/buluma/filebeat)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-filebeat.svg)](https://github.com/buluma/ansible-role-filebeat/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-filebeat.svg)](https://github.com/buluma/ansible-role-filebeat/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-filebeat.svg)](https://github.com/buluma/ansible-role-filebeat/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    - name: Install test dependencies (RedHat).
      package: name=which state=present
      when: ansible_os_family == 'RedHat'

    - name: Install test dependencies.
      package: name=curl state=present

    - name: Set the java_packages variable (Ubuntu).
      set_fact:
        java_packages:
          - openjdk-8-jdk
      when: ansible_distribution == 'Ubuntu'

  roles:
    - role: buluma.java
    - role: buluma.elasticsearch
    - role: buluma.logstash
    - role: buluma.filebeat
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
filebeat_version: 7.x
filebeat_package: filebeat
filebeat_package_state: present

filebeat_create_config: true
filebeat_template: "filebeat.yml.j2"

filebeat_inputs:
  - type: log
    paths:
      - "/var/log/*.log"

filebeat_output_elasticsearch_enabled: false
filebeat_output_elasticsearch_hosts:
  - "localhost:9200"

filebeat_output_logstash_enabled: true
filebeat_output_logstash_hosts:
  - "localhost:5044"

filebeat_enable_logging: false
filebeat_log_level: warning
filebeat_log_dir: /var/log/mybeat
filebeat_log_filename: mybeat.log

filebeat_ssl_dir: /etc/pki/logstash
filebeat_ssl_certificate_file: ""
filebeat_ssl_key_file: ""
filebeat_ssl_insecure: "false"

filebeat_elastic_cloud_enabled: false
filebeat_elastic_cloud_id: ""
filebeat_elastic_cloud_username: ""
filebeat_elastic_cloud_password: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-filebeat/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-java/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-java)|
|[buluma.elasticsearch](https://galaxy.ansible.com/buluma/elasticsearch)|[![Build Status GitHub](https://github.com/buluma/ansible-role-elasticsearch/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-elasticsearch/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-elasticsearch/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-elasticsearch)|
|[buluma.logstash](https://galaxy.ansible.com/buluma/logstash)|[![Build Status GitHub](https://github.com/buluma/ansible-role-logstash/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-logstash/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-logstash/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-logstash)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-filebeat/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-filebeat/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
