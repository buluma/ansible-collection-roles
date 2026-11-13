# [Ansible role security](#ansible-role-security)

Security software installation and configuration.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-security/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-security/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/security)](https://galaxy.ansible.com/ui/standalone/roles/buluma/security/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-security/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  roles:
    - role: buluma.security
      security_autoupdate_enabled: false
      security_fail2ban_enabled: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-security/blob/master/molecule/default/prepare.yml):

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
      ansible.builtin.lineinfile:
        path: /etc/sudoers
        state: present
        regexp: '^%wheel'
        line: '%wheel ALL=(ALL) NOPASSWD: ALL'
        validate: 'visudo -cf %s'
      become: true

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.repo_epel
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-security/blob/master/defaults/main.yml):

```yaml
---
security_autoupdate_blacklist: []
security_autoupdate_enabled: false
security_autoupdate_mail_on_error: true
security_autoupdate_mail_to: ""
security_autoupdate_reboot: "false"
security_autoupdate_reboot_time: "03:00"
security_autoupdate_secpkgs_only: false
security_fail2ban_custom_configuration_template: jail.local.j2
security_fail2ban_enabled: true
security_ssh_allowed_groups: []
security_ssh_allowed_users: []
security_ssh_challenge_response_auth: "no"
security_ssh_gss_api_authentication: "no"
security_ssh_password_authentication: "no"
security_ssh_permit_empty_password: "no"
security_ssh_permit_root_login: "no"
security_ssh_port: 22
security_ssh_restart_handler_state: restarted
security_ssh_usedns: "no"
security_ssh_x11_forwarding: "no"
security_sshd_state: started
security_sudoers_passworded: []
security_sudoers_passwordless: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-security/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|
|[buluma.repo_epel](https://galaxy.ansible.com/buluma/repo_epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-repo_epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-repo_epel/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-security/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9, 8|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-security/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-security/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
