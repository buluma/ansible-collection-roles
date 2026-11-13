# [Ansible role postgresql_replication](#ansible-role-postgresql_replication)

Ansible role to deploy postgresql software with replication

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-postgresql_replication/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-postgresql_replication/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-postgresql_replication.svg)](https://github.com/buluma/ansible-role-postgresql_replication/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/postgresql_replication)](https://galaxy.ansible.com/ui/standalone/roles/buluma/postgresql_replication/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  vars:
    # Pinned to 11: this role's replication setup (wal_keep_segments,
    # recovery.conf as the standby control file) predates PG12's removal of
    # recovery.conf and PG13's removal of wal_keep_segments, so anything
    # newer won't start.
    postgresql__version: 11
    postgresql_replication__bootstrap: "yesiwant"
    # Computed per-host so master and replica each point at the other node,
    # rather than a fixed global value.
    postgresql_replication__other_nodes: "{{ groups[postgresql_replication__group] | difference([inventory_hostname]) }}"
    postgresql_replication__master_node_address: "{{ hostvars[groups[postgresql_replication__group_master][0]]['ansible_default_ipv4']['address'] }}"
  roles:
    # enix.postgresql has to run in the same play as our role, not in
    # prepare.yml: its postgresql__* vars come from its own vars/main.yml,
    # which only stays in scope for the rest of *this* play once the role
    # is listed under roles: - a separate ansible-playbook run (prepare vs
    # converge) doesn't carry that over, and our tasks need those vars.
    - role: enix.postgresql
      # locale_gen runs unconditionally on every OS family in this role, but
      # community.general.locale_gen only supports Debian/Ubuntu (it
      # hard-fails looking for /etc/locale.gen, which doesn't exist on
      # RHEL/Fedora) and none of our test images ship "locales" anyway. We
      # don't need generated locales for replication testing.
      postgresql__locales: []
      # Passed as a role param, not just the play var above: role
      # vars/main.yml (which also defines postgresql__version: 14) outranks
      # play vars in Ansible's precedence order, so the play-level value
      # alone wouldn't actually override it here.
      postgresql__version: 11
      # Master needs to accept replication connections from the other node -
      # default is localhost-only, which pg_basebackup on the replica can't
      # reach.
      postgresql__global_config_options:
        - option: listen_addresses
          value: "*"
      postgresql__hba_entries:
        - auth_method: peer
          database: all
          type: local
          user: postgres
        - auth_method: peer
          database: all
          type: local
          user: all
        - address: 0.0.0.0/0
          auth_method: md5
          database: all
          type: host
          user: all
        - address: 0.0.0.0/0
          auth_method: md5
          database: replication
          type: host
          user: "{{ postgresql_replication__user }}"
      # The replicate role itself - without this, our role's .pgpass /
      # pg_basebackup calls have no matching database role to authenticate
      # as.
      postgresql__users:
        - name: "{{ postgresql_replication__user }}"
          password: "{{ postgresql_replication__password }}"
          role_attr_flags: REPLICATION
    - role: buluma.postgresql_replication
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/molecule/default/prepare.yml):

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

    - name: Install iproute if missing
      # gather_facts (converge.yml) needs the "ip" command to populate
      # ansible_facts['default_ipv4'] - our role's config-user.yml relies on
      # that for the replication authorized_key's from= restriction, and
      # this image doesn't ship it.
      ansible.builtin.raw: >-
        if command -v ip >/dev/null 2>&1; then exit 0; fi;
        if command -v apt-get >/dev/null 2>&1; then apt-get update && apt-get install -y iproute2;
        elif command -v dnf >/dev/null 2>&1; then dnf install -y iproute;
        elif command -v yum >/dev/null 2>&1; then yum install -y iproute;
        elif command -v zypper >/dev/null 2>&1; then zypper -n install iproute2;
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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/defaults/main.yml):

```yaml
---
postgresql_replication__group: postgresql
postgresql_replication__group_master: postgresql_master
postgresql_replication__group_replicas: postgresql_replicas
postgresql_replication__password: replicate
postgresql_replication__trigger_file: /tmp/MasterNow
postgresql_replication__user: replicate
postgresql_replication__waldir: /var/lib/postgresql/wal-slave/
postgresql_replication__walsegments: 64
postgresql_replication__walsenders: 3
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|enix.postgresql (installed from [buluma/ansible-postgresql](https://github.com/buluma/ansible-postgresql), a fork replacing the removed `apt_key` module - see `requirements.yml`)|[buluma/ansible-postgresql](https://github.com/buluma/ansible-postgresql)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-postgresql_replication/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|bookworm, trixie|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|jammy|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-postgresql_replication/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-postgresql_replication/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
