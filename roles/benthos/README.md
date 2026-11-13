# [Ansible role benthos](#ansible-role-benthos)

Installs benthos

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-benthos/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-benthos/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-benthos.svg)](https://github.com/buluma/ansible-role-benthos/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-benthos.svg)](https://github.com/buluma/ansible-role-benthos/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-benthos.svg)](https://github.com/buluma/ansible-role-benthos/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/benthos)](https://galaxy.ansible.com/ui/standalone/roles/buluma/benthos/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-benthos/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.benthos
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-benthos/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-benthos/blob/master/defaults/main.yml):

```yaml
---
# defaults file for benthos
benthos_ver: "4.24.0"

benthos_arch_map:
  aarch64: arm64
  arm64: arm64
  x86_32: "386"
  x86_64: amd64

benthos_parent_install_dir: /usr/local
benthos_mirror: "https://github.com/benthosdev/benthos/releases/download"

benthos_checksums:
  # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_checksums.txt
  "4.24.0":
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_darwin_amd64.tar.gz
    darwin_amd64: sha256:7668e213a4a4c6714657bc0c9a95ae57b0d5d11f6092d9af1b4103109c3efe85
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_darwin_arm64.tar.gz
    darwin_arm64: sha256:d70a666b6108613752bf969e6fdab18e8da7bcd2d178fb7ef733a5df892af24f
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_freebsd_amd64.tar.gz
    freebsd_amd64: sha256:4cc833c2977ac3fd45129ba7479493f16d30fb5a0c764ee17e6bd0a7b3c6aca2
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_freebsd_arm64.tar.gz
    freebsd_arm64: sha256:63f3df5f4e96d74ce443d6cc584354fb5f3d246e2e84bfb5d69c2c3ad3c91973
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_freebsd_armv6.tar.gz
    freebsd_armv6: sha256:04db806c322c2c2368406635502a703bf2178e3016feeaf15cf874053498b94c
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_freebsd_armv7.tar.gz
    freebsd_armv7: sha256:faf0b7f9a8a36cfa0d041645bfe4e1ea1c9e28b5454a691367240fb0bb776112
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_linux_amd64.tar.gz
    linux_amd64: sha256:4c11b86398c54bcc6fd566f2322a840e91116f3bc048d3561bc9674f597e8828
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_linux_arm64.tar.gz
    linux_arm64: sha256:1066caa5de9d0a266d472ef4793e89dfbae9314c59a544b89c9229943c259d2d
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_linux_armv6.tar.gz
    linux_armv6: sha256:d0382044e3de00d0b00d72fe3ffc1b5be90f32f24acc24ed70c387c153d2aad9
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_linux_armv7.tar.gz
    linux_armv7: sha256:07aa22e99e4fd9849f256d8dba00d7389b874ca9144196c6c7b26cab8b59f0d5
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_openbsd_amd64.tar.gz
    openbsd_amd64: sha256:8ed9a1542d4e56d23ecf3701cd11bda7229794e2df34a5ac83fcfa3cca532217
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_openbsd_arm64.tar.gz
    openbsd_arm64: sha256:ade0340a6049ef54e7cce1ed74f40ae2dd19ebea4d6c041f987172110b592b7d
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_openbsd_armv6.tar.gz
    openbsd_armv6: sha256:acad6ca616903e2c915ce65046ecdfccbd7abfe8489f72d466d272876ce4e970
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_openbsd_armv7.tar.gz
    openbsd_armv7: sha256:adc74fc2a4ef1995d359e1417798e337d14a347130e06d8e3ebfe49bd11f36c6
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_windows_amd64.tar.gz
    windows_amd64: sha256:3443d4b7cdcba6c39b6bfbc2019d450c22ba0d214a90ac82266666013f2b5406
    # https://github.com/benthosdev/benthos/releases/download/v4.24.0/benthos_4.24.0_windows_arm64.tar.gz
    windows_arm64: sha256:3a31f740e640833720b84f43d7d97107835329afc8646076b89d13fd90e8d5ab
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-benthos/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[andrewrothstein.unarchivedeps](https://galaxy.ansible.com/buluma/andrewrothstein.unarchivedeps)|[![Build Status GitHub](https://github.com/buluma/andrewrothstein.unarchivedeps/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/andrewrothstein.unarchivedeps/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-benthos/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-benthos/issues).

## [License](#license)

[MIT](https://github.com/buluma/ansible-role-benthos/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
