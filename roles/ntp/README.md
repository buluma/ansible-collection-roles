# [ntp](#ntp)

Install and configure ntp on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-ntp/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ntp/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-ntp/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ntp)|[![quality](https://img.shields.io/ansible/quality/57978)](https://galaxy.ansible.com/buluma/ntp)|[![downloads](https://img.shields.io/ansible/role/d/57978)](https://galaxy.ansible.com/buluma/ntp)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ntp.svg)](https://github.com/buluma/ansible-role-ntp/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ntp.svg)](https://github.com/buluma/ansible-role-ntp/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ntp.svg)](https://github.com/buluma/ansible-role-ntp/pulls/)|

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

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ntp/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ntp/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|34|
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
| fedora:rawhide | Failed to find required executable "hwclock" in paths: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/lib/snapd/snap/bin |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-ntp/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-ntp/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
