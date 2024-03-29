# [fail2ban](#fail2ban)

Install and configure fail2ban on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-fail2ban/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-fail2ban/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-fail2ban/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-fail2ban)|[![quality](https://img.shields.io/ansible/quality/57895)](https://galaxy.ansible.com/buluma/fail2ban)|[![downloads](https://img.shields.io/ansible/role/d/57895)](https://galaxy.ansible.com/buluma/fail2ban)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-fail2ban.svg)](https://github.com/buluma/ansible-role-fail2ban/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-fail2ban.svg)](https://github.com/buluma/ansible-role-fail2ban/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-fail2ban.svg)](https://github.com/buluma/ansible-role-fail2ban/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.fail2ban
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
    - role: buluma.epel
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for fail2ban

fail2ban_loglevel: INFO
fail2ban_logtarget: /var/log/fail2ban.log

fail2ban_ignoreself: "true"
fail2ban_ignoreips: "127.0.0.1/8 ::1"

# In seconds
fail2ban_bantime: 600
fail2ban_findtime: 600

fail2ban_maxretry: 5
fail2ban_destemail: root@localhost
fail2ban_sender: root@{{ ansible_fqdn }}

fail2ban_configuration: []
#  - option: loglevel
#    value: "INFO"
#    section: Definition

fail2ban_jail_configuration: []
#  - option: ignoreself
#    value: "true"
#    section: DEFAULT

# Path to directory containing filters to copy in filter.d
# fail2ban_filterd_path:
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-fail2ban/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-fail2ban/png/requirements.png "Dependencies")

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
| alpine | Service `fail2ban' needs non existent service `logger' |
| amazonlinux:1 | Based on EL6, not supported since 2020 Q4. |
| opensuse | The package fail2ban depends on python2, we switched to python3. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-fail2ban/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-fail2ban/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
