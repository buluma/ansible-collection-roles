# [aws_inspector](#aws_inspector)

AWS Inspector installation for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-aws_inspector/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-aws_inspector/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-aws_inspector/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-aws_inspector)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/aws_inspector)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/aws_inspector)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-aws_inspector.svg)](https://github.com/buluma/ansible-role-aws_inspector/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-aws_inspector.svg)](https://github.com/buluma/ansible-role-aws_inspector/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-aws_inspector.svg)](https://github.com/buluma/ansible-role-aws_inspector/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  vars:
    aws_inspector_role_test_mode: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false
  tasks:
    - name: "Include buluma.aws_inspector"
      ansible.builtin.include_role:
        name: "buluma.aws_inspector"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for aws_inspector

aws_inspector_url: "https://inspector-agent.amazonaws.com/linux/latest/install"
aws_inspector_installer_dest: /tmp/aws_inspector_agent_installer

awsagent_state: started
awsagent_enabled: true

aws_inspector_role_test_mode: false

aws_inspector_proxy_enabled: false
aws_inspector_https_proxy: 127.0.0.1:8080
aws_inspector_http_proxy: 127.0.0.1:8080
aws_inspector_no_proxy: 169.254.169.254
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-aws_inspector/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-aws_inspector/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-aws_inspector/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-aws_inspector/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
