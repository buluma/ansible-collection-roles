# [pg_partman](#pg_partman)

Install and configure Partition management extension for PostgreSQL.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-pg_partman/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-pg_partman/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-pg_partman/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-pg_partman)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/pg_partman)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/pg_partman)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-pg_partman.svg)](https://github.com/buluma/ansible-role-pg_partman/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-pg_partman.svg)](https://github.com/buluma/ansible-role-pg_partman/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-pg_partman.svg)](https://github.com/buluma/ansible-role-pg_partman/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.pg_partman

  # post_tasks:
  #   - name: Test if the PG_PARTMAN extensions have been enabled
  #     shell: psql -c "SELECT * FROM pg_extension;"
  #     args:
  #       executable: /bin/bash
  #     register: postgresql_plugin_list
  #     become: true
  #     become_user: postgres
  #     become_method: sudo
  #     changed_when: false
  #     failed_when:
  #       - '"pg_partman" not in postgresql_plugin_list.stdout'
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
    - role: buluma.postgres
      # postgres_major_version: 10
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for pg_partman

partman_postgresql_10_repo_url: https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
partman_schema: partman

partman_bgw_enabled: true

# Required. The database(s) that run_maintenance() will run on. If more than one, use a comma separated list. If not set, BGW will do nothing.
partman_bgw_dbname: postgres

# Number of seconds between calls to run_maintenance(). Default is 3600 (1 hour).
partman_bgw_interval: 3600

# The role that run_maintenance() will run as. Default is "postgres". Only a single role name is allowed.
partman_bgw_role: postgres

# Same purpose as the p_analyze argument to run_maintenance(). Set to 'on' for TRUE. Set to 'off' for FALSE. Default is 'on'.
partman_bgw_analyze: on

# Same purpose as the p_jobmon argument to run_maintenance(). Set to 'on' for TRUE. Set to 'off' for FALSE. Default is 'on'.
partman_bgw_jobmon: on
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-pg_partman/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.postgres](https://galaxy.ansible.com/buluma/postgres)|[![Build Status GitHub](https://github.com/buluma/ansible-role-postgres/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-postgres/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-postgres/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-postgres)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-pg_partman/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-pg_partman/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-pg_partman/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
