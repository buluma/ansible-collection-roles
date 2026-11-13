# [Ansible role dns](#ansible-role-dns)

Install and configure dns on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-dns/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-dns/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-dns.svg)](https://github.com/buluma/ansible-role-dns/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-dns.svg)](https://github.com/buluma/ansible-role-dns/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-dns.svg)](https://github.com/buluma/ansible-role-dns/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/dns)](https://galaxy.ansible.com/ui/standalone/roles/buluma/dns/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-dns/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - dns_port: 5353
      role: buluma.dns
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-dns/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-dns/blob/master/defaults/main.yml):

```yaml
---
dns_allow_recursion:
  - none
dns_caching_dns: true
dns_options_listen_on:
  - any
dns_options_listen_on_v6:
  - any
dns_pid_file: /run/named/named.pid
dns_port: 53
dns_zones:
  - expire: 2419200
    name: localhost
    records:
      - name: "@"
        type: NS
        value: localhost.
      - name: "@"
        value: 127.0.0.1
      - name: "@"
        type: AAAA
        value: ::1
    refresh: 604800
    retry: 86400
    serial: 1
    soa: localhost
    ttl: 604800
  - name: 127.in-addr.arpa
    records:
      - name: "@"
        type: NS
        value: localhost.
      - name: 1.0.0
        type: PTR
        value: localhost.
    ttl: 604800
  - name: 0.in-addr.arpa
    records:
      - name: "@"
        type: NS
        value: localhost.
  - name: 255.in-addr.arpa
    records:
      - name: "@"
        type: NS
        value: localhost.
  - mx:
      - name: mail1.example.com.
        priority: 10
      - name: mail2.example.com.
        priority: 20
    name: example.com
    ns:
      - name: dns1.example.com.
      - name: dns2.example.com.
    records:
      - name: dns1
        value: 127.0.0.1
      - name: dns2
        value: 127.0.0.1
      - name: www
        value: 127.0.0.1
      - name: dns1
        value: 127.0.0.1
      - name: dns2
        value: 127.0.0.1
      - name: mail1
        value: 127.0.0.1
      - name: mail2
        value: 127.0.0.1
      - name: ldap1
        value: 127.0.0.1
    srv:
      - name: _kerberos-master._tcp.example.com.
        port: 88
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _kerberos-master._udp.example.com.
        port: 88
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _kerberos._tcp.example.com.
        port: 88
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _kerberos._udp.example.com.
        port: 88
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _kpasswd._tcp.example.com.
        port: 464
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _kpasswd._udp.example.com.
        port: 464
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
      - name: _ldap._tcp.example.com.
        port: 389
        priority: 0
        ttl: 3600
        value: ldap1.example.com.
        weight: 100
    ttl: 604800
    txt:
      - name: _kerberos.example.com.
        ttl: 3600
        value: EXAMPLE.COM
    uri:
      - name: _kerberos.example.com.
        priority: 0
        value: "krb5srv:m:tcp:ldap1.example.com."
        weight: 100
      - name: _kerberos.example.com.
        priority: 0
        value: "krb5srv:m:udp:ldap1.example.com."
        weight: 100
      - name: _kpasswd.example.com.
        priority: 0
        value: "krb5srv:m:tcp:ldap1.example.com."
        weight: 100
      - name: _kpasswd.example.com.
        priority: 0
        value: "krb5srv:m:udp:ldap1.example.com."
        weight: 100
  - dns_zone_forwarders:
      - 1.1.1.1
      - 8.8.8.8
    name: forwarded.example.com
    type: forward

# secondary configuration example:
#
# on the main dns server:
#
# dns_options_allow_transfer:
#   - "192.168.0.100"
#
# on the secondary dns server:
#
# dns_zones:
#   - name: "example.com"
#     type: secondary
#     zone_masters:
#       - 192.168.0.53
#   - name: "lab.controlplane.info"
#     type: secondary
#     zone_masters:
#       - 192.168.0.53
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-dns/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-dns/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-dns/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-dns/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
