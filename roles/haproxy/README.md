# [Ansible role haproxy](#ansible-role-haproxy)

Install and configure haproxy on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-haproxy/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-haproxy/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-haproxy.svg)](https://github.com/buluma/ansible-role-haproxy/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-haproxy.svg)](https://github.com/buluma/ansible-role-haproxy/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-haproxy.svg)](https://github.com/buluma/ansible-role-haproxy/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/haproxy)](https://galaxy.ansible.com/ui/standalone/roles/buluma/haproxy/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-haproxy/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - haproxy_backend_default_balance: roundrobin
      haproxy_backends:
        - balance: roundrobin
          httpcheck: true
          name: backend
          options:
            - check
          port: 8080
          servers: "{{ groups['all'] }}"
        - balance: leastconn
          mode: tcp
          name: smtp
          port: 25
          servers:
            - address: 127.0.0.1
              name: first
              port: 25
            - address: 127.0.0.2
              name: second
              port: 25
        - http_send_name_header: Host
          httpcheck: GET /v1/sys/health HTTP/1.1
          mode: tcp
          name: vault
          options:
            - check
            - check-ssl
            - ssl verify none
          port: 8200
          servers: "{{ groups['all'] }}"
      haproxy_frontends:
        - address: "*"
          default_backend: backend
          name: http
          port: 80
        - address: "*"
          crts:
            - /tmp/haproxy.keycrt
          default_backend: backend
          name: https
          port: 443
          ssl: true
        - address: "*"
          default_backend: smtp
          mode: tcp
          name: smtp
          port: 25
      haproxy_listen_default_balance: roundrobin
      haproxy_listens:
        - address: "*"
          balance: roundrobin
          httpcheck: true
          listen_port: 8081
          name: listen
          options:
            - maxconn 100000
          port: 8080
          servers: "{{ groups['all'] }}"
      role: buluma.haproxy
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-haproxy/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.core_dependencies
    - role: buluma.epel
    - role: buluma.buildtools
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-haproxy/blob/master/defaults/main.yml):

```yaml
---
haproxy_backend_default_balance: roundrobin
haproxy_backends: []
haproxy_frontends: []
haproxy_listen_default_balance: roundrobin
haproxy_listens: []
haproxy_maxconn: 3000
haproxy_retries: 3
haproxy_stats: true
haproxy_stats_bind_addr: "0.0.0.0"
haproxy_stats_port: 1936
haproxy_timeout_check: 10s
haproxy_timeout_client: 1m
haproxy_timeout_connect: 10s
haproxy_timeout_http_keep_alive: 10s
haproxy_timeout_http_request: 10s
haproxy_timeout_server: 1m
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-haproxy/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-haproxy/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-haproxy/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-haproxy/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
