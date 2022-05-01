# [backup](#backup)

The purpose of this role is to make backups of your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-backup/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-backup/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-backup/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-backup)|[![quality](https://img.shields.io/ansible/quality/58021)](https://galaxy.ansible.com/buluma/backup)|[![downloads](https://img.shields.io/ansible/role/d/58021)](https://galaxy.ansible.com/buluma/backup)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-backup.svg)](https://github.com/buluma/ansible-role-backup/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-backup.svg)](https://github.com/buluma/ansible-role-backup/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-backup.svg)](https://github.com/buluma/ansible-role-backup/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.backup
      backup_cleanup: no
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
    - role: buluma.mysql
      mysql_databases:
        - name: test_db
          encoding: utf8
          collation: utf8_bin
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.postgres
      postgres_databases:
        - name: test_db
          state: present
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for backup

# The directory on the Ansible controller where to store backups.
backup_directory: backups

# The directory on the Ansible managed node where to temporarily store backups.
backup_remote_directory: /tmp

# Cleanup files created on the {{ backup_remote_directory }} when done?
backup_cleanup: yes

# What timestamp format to use when saving files.
backup_timestamp: "{{ ansible_date_time.date }}"

# What compression type to use, choose from bz2, tar, xz or zip
backup_format: zip

backup_objects:
  - name: varspool
    type: directory
    source: /var/spool
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-backup/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.postgres](https://galaxy.ansible.com/buluma/postgres)|[![Build Status GitHub](https://github.com/buluma/ansible-role-postgres/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-postgres/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-postgres/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-postgres)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-backup/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|all|
|opensuse|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| amazonlinux:1 | Testing mysql fails, because a dependecy (ansible-role-mysql) is not met. |
| alpine | Testing mysql fails, because a dependecy (ansible-role-mysql) is not met. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-backup/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-backup/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
