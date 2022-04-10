# [cve_2022-23307](#cve_2022-23307)

Check and report for cve_2022_23307 (log4shell) on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-cve_2022-23307/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cve_2022-23307/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-cve_2022-23307/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cve_2022-23307)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/cve_2022-23307)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/cve_2022-23307)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-cve_2022-23307.svg)](https://github.com/buluma/ansible-role-cve_2022-23307/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-cve_2022-23307.svg)](https://github.com/buluma/ansible-role-cve_2022-23307/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-cve_2022-23307.svg)](https://github.com/buluma/ansible-role-cve_2022-23307/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.cve_2022_23307
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

  # The role is prepared to install extra software and also remove when
  # the role is done. This is not idempotent, so in this playbook, the
  # required software is already installed.
  vars_files:
    - ../../vars/main.yml

  post_tasks:
    - name: install required software
      ansible.builtin.package:
        name: ["{{ cve_2022_23307_ps_package }}", unzip]
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for cve_2022_23307

# You can disable certain checks using these variables.

# Check suspicous processes.
cve_2022_23307_check_processes: yes

# Check suspicous packages.
cve_2022_23307_check_packages: yes

# This check uses `find`, which may use the disk intensively.
# Check suspicous files.
cve_2022_23307_check_files: yes

# This check uses `find`, which may use the disk intensively.
# Check suspicous jars
cve_2022_23307_check_archives: yes

# Add your own paths if you want to. The more paths you add, the more
# the disk will be used, but not having enough paths poses a risk of
# not finding vulnerable files.
# Paths to find files and jars in.
cve_2022_23307_paths_to_check:
  - /var
  - /etc
  - /usr
  - /opt
  - /lib64

# The types of archives to scan.
cve_2022_23307_archive_patterns:
  - "*.jar"
  - "*.war"
  - "*.ear"
  - "*.aar"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-cve_2022-23307/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-cve_2022-23307/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|all|
|debian|all|
|el|7, 8|
|fedora|all|
|opensuse|all|
|ubuntu|focal, bionic|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-cve_2022-23307/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
