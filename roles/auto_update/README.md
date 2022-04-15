# [auto_update](#auto_update)

Install and configure automatic package updates on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-auto_update/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-auto_update/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-auto_update/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-auto_update)|[![quality](https://img.shields.io/ansible/quality/57875)](https://galaxy.ansible.com/buluma/auto_update)|[![downloads](https://img.shields.io/ansible/role/d/57875)](https://galaxy.ansible.com/buluma/auto_update)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-auto_update.svg)](https://github.com/buluma/ansible-role-auto_update/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-auto_update.svg)](https://github.com/buluma/ansible-role-auto_update/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr/buluma/ansible-role-auto_update.svg)](https://github.com/buluma/ansible-role-auto_update/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.auto_update
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for auto_update

# (RedHat like systems only) What type of updates to apply, valid choices are:
# default, security, security-severity:Critial, minimal, minimal-security, minimal-security-severity:Critical
auto_update_update_cmd: default

# (RedHat like systems only) Whether a message should be emitted when updates are available, were downloaded, or applied.
auto_update_message: no

# Whether updates should be downloaded when they are available.
auto_update_download_updates: yes

# Whether updates should be applied when they are available.  Note
# that download_updates must also be yes for the update to be applied.
auto_update_apply_updates: no

# Maximum amout of time to randomly sleep, in minutes.
auto_update_random_sleep: 360
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-auto_update/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-auto_update/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-auto_update/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
