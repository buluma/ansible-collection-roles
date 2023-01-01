# [ssmtp](#ssmtp)

Install and configure SSMTP for Sending Mail.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ssmtp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ssmtp/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ssmtp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ssmtp)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/ssmtp)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/ssmtp)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ssmtp.svg)](https://github.com/buluma/ansible-role-ssmtp/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ssmtp.svg)](https://github.com/buluma/ansible-role-ssmtp/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ssmtp.svg)](https://github.com/buluma/ansible-role-ssmtp/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all

  roles:
    - role: buluma.ssmtp
      sansible_ssmtp_user: ssmtp_user
      sansible_ssmtp_group: ssmtp_group
      sansible_ssmtp_mailserver_host: localhost
      sansible_ssmtp_mailserver_password: swordfish
      sansible_ssmtp_mailserver_port: 25
      sansible_ssmtp_mailserver_username: john_doe
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no

  tasks:
    - name: Install Python for Ansible
      become: yes
      raw: test -e /usr/bin/python || (apt -y update && apt install -y python-minimal python-zipstream)
      changed_when: no

    - name: Install apt-transport-https, lsb-release, net-tools
      become: yes
      apt:
        name: "{{ item }}"
        update_cache: yes
      with_items:
        - apt-transport-https
        - lsb-release
        - net-tools
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ssmtp

sansible_ssmtp_auth: yes
sansible_ssmtp_group: ~
sansible_ssmtp_hostname: ''
sansible_ssmtp_mailserver_fromlineoverride: no
sansible_ssmtp_mailserver_host: ~
sansible_ssmtp_mailserver_password: ~
sansible_ssmtp_mailserver_port: ~
sansible_ssmtp_mailserver_rewritedomain: no
sansible_ssmtp_mailserver_root: no
sansible_ssmtp_mailserver_username: ~
sansible_ssmtp_restrict: yes
sansible_ssmtp_revaliases: yes
sansible_ssmtp_use_inventory_hostname: no
sansible_ssmtp_use_start_tls: true
sansible_ssmtp_use_tls: true
sansible_ssmtp_user: ~
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ssmtp/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ssmtp/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ssmtp/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ssmtp/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[your name](https://buluma.github.io/)
