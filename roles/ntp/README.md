# [ntp](#ntp)

Install and configure ntp on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-ntp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ntp/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ntp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ntp)|[![quality](https://img.shields.io/ansible/quality/23988)](https://galaxy.ansible.com/buluma/ntp)|[![downloads](https://img.shields.io/ansible/role/d/23988)](https://galaxy.ansible.com/buluma/ntp)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ntp.svg)](https://github.com/buluma/ansible-role-ntp/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.cron
    - role: buluma.ntp
      ntp_state: stopped
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
```

Also see a [full explanation and example](https://buluma.co.ke/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for ntp

# The state of the NTP service.
ntp_state: started

# The state of the NTP service at boot.
ntp_enabled: yes

# A list of IP addresses to listen on.
ntp_interfaces:
  - address: "127.0.0.1"

# A list of NTP pools and their options.
ntp_pool:
  - name: "0.pool.ntp.org iburst"
  - name: "1.pool.ntp.org iburst"
  - name: "2.pool.ntp.org iburst"
  - name: "3.pool.ntp.org iburst"

# A list of NTP servers and their options.
# ntp_server:
#   - name: ntp.example.com
#     options:
#       - iburst

# The timezone.
ntp_timezone: Etc/UTC
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ntp/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ntp/png/requirements.png "Dependencies")

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

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| alpine | /lib/rc/sh/openrc-run.sh: line 100: can't create /sys/fs/cgroup/systemd/tasks: Read-only file system |
| opensuse | ConditionVirtualization=!container was not met |
| debian:buster | Unable to restart service ntp: Job for ntp.service failed because the control process exited with error code. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ntp/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.co.ke/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
