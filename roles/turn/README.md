# [turn](#turn)

Install and configure a (co) turn server on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-turn/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-turn/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-turn/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-turn)|[![quality](https://img.shields.io/ansible/quality/57949)](https://galaxy.ansible.com/buluma/turn)|[![downloads](https://img.shields.io/ansible/role/d/57949)](https://galaxy.ansible.com/buluma/turn)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-turn.svg)](https://github.com/buluma/ansible-role-turn/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.turn
      turn_listening_ip: "0.0.0.0"
      turn_external_ip: "1.2.3.4"
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
    - role: buluma.epel
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for turn

turn_listening_port: 3478
turn_fingerprint: yes
turn_lt_cred_mech: no
turn_use_auth_secret: yes
turn_static_auth_secret: 96ef8dbed1ba36132d9cccfa608d1f90f879d7fb38cb5c18
turn_realm: nextcloud.meinit.nl
turn_total_quota: 100
turn_bps_quota: 0
turn_stale_nonce: 600
turn_no_loopback_peers: yes
turn_no_multicast_peers: yes
turn_simple_log: yes
turn_cli_password: 5S4QtTbkC2tzJj4jRKePZJlmCVU3ljnG
turn_server_name: "{{ ansible_fqdn }}"
turn_listening_ip: "{{ ansible_default_ipv4.address }}"
turn_external_ip: "{{ ansible_default_ipv4.address }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-turn/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-turn/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-turn/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
