# [restore](#restore)

The purpose of this role is to restore objects to your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-restore/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-restore/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-restore/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-restore)|[![quality](https://img.shields.io/ansible/quality/57953)](https://galaxy.ansible.com/buluma/restore)|[![downloads](https://img.shields.io/ansible/role/d/57953)](https://galaxy.ansible.com/buluma/restore)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-restore.svg)](https://github.com/buluma/ansible-role-restore/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-restore.svg)](https://github.com/buluma/ansible-role-restore/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-restore.svg)](https://github.com/buluma/ansible-role-restore/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.restore
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
    - role: buluma.mysql
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.postgres
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for restore

# What directory are the objects to be restored saved?
restore_directory: backups

# The directory of objects which need to be placed on the managed node
# temporarily.
restore_remote_directory: /tmp

# Credentials to login to the mysql database, only require when restoring mysql
# objects.
# restore_mysql_username: "my_user"
# restore_mysql_password: "my_pass"

# A list of objects to restore.
# Each list item should have:
# - name to find the object locally.
#   type, either directory or mysql.
#   destination, a directory where to unpack the object.
#
# Nota bene; the [backup role](http://galaxy.ansible.com/buluma/backup) can be used to create restorable objects. The objects created with this role include the parent directory, so the destination mentioned here ~misses~ the last part of the directory

restore_objects:
  - name: varspool
    type: directory
    destination: /var
#  - name: drupal
#    type: mysql
#    destination: drupal
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-restore/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.backup](https://galaxy.ansible.com/buluma/backup)|[![Build Status GitHub](https://github.com/buluma/ansible-role-backup/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-backup/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-backup/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-backup)|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.mysql](https://galaxy.ansible.com/buluma/mysql)|[![Build Status GitHub](https://github.com/buluma/ansible-role-mysql/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-mysql/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-mysql/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-mysql)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-buildtools/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-buildtools)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-python_pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-python_pip)|
|[buluma.postgres](https://galaxy.ansible.com/buluma/postgres)|[![Build Status GitHub](https://github.com/buluma/ansible-role-postgres/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-postgres/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-postgres/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-postgres)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-restore/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|all|
|opensuse|all|

The minimum version of Ansible required is 2.9, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| amazonlinux:1 | Testing mysql fails, because a dependecy (ansible-role-mysql) is not met. |
| alpine | Testing mysql fails, because a dependecy (ansible-role-mysql) is not met. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-restore/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-restore/blob/main/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
