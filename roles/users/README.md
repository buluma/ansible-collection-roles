# [users](#users)

The purpose of this role is to add users and groups on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-users/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-users/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-users/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-users)|[![quality](https://img.shields.io/ansible/quality/57943)](https://galaxy.ansible.com/buluma/users)|[![downloads](https://img.shields.io/ansible/role/d/57943)](https://galaxy.ansible.com/buluma/users)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-users.svg)](https://github.com/buluma/ansible-role-users/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.users
      # You can create groups:
      users_group_list:
        - name: bulumadb
          gid: 1024
        - name: users
          # You can also remove groups.
        - name: notgroup
          state: absent
          # A system group is also possible.
        - name: systemgroup
          system: yes

      # You can create users.
      users_user_list:
        - name: root
          cron_allow: yes
          # You can remove authorized keys.
          unauthorized_keys:
            - "ssh-rsa XYZYX54321"
        - name: bulumadb
          comment: Michael Buluma
          uid: 1024
          # The `group` and `groups` listed here should exist.
          group: bulumadb
          # groups: A comma separated string of groups, i.e.:
          # groups: users,wheel
          groups: users
          cron_allow: yes
          sudo_options: "ALL=(ALL) NOPASSWD: ALL"
          # Adding an authorized key.
          authorized_keys:
            - "ssh-rsa ABC123"
          # EPOCH timestamp when an account should expire.
          # Typically a positive value like: `1641971487`.
          # The value `-1` removes the expiry time.
          expires: -1
          password_validity_days: 9
        # Here a user is removed.
        - name: notuser
          state: absent
        - name: keyuser
          manage_ssh_key: yes
        - name: privkeyuser
          # This user will have ssh-keys generated.
          manage_ssh_key: yes
          copy_private_key: yes
        - name: multiplekeys
          authorized_keys:
            - "ssh-rsa ABC1234"
            - "ssh-rsa ABC12345"
        - name: passuser
          # You can set a password. (Hashed and salted.)
          password: "$6$mysecretsalt$qJbapG68nyRab3gxvKWPUcs2g3t0oMHSHMnSKecYNpSi3CuZm.GbBqXO8BE6EI6P1JUefhA0qvD7b5LSh./PU1"
          update_password: on_create
        - name: remotekey
          authorized_keys:
            # You can also download a public key from a URL.
            - "https://raw.githubusercontent.com/shaanr/smdb/master/file.pub"
        - name: systemuser
          system: yes
        - name: multisudo
          # An account that can run just a few commands without a password.
          sudo_options:
            - "ALL= NOPASSWD: /usr/bin/systemctl restart httpd"
            - "ALL= NOPASSWD: /usr/bin/systemctl start httpd"
            - "ALL= NOPASSWD: /usr/bin/systemctl stop httpd"
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

  tasks:
    - name: Set authorized keys for root
      ansible.posix.authorized_key:
        user: root
        state: present
        key: "ssh-rsa XYZYX54321"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for users

# The location to store ssh keys for user
users_ssh_key_directory: ssh_keys

# The default shell if not overwritten.
users_shell: /bin/bash

# manage cron permissions via /etc/cron.allow
users_cron_allow: yes

# should homedirectories be created?
users_create_home: yes
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-users/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-users/png/requirements.png "Dependencies")

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



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-users/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-users/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
