# [monasca-agent](#monasca-agent)

Installs the monasca-agent part of the Monasca project.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-monasca-agent/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-monasca-agent/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-monasca-agent/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-monasca-agent)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/monasca-agent)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/monasca-agent)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-monasca-agent.svg)](https://github.com/buluma/ansible-role-monasca-agent/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-monasca-agent.svg)](https://github.com/buluma/ansible-role-monasca-agent/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-monasca-agent.svg)](https://github.com/buluma/ansible-role-monasca-agent/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  tasks:
    - name: "Include buluma.monasca-agent"
      ansible.builtin.include_role:
        name: "buluma.nsswitch"
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# ©Copyright 2015 Hewlett-Packard Development Company, L.P.

monasca_checks: {}
monasca_agent_system_only: False
monasca_agent_custom_plugin_repos: []
monasca_agent_git_repo: https://git.openstack.org/openstack/monasca-agent
monasca_agent_systemd_unit_filename: monasca-agent.target
agent_reconfigure_script: /usr/local/bin/monasca-reconfigure
skip_install: False
monasca_virtualenv_dir: /opt/monasca
pip_conf_dir: ~/.pip
run_mode: Deploy
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-monasca-agent/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-monasca-agent/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|7, 8|

The minimum version of Ansible required is 1.2, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-monasca-agent/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-monasca-agent/blob/master/CHANGELOG.md)

## [License](#license)

Apache

## [Author Information](#author-information)

[Tim Kuhlman](https://buluma.github.io/)
