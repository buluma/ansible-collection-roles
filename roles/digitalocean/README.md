# [digitalocean-agent](#digitalocean-agent)

Install digitalocean agent on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-digitalocean-agent/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-digitalocean-agent/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-digitalocean-agent/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-digitalocean-agent)|[![quality](https://img.shields.io/ansible/quality/59164)](https://galaxy.ansible.com/buluma/digitalocean-agent)|[![downloads](https://img.shields.io/ansible/role/d/59164)](https://galaxy.ansible.com/buluma/digitalocean-agent)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-digitalocean-agent.svg)](https://github.com/buluma/ansible-role-digitalocean-agent/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-digitalocean-agent.svg)](https://github.com/buluma/ansible-role-digitalocean-agent/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-digitalocean-agent.svg)](https://github.com/buluma/ansible-role-digitalocean-agent/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.digitalocean-agent
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.ca_certificates
    - role: buluma.apt_autostart
```



## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-digitalocean-agent/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.apt_autostart](https://galaxy.ansible.com/buluma/apt_autostart)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apt_autostart/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apt_autostart/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apt_autostart/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apt_autostart)|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-digitalocean-agent/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-digitalocean-agent/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-digitalocean-agent/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
