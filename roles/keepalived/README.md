# [Ansible role keepalived](#ansible-role-keepalived)

Install and configure keepalived

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-keepalived/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-keepalived/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-keepalived.svg)](https://github.com/buluma/ansible-role-keepalived/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-keepalived.svg)](https://github.com/buluma/ansible-role-keepalived/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-keepalived.svg)](https://github.com/buluma/ansible-role-keepalived/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/keepalived)](https://galaxy.ansible.com/ui/standalone/roles/buluma/keepalived/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-keepalived/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.keepalived
      keepalived_vrrp_instances:
        - name: VI_1
          state: MASTER
          interface: eth0
          unicast_src_ip: "172.17.0.6"
          secondary_private_ip: "172.17.0.7"
          virtual_router_id: 51
          priority: 255
          authentication:
            auth_type: PASS
            auth_pass: "12345"
          virtual_ipaddresses:
            - name: "172.17.0.8"
              cidr: 16
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-keepalived/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-keepalived/blob/master/defaults/main.yml):

```yaml
---
# defaults file for keepalived

# By default, there is not configuration, because there is no "sane default" to
# set. You'll have to set it yourself. Here are a few hints.
#
# Have a look in `molecule/default/converge.yml` for an example.
# You do not need to set the state to `MASTER`, all nodes can also be set to
# `BACKUP`, in which case a random host will be selected to configure the
# virtual IP. Setting `state` to `MASTER` only initially sets that host to be
# the master. Over time, other nodes will likely become master.
#
# You can see the configure virtual IP using `ip addr list eth0`.

# keepalived_vrrp_instances:
#   # `name` defines an individual instance of the VRRP protocol running on an interface.
#   - name: VI_1
#   # `state` defines the initial state that the instance should start in.
#     state: MASTER
#   # `interface` defines the interface that VRRP runs on.
#     interface: eth0
#   # `unicast_src_ip` contains the primary address for unicasts.
#     unicast_src_ip: "192.168.1.1"
#   # `secondary_private_ip` refers the the peer's unicast address.
#     secondary_private_ip: "192.168.1.2"
#   # `virtual_router_id` is the unique identifier.
#     virtual_router_id: 51
#   # `priority` is the advertised priority.
#     priority: 255
#   # `check_status_command` will make +3 to priority if command return is 0 (optional). example:
#     check_status_command: /sbin/postfix status
#   # `authentication` specifies the information necessary for servers participating in VRRP to authenticate with each other.
#     authentication:
#       auth_type: PASS
#       auth_pass: 12345
#   # `virtual_ipaddress` defines the IP addresses (there can be multiple) that VRRP is responsible for.
#     virtual_ipaddresses:
#       - name: "192.168.122.200"
#         cidr: 24
keepalived_vrrp_instances: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-keepalived/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-keepalived/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-keepalived/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-keepalived/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
