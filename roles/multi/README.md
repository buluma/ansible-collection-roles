# [Ansible role multi](#ansible-role-multi)

Apache 2.x for Linux.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-multi/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-multi/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-multi.svg)](https://github.com/buluma/ansible-role-multi/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/multi)](https://galaxy.ansible.com/ui/standalone/roles/buluma/multi/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-multi/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  pre_tasks:
    - apt: update_cache=yes cache_valid_time=600
      changed_when: false
      name: Update apt cache.
      when: ansible_facts['os_family'] == 'Debian'
  roles:
    - role: buluma.multi
  strategy: free
  vars:
    _service_test_command:
      Alpine: /bin/sleep
      Debian: /bin/sleep
      Ubuntu-16: /bin/sleep
      Ubuntu-18: /bin/sleep
      default: /usr/bin/sleep
    alice:
      name: Alice Appleworth
      telephone: 123-456-7890
    bob:
      name: Bob Bananarama
      telephone: 987-654-3210
    service_test_command: "{{ _service_test_command[ansible_facts['distribution'] ~ '-' ~
      ansible_facts['distribution_major_version']] | default(_service_test_command[ansible_facts['os_family']]
      | default(_service_test_command['default'])) }}"
    users:
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-multi/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-multi/blob/master/defaults/main.yml):

```yaml
---
apache_allow_override: All
apache_global_vhost_settings: "DirectoryIndex index.php index.html\n"
apache_ignore_missing_ssl_certificate: true
apache_listen_ip: "*"
apache_listen_port: 80
apache_listen_port_ssl: 443
apache_options: -Indexes +FollowSymLinks
apache_restart_state: restarted
apache_ssl_cipher_suite: "AES256+EECDH:AES256+EDH"
apache_ssl_protocol: All -SSLv2 -SSLv3
apache_vhosts:
  - documentroot: /var/www/html
    servername: local.dev
apache_vhosts_ssl: []
apt_autostart_state: enabled
users_ssh_key_directory: ssh_keys
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-multi/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|
|[buluma.cron](https://galaxy.ansible.com/buluma/cron)|[![Build Status GitHub](https://github.com/buluma/ansible-role-cron/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-cron/actions)|
|[buluma.service](https://galaxy.ansible.com/buluma/service)|[![Build Status GitHub](https://github.com/buluma/ansible-role-service/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-service/actions)|
|[buluma.systemd](https://galaxy.ansible.com/buluma/systemd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-systemd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-systemd/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|
|[buluma.reboot](https://galaxy.ansible.com/buluma/reboot)|[![Build Status GitHub](https://github.com/buluma/ansible-role-reboot/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-reboot/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-multi/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-multi/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-multi/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
