# [firewall](#firewall)

Manage firewall ports on all (known) Linux operating systems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-firewall/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-firewall/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-firewall/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-firewall)|[![quality](https://img.shields.io/ansible/quality/54976)](https://galaxy.ansible.com/buluma/firewall)|[![downloads](https://img.shields.io/ansible/role/d/54976)](https://galaxy.ansible.com/buluma/firewall)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-firewall.svg)](https://github.com/buluma/ansible-role-firewall/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-firewall.svg)](https://github.com/buluma/ansible-role-firewall/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-firewall.svg)](https://github.com/buluma/ansible-role-firewall/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.firewall
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
# defaults file for firewall

# If you don't specify a protocol in `firewall_services`, fall back to this.
firewall_default_protocol: tcp

# If you don't specify a rule in `firewall_services`, fall back to this.
firewall_default_rule: allow

# A list of service to allow traffic to.
firewall_services:
  - name: ssh

# A bit more difficult example:
# firewall_services:
#   - name: ssh
#   - name: https
#   - name: 5353
#     protocol: udp
#   - name: 1234
#     protocol: tcp
#   - name: 1337
#     state: absent
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-firewall/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-firewall/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-firewall/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-firewall/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
