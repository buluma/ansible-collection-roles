# [Ansible role owncloud](#ansible-role-owncloud)

Install and configure ownCloud Infinite Scale (oCIS) on your system.

ownCloud 'classic' (the PHP-based server this role used to install) hard-rejects
PHP 8.0+ and never will support it - a permanent vendor incompatibility that
pinned this role to end-of-life Debian 11 (the last release still shipping PHP
7.4). oCIS is ownCloud's PHP8-compatible successor: a single statically-linked
Go binary with no PHP, Apache, MySQL, or Redis dependency.

**This role does not migrate data from an existing classic ownCloud
instance**, and the old `owncloud_*` variables are gone - this installs a
separate, empty oCIS instance from scratch. If you have production data on
classic ownCloud, follow ownCloud's own [Migrating to ownCloud Infinite
Scale](https://doc.owncloud.com/server/latest/admin_manual/maintenance/migrating_to_ocis.html)
procedure against a clean oCIS target (this role can provide that target):
it migrates users, groups, files, and shares, in that order, while the
classic instance keeps running.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-owncloud/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-owncloud/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-owncloud.svg)](https://github.com/buluma/ansible-role-owncloud/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-owncloud.svg)](https://github.com/buluma/ansible-role-owncloud/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-owncloud.svg)](https://github.com/buluma/ansible-role-owncloud/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/owncloud)](https://galaxy.ansible.com/ui/standalone/roles/buluma/owncloud/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-owncloud/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.owncloud
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-owncloud/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  pre_tasks:
    - name: Install sudo if missing
      ansible.builtin.raw: "{{ ansible_pkg_mgr | default('dnf') }} install -y sudo"
      become: false
      changed_when: false
      failed_when: false

    - name: Install python3 if missing
      ansible.builtin.raw: >-
        if [ -x /usr/bin/python3 ]; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y python3;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y python3;
        elif command -v yum >/dev/null 2>&1; then yum install -y python3;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install python3;
        else exit 1; fi
      become: false
      changed_when: false
      failed_when: false

    - name: Configure passwordless sudo
      ansible.builtin.raw: >-
        if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
          echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
        fi;
        visudo -cf /etc/sudoers
      become: false
      changed_when: false
      failed_when: false

  roles:
    - role: buluma.bootstrap
    - role: buluma.core_dependencies
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-owncloud/blob/master/defaults/main.yml):

```yaml
---
# ownCloud 'classic' (the PHP-based server this role used to install) hard-
# rejects PHP 8.0+ and never will support it - a permanent vendor
# incompatibility (see meta/preferences.yml history). ownCloud's PHP8-
# compatible successor is Infinite Scale (oCIS): a single Go binary, no
# PHP/Apache/MySQL/Redis involved. This role now installs that instead.

# oCIS release to install.
ocis_version: "8.2.2"

# Owner and group for oCIS.
ocis_owner: "ocis"
ocis_group: "ocis"

# Where the oCIS binary, config, and data live.
ocis_binary_path: "/usr/bin/ocis"
ocis_config_dir: "/etc/ocis"
ocis_data_path: "/var/lib/ocis"

# Public URL and bind address (see OCIS_URL / PROXY_HTTP_ADDR).
ocis_url: "https://{{ ansible_facts['default_ipv4'].address | default(ansible_facts['all_ipv4_addresses'][0]) }}:9200"
ocis_http_addr: "0.0.0.0:9200"

# This role doesn't manage TLS certificates, so oCIS falls back to its own
# auto-generated self-signed certificate out of the box - set false only
# once you've put a real certificate in front of it.
ocis_insecure: true

ocis_log_level: "error"

# Admin account. oCIS generates a random admin password on init unless
# IDM_ADMIN_PASSWORD is set - this role always sets it explicitly.
ocis_admin_pass: OwnCl0uD
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-owncloud/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-owncloud/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|13, 12|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-owncloud/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-owncloud/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
