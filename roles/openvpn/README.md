# [openvpn](#openvpn)

Install and configure openvpn server or client on your system.

|GitHub|GitLab|Quality|Downloads|Version|
|------|------|-------|---------|-------|
|[![github](https://github.com/buluma/ansible-role-openvpn/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openvpn/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-openvpn/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openvpn)|[![quality](https://img.shields.io/ansible/quality/57994)](https://galaxy.ansible.com/buluma/openvpn)|[![downloads](https://img.shields.io/ansible/role/d/57994)](https://galaxy.ansible.com/buluma/openvpn)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-openvpn.svg)](https://github.com/buluma/ansible-role-openvpn/releases/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  tasks:
    - name: create openvpn server
      ansible.builtin.include_role:
        name: buluma.openvpn
      vars:
        openvpn_role: "server"

    - name: copy certificates and keys from the server to the client
      ansible.builtin.copy:
        src: /etc/openvpn/easy-rsa/pki/{{ item }}
        dest: /etc/openvpn/client/{{ item | basename }}
        mode: "0640"
        remote_src: yes
      loop:
        - ca.crt
        - issued/client.crt
        - private/client.key
        - ta.key

    - name: create openvpn client
      ansible.builtin.include_role:
        name: buluma.openvpn
      vars:
        openvpn_role: "client"
        openvpn_client_server: "127.0.0.1"
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare server
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for openvpn

# You can setup both a client and a server using this role.
# Use `server` or `client` for `openvpn_role`.

openvpn_role: server

# If you are configuring a client, setup these variables:
# openvpn_role: client
# openvpn_client_server: vpn.example.com
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-openvpn/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-openvpn/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|amazon|Candidate|
|debian|all|
|el|8|
|fedora|34, 35|
|debian|bullseye, bookworm|
|ubuntu|focal|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-openvpn/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
