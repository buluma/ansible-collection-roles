# [kibana](#kibana)

Kibana for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-kibana/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-kibana/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-kibana/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-kibana)|[![quality](https://img.shields.io/ansible/quality/54764)](https://galaxy.ansible.com/buluma/kibana)|[![downloads](https://img.shields.io/ansible/role/d/54764)](https://galaxy.ansible.com/buluma/kibana)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-kibana.svg)](https://github.com/buluma/ansible-role-kibana/pulls/)|

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

  roles:
    - role: buluma.elasticsearch
    - role: buluma.kibana

  post_tasks:
    - name: Ensure Kibana is running.
      ansible.builtin.uri:
        url: http://127.0.0.1:5601/login
        status_code: 200
      register: result
      until: result.status == 200
      retries: 60
      delay: 1
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
kibana_version: "7.x"

kibana_package: kibana
kibana_package_state: present

kibana_service_state: started
kibana_service_enabled: true

kibana_config_template: kibana.yml.j2
kibana_config_file_path: /etc/kibana/kibana.yml

kibana_server_port: 5601
kibana_server_host: "0.0.0.0"

kibana_elasticsearch_url: "http://localhost:9200"
kibana_elasticsearch_username: ""
kibana_elasticsearch_password: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-kibana/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-kibana/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.0, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-kibana/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
