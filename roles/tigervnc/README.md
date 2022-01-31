# [tigervnc](#tigervnc)

Install and configure tigervnc on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-tigervnc/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-tigervnc/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-tigervnc/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-tigervnc)|[![quality](https://img.shields.io/ansible/quality/46981)](https://galaxy.ansible.com/buluma/tigervnc)|[![downloads](https://img.shields.io/ansible/role/d/46981)](https://galaxy.ansible.com/buluma/tigervnc)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-tigervnc.svg)](https://github.com/buluma/ansible-role-tigervnc/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.tigervnc
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
    - role: buluma.core_dependencies
    - role: buluma.gnome
    - role: buluma.users
      users_group_list:
        - name: vncgroup
      users_user_list:
        - name: vncuser
          sudo_options: "ALL=(ALL) NOPASSWD: ALL"
          group: vncgroup
```

Also see a [full explanation and example](https://buluma.nl/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for tigervnc

# The tigervnc-server runs under a specific user and group. This user is
# created in `molecule/default/prepare.yml`. You can pick an existing
# user or create one using
# [ansible-role-users](https://galaxy.ansible.com/buluma/users)
tigervnc_username: vncuser
tigervnc_groupname: vncgroup

# Connecting to tigervnc-server requires a password.
tigervnc_password: vncpass

# Use existing user's vnc paswword
tigervnc_user_exists: no

# Desktop session xstartup should connect to e.g. gnome-session, mate-session
tigervnc_desktop_session: gnome-session
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-tigervnc/blob/master/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|
|[buluma.gnome](https://galaxy.ansible.com/buluma/gnome)|[![Build Status GitHub](https://github.com/buluma/ansible-role-gnome/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-gnome/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-gnome/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-gnome)|
|[buluma.users](https://galaxy.ansible.com/buluma/users)|[![Build Status GitHub](https://github.com/buluma/ansible-role-users/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-users/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-users/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-users)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.nl/) for further information.

Here is an overview of related roles:
![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-tigervnc/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|fedora|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-tigervnc/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.nl/)

Please consider [sponsoring me](https://github.com/sponsors/buluma).
