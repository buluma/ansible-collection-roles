# [Ansible role consul_ca](#ansible-role-consul_ca)

Install and configure Consul CA on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-consul_ca/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-consul_ca/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-consul_ca.svg)](https://github.com/buluma/ansible-role-consul_ca/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-consul_ca.svg)](https://github.com/buluma/ansible-role-consul_ca/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-consul_ca.svg)](https://github.com/buluma/ansible-role-consul_ca/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/consul_ca)](https://galaxy.ansible.com/ui/standalone/roles/buluma/consul_ca/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-consul_ca/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  tasks:
    - ansible.builtin.include_role:
        name: buluma.consul_ca
      name: Include buluma.consul_ca
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-consul_ca/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.ca_certificates
    - role: buluma.core_dependencies
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-consul_ca/blob/master/defaults/main.yml):

```yaml
---
ca_consul_csr_cn: Consul
ca_consul_csr_key_algo: rsa
ca_consul_csr_key_size: "2048"
ca_consul_csr_names_c: DE
ca_consul_csr_names_l: The_Internet
ca_consul_csr_names_o: Consul
ca_consul_csr_names_ou: BY
ca_consul_csr_names_st: Bayern
ca_consul_expiry: 87600h
cfssl_arch: amd64
cfssl_bin_directory: /usr/local/bin
cfssl_checksum_url: "https://github.com/cloudflare/cfssl/releases/download/v{{ cfssl_version }}/cfssl_{{ cfssl_version }}_checksums.txt"
cfssl_group: root
cfssl_os: linux
cfssl_owner: root
cfssl_version: "1.7.1"
consul_ca_certificate_group: root
consul_ca_certificate_owner: root
consul_ca_conf_directory: "{{ '~/consul/ssl' | expanduser }}"
consul_csr_cn: server.dc1.consul
consul_csr_key_algo: rsa
consul_csr_key_size: "2048"
consul_csr_names_c: DE
consul_csr_names_l: The_Internet
consul_csr_names_o: Consul
consul_csr_names_ou: BY
consul_csr_names_st: Bayern
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-consul_ca/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.go](https://galaxy.ansible.com/buluma/go)|[![Build Status GitHub](https://github.com/buluma/ansible-role-go/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-go/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-consul_ca/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-consul_ca/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-consul_ca/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
