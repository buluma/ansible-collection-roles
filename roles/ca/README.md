# [Ansible role ca](#ansible-role-ca)

Install and configure a certificate authority on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-ca/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-ca/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-ca.svg)](https://github.com/buluma/ansible-role-ca/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-ca.svg)](https://github.com/buluma/ansible-role-ca/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-ca.svg)](https://github.com/buluma/ansible-role-ca/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/ca)](https://galaxy.ansible.com/ui/standalone/roles/buluma/ca/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-ca/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.ca
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-ca/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.buildtools
    - role: buluma.epel
    - role: buluma.python_pip
    - role: buluma.openssl
      openssl_items:
        - name: apache-httpd
          common_name: "{{ ansible_facts['fqdn'] }}"
    - role: buluma.httpd
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-ca/blob/master/defaults/main.yml):

```yaml
---
# defaults file for ca

# set ca_init: 'yes' to create CA
ca_init: true

# ca_own_root: 'yes' if you want to have yout own root CA.
# if no, set ca_certificate_path manually
ca_own_root: true

# A passphrase for the CA key.
ca_passphrase: SuP3rS3cr3T

# The common name for the CA.
ca_common_name: example.com

# Other details for the CA.
ca_country_name: KE
ca_email_address: me@buluma.me.ke
ca_organization_name: Very little
ca_organizational_unit_name: Even less
ca_state_or_province_name: Nairobi
ca_locality_name: Nairobi

# There are two formats to request a key and certificate:
# 1. With details: (Includes `name:`)
# ca_requests:
#   - name: certificate1.example.com
#     passphrase: S3creT
#
# 2. Without details: (Does not include `name:`)
# ca_requests:
#   - "{{ ansible_facts['fqdn'] }}"

# You can also mix these formats:
# ca_requests:
#   - name: certificate1.example.com
#     passphrase: S3creT
#   - "{{ ansible_facts['fqdn'] }}"

# Where to publish the certificates, normally a webserver location.
# If not specified, certificates will not be published.
# {{ httpd_data_directory }} is inheritted from the role buluma.httpd.
ca_publication_location: "{{ httpd_data_directory | default('/tmp') }}/pub"

# Where do the certificates need to be stored? By default the distribution
# preferred locations are used (see `vars/main.yml`, under `_ca_openssl_path`.
# If you need a CA certificate somewhere else, simple use something like this:
# ca_openssl_path: /my/preferred/path
ca_openssl_path: "{{ _ca_openssl_path[ansible_facts['os_family']] | default(_ca_openssl_path['default']) }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-ca/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.buildtools](https://galaxy.ansible.com/buluma/buildtools)|[![Build Status GitHub](https://github.com/buluma/ansible-role-buildtools/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-buildtools/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.httpd](https://galaxy.ansible.com/buluma/httpd)|[![Build Status GitHub](https://github.com/buluma/ansible-role-httpd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-httpd/actions)|
|[buluma.openssl](https://galaxy.ansible.com/buluma/openssl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openssl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openssl/actions)|
|[buluma.python_pip](https://galaxy.ansible.com/buluma/python_pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-python_pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-python_pip/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-ca/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-ca/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-ca/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
