# [Ansible role bootstrap](#ansible-role-bootstrap)

Prepare your system to be managed by Ansible.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-bootstrap/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bootstrap.svg)](https://github.com/buluma/ansible-role-bootstrap/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bootstrap.svg)](https://github.com/buluma/ansible-role-bootstrap/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bootstrap.svg)](https://github.com/buluma/ansible-role-bootstrap/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/bootstrap)](https://galaxy.ansible.com/ui/standalone/roles/buluma/bootstrap/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-bootstrap/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  # This role installs packages using the `raw` module and needs to connect as
  # `root`. (`sudo` is not available before bootstrapping.) All tasks in the
  # role have `become` set to `false`, so you can use either `false` or `true`
  # for `become`, the role will not use become (so `sudo`) for any task.
  become: true # `false` will also work.
  # This role installs python, gathering facts can't be done before `python` is
  # installed. This role runs the `setup` module, so facts will be available
  # after running the role.
  gather_facts: false

  roles:
    - role: buluma.bootstrap
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-bootstrap/blob/master/molecule/default/prepare.yml):

```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: false

  tasks:
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
        if [ -f /etc/sudoers ]; then
          if ! grep -q '^%wheel ALL=(ALL) NOPASSWD: ALL' /etc/sudoers; then
            echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers;
          fi;
          if command -v visudo >/dev/null 2>&1; then visudo -cf /etc/sudoers || true; fi;
        fi;
        if [ -f /etc/authselect/system-auth ]; then
          authselect enable-feature with-mkhomedir 2>/dev/null || true;
          sed -i 's/^account.*required.*pam_nologin.so/account     [default=bad=ignore success=ok] pam_permit.so/' /etc/authselect/system-auth 2>/dev/null || true;
        fi;
        sed -i 's/^.*pam_wheel.so.*/#&/' /etc/pam.d/sudo 2>/dev/null || true;
        echo "root:root" | chpasswd 2>/dev/null || true
      become: false
      changed_when: false
      failed_when: false
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-bootstrap/blob/master/defaults/main.yml):

```yaml
---
# defaults file for bootstrap

# Do you want to wait for the host to be available?
bootstrap_wait_for_host: false

# The number of seconds you want to wait during connection test before failing.
bootstrap_timeout: 30

# Tell the role to "become" or not.
bootstrap_become: false
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bootstrap/blob/master/requirements.txt).


## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bootstrap/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-bootstrap/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-bootstrap/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
