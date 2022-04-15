# [lynis](#lynis)

Install and configure lynis on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-lynis/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-lynis/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-lynis/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-lynis)|[![quality](https://img.shields.io/ansible/quality/58808)](https://galaxy.ansible.com/buluma/lynis)|[![downloads](https://img.shields.io/ansible/role/d/58808)](https://galaxy.ansible.com/buluma/lynis)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-lynis.svg)](https://github.com/buluma/ansible-role-lynis/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-lynis.svg)](https://github.com/buluma/ansible-role-lynis/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-lynis.svg)](https://github.com/buluma/ansible-role-lynis/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.lynis
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
    - role: buluma.cron
    - role: buluma.git
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for lynis

# Where to install lynis
lynis_destination: "/tmp/lynis"

# The version to install
lynis_version: "3.0.6"

# Where to save the output of a report.
lynis_output: "{{ lynis_destination }}/{{ ansible_date_time.date }}-audit_system.txt"

# Run lynis on execution of the playbook?
lynis_run_now: yes

# Schedule a repetetive job?
lynis_cronjob: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-lynis/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-cron/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-cron)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-lynis/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|el|8|
|debian|all|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-lynis/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
