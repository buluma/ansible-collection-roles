# [maintenance](#maintenance)

Maintain your system by cleaning up.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-maintenance/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-maintenance/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-maintenance/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-maintenance)|[![quality](https://img.shields.io/ansible/quality/57958)](https://galaxy.ansible.com/buluma/maintenance)|[![downloads](https://img.shields.io/ansible/role/d/57958)](https://galaxy.ansible.com/buluma/maintenance)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-maintenance.svg)](https://github.com/buluma/ansible-role-maintenance/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.maintenance
      maintenance_files_to_empty:
        - /tmp/some_file.txt
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

  tasks:
    - name: create a file
      ansible.builtin.copy:
        dest: /tmp/some_file.txt
        content: "Some content"
        mode: "0644"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for maintenance

maintenance_journalctl_vacuum: 10d

# A list of files that needs to be emptied.
# maintenance_files_to_empty:
#   - /tmp/some_file.txt
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-maintenance/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-maintenance/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-maintenance/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
