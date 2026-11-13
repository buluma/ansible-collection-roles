# [Ansible role tfe](#ansible-role-tfe)

Install and configure tfe on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-tfe/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-tfe/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-tfe.svg)](https://github.com/buluma/ansible-role-tfe/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-tfe.svg)](https://github.com/buluma/ansible-role-tfe/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-tfe.svg)](https://github.com/buluma/ansible-role-tfe/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/tfe)](https://galaxy.ansible.com/ui/standalone/roles/buluma/tfe/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-tfe/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.tfe
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-tfe/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.docker_ce
    - role: buluma.docker_compose
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-tfe/blob/master/defaults/main.yml):

```yaml
---
tfe_capacity_concurrency: 10
tfe_database_host: tfe.RaNdOm.eu-west-1.rds.amazonaws.com
tfe_database_name: tfe
tfe_database_parameters: sslmode=disable
tfe_database_password: my_pass_c0mpl.x
tfe_database_user: tfe
tfe_encryption_password: S0meP@ssword
tfe_hostname: tfe.example.com
tfe_iact_subnets: []
tfe_image: "images.releases.hashicorp.com/hashicorp/terraform-enterprise:v202309-1"
tfe_license: ""
tfe_object_storage_s3_access_key_id: ""
tfe_object_storage_s3_bucket: SomeBucketName
tfe_object_storage_s3_endpoint: ""
tfe_object_storage_s3_region: eu-west-1
tfe_object_storage_s3_secret_access_key: ""
tfe_object_storage_s3_use_instance_profile: false
tfe_operational_mode: active-active
tfe_redis_host: tfe.RaNdOm.0001.euw1.cache.amazonaws.com
tfe_redis_password: my_pass_c0mpl.x
tfe_redis_use_auth: false
tfe_redis_use_tls: false
tfe_redis_user: tfe
tfe_tls_bundle: bundle.pem
tfe_tls_certificate: cert.pem
tfe_tls_key: key.pem
tfe_vault_cluster_address: "https://{{ ansible_facts['default_ipv4'].address }}:8201"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-tfe/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|
|[buluma.docker_ce](https://galaxy.ansible.com/buluma/docker_ce)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker_ce/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_ce/actions)|
|[buluma.docker_compose](https://galaxy.ansible.com/buluma/docker_compose)|[![Build Status GitHub](https://github.com/buluma/ansible-role-docker_compose/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-docker_compose/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-tfe/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-tfe/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-tfe/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
