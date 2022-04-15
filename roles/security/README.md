# [security](#security)

Security software installation and configuration.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-security/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-security/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-security/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-security)|[![quality](https://img.shields.io/ansible/quality/58018)](https://galaxy.ansible.com/buluma/security)|[![downloads](https://img.shields.io/ansible/role/d/58018)](https://galaxy.ansible.com/buluma/security)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-security.svg)](https://github.com/buluma/ansible-role-security/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      ansible.builtin.package:
        update_cache: true
        cache_valid_time: 600
      when: ansible_os_family == 'Debian'

    - name: Ensure build dependencies are installed (RedHat).
      ansible.builtin.package:
        name:
          - openssh-server
          - openssh-clients
        state: present
      when: ansible_os_family == 'RedHat'

    - name: Ensure build dependencies are installed (Fedora).
      ansible.builtin.package:
        name: procps
        state: present
      when: ansible_distribution == 'Fedora'

    - name: Ensure build dependencies are installed (Debian).
      ansible.builtin.package:
        name:
          - openssh-server
          - openssh-client
        state: present
      when: ansible_os_family == 'Debian'

    - name: Ensure auth.log file is present.
      ansible.builtin.copy:
        dest: /var/log/auth.log
        content: ""
        force: false
        mode: 0644
      when: ansible_distribution == 'Debian'

  roles:
    - role: buluma.security
      security_autoupdate_enabled: false
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
    - role: buluma.repo_epel
      when:
        - (ansible_distribution == "Amazon" and
          ansible_distribution_major_version == "2") or
          (ansible_os_family == "RedHat" and
          ansible_distribution_major_version in [ "7", "8" ])
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
security_ssh_port: 22
security_ssh_password_authentication: "no"
security_ssh_permit_root_login: "no"
security_ssh_usedns: "no"
security_ssh_permit_empty_password: "no"
security_ssh_challenge_response_auth: "no"
security_ssh_gss_api_authentication: "no"
security_ssh_x11_forwarding: "no"
security_sshd_state: started
security_ssh_restart_handler_state: restarted
security_ssh_allowed_users: []
security_ssh_allowed_groups: []

security_sudoers_passwordless: []
security_sudoers_passworded: []

security_autoupdate_enabled: false
security_autoupdate_blacklist: []
security_autoupdate_secpkgs_only: false

# Autoupdate mail settings used on Debian/Ubuntu only.
security_autoupdate_reboot: "false"
security_autoupdate_reboot_time: "03:00"
security_autoupdate_mail_to: ""
security_autoupdate_mail_on_error: true

security_fail2ban_enabled: true
security_fail2ban_custom_configuration_template: "jail.local.j2"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-security/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|
|[buluma.repo_epel](https://galaxy.ansible.com/buluma/repo_epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-repo_epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-repo_epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-repo_epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-repo_epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-security/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|fedora|rawhide, latest|
|debian|bookworm, buster, bullseye, stretch, sid, jessie|
|ubuntu|impish, focal, bionic, hirsute, jammy|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| Ubuntu:trusty | ansible-core requires a minimum of Python2 version 2.6 or Python3 version 3.5. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-security/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
