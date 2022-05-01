# [spamassassin](#spamassassin)

Install and configure spamassassin on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-spamassassin/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-spamassassin/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-spamassassin/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-spamassassin)|[![quality](https://img.shields.io/ansible/quality/58664)](https://galaxy.ansible.com/buluma/spamassassin)|[![downloads](https://img.shields.io/ansible/role/d/58664)](https://galaxy.ansible.com/buluma/spamassassin)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-spamassassin.svg)](https://github.com/buluma/ansible-role-spamassassin/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-spamassassin.svg)](https://github.com/buluma/ansible-role-spamassassin/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-spamassassin.svg)](https://github.com/buluma/ansible-role-spamassassin/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.spamassassin
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
    - role: buluma.core_dependencies
    - role: buluma.cron
    - role: buluma.logrotate
      logrotate_entries:
        - name: spamassassin
          path: /var/log/spamassassin
          missingok: yes
    - role: buluma.rsyslog
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for spamassassin

# What group and user spamd should run under.
spamassassin_group: spamd
spamassassin_user: spamd
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-spamassassin/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|
|[buluma.logrotate](https://galaxy.ansible.com/buluma/logrotate)|[![Build Status GitHub](https://github.com/buluma/ansible-role-logrotate/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-logrotate/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-logrotate/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-logrotate)|
|[buluma.rsyslog](https://galaxy.ansible.com/buluma/rsyslog)|[![Build Status GitHub](https://github.com/buluma/ansible-role-rsyslog/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-rsyslog/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-rsyslog/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-rsyslog)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-spamassassin/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-spamassassin/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-spamassassin/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
