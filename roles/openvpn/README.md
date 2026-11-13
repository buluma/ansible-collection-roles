# [Ansible role openvpn](#ansible-role-openvpn)

Install and configure openvpn server or client on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-openvpn/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-openvpn/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-openvpn.svg)](https://github.com/buluma/ansible-role-openvpn/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-openvpn.svg)](https://github.com/buluma/ansible-role-openvpn/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-openvpn.svg)](https://github.com/buluma/ansible-role-openvpn/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/openvpn)](https://galaxy.ansible.com/ui/standalone/roles/buluma/openvpn/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-openvpn/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  tasks:
    - name: Create openvpn server
      ansible.builtin.include_role:
        name: ansible-role-openvpn
      vars:
        openvpn_role: "server"

    - name: Copy certificates and keys from the server to the client
      ansible.builtin.copy:
        src: /etc/openvpn/easy-rsa/pki/{{ item }}
        dest: /etc/openvpn/client/{{ item | basename }}
        mode: "0640"
        remote_src: true
      loop:
        - ca.crt
        - issued/client.crt
        - private/client.key
        - ta.key

    - name: Create openvpn client
      ansible.builtin.include_role:
        name: ansible-role-openvpn
      vars:
        openvpn_role: "client"
        openvpn_client_server: "127.0.0.1"
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-openvpn/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.epel
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-openvpn/blob/master/defaults/main.yml):

```yaml
---
# defaults file for openvpn

# You can setup both a client and a server using this role.
# Use `server` or `client` for `openvpn_role`.

openvpn_role: server

# If you are configuring a client, setup these variables:
# openvpn_role: client
# openvpn_client_server: vpn.example.com

# Server configuration
openvpn_port: 1194
openvpn_proto: udp
openvpn_dev: tun
openvpn_server_network: "10.8.0.0"
openvpn_server_netmask: "255.255.255.0"
openvpn_topology: subnet
openvpn_cipher: AES-256-CBC
openvpn_verb: 3
openvpn_push_options:
  - "redirect-gateway def1 bypass-dhcp"
  - "dhcp-option DNS 1.1.1.1"
  - "dhcp-option DNS 1.0.0.1"

# Extra configuration lines for the server
openvpn_server_custom_options: []
# Template to use for the server configuration
openvpn_server_conf_template: server.conf.j2
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-openvpn/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-openvpn/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-openvpn/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-openvpn/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
