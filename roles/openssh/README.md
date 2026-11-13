# [Ansible role openssh](#ansible-role-openssh)

Install and configure openssh on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-openssh/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-openssh/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-openssh.svg)](https://github.com/buluma/ansible-role-openssh/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-openssh.svg)](https://github.com/buluma/ansible-role-openssh/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-openssh.svg)](https://github.com/buluma/ansible-role-openssh/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/openssh)](https://galaxy.ansible.com/ui/standalone/roles/buluma/openssh/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-openssh/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.openssh
      openssh_allow_users:
        - root
      openssh_allow_groups:
        - root
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-openssh/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.selinux
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-openssh/blob/master/defaults/main.yml):

```yaml
---
# defaults file for openssh

# The tcp port ssh should listen on.
openssh_port: 22

openssh_address_family: any

openssh_listen_addresses:
  - "0.0.0.0"
  - "::"

openssh_host_keys:
  - /etc/ssh/ssh_host_rsa_key
  - /etc/ssh/ssh_host_ecdsa_key
  - /etc/ssh/ssh_host_ed25519_key

openssh_rekey_limit: default none

openssh_syslog_facility: AUTH

openssh_loglevel: INFO

openssh_login_grace_time: 2m
openssh_permit_root_login: "yes"
openssh_strict_modes: "yes"
openssh_max_auth_tries: 6
openssh_max_sessions: 10

openssh_pub_key_authentication: "yes"

openssh_authorized_key_file: ".ssh/authorized_keys"

openssh_authorized_prinicpals_file: none
openssh_authorized_keys_command: none
openssh_authorized_keys_command_user: nobody

openssh_host_based_authentication: "no"
openssh_ignore_user_known_hosts: "no"
openssh_ignore_rhosts: "yes"

openssh_permit_empty_passwords: "no"
openssh_password_authentication: "yes"

openssh_challenge_response_authentication: "no"

openssh_gssapi_authentication: "yes"
openssh_gssapi_cleanup_credentials: "no"
openssh_gssapi_strict_acceptor_check: "yes"
openssh_gssapi_key_exchange: "no"
openssh_gssaip_enable_k5_users: "no"

openssh_use_pam: "yes"

openssh_allow_agent_forwarding: "yes"
openssh_allow_tcp_forwarding: "yes"
openssh_gateway_ports: "no"
openssh_x11_forwarding: "yes"
openssh_x11_display_offset: 10
openssh_x11_use_localhost: "yes"
openssh_permit_tty: "yes"

openssh_print_motd: "no"

openssh_print_last_log: "yes"
openssh_tcp_keep_alive: "yes"
openssh_permit_user_environment: "no"
openssh_compression: delayed
openssh_client_alive_interval: 30
openssh_client_alive_count_max: 3
openssh_show_patch_level: "no"
openssh_use_dns: "no"
openssh_pid_file: /var/run/sshd.pid
openssh_max_startups: "10:30:100"
openssh_permit_tunnel: "no"
openssh_chroot_directory: none
openssh_version_addendum: none

openssh_banner: none

openssh_accept_envs:
  - LANG
  - LANGUAGE
  - LC_ADDRESS
  - LC_ALL
  - LC_COLLATE
  - LC_CTYPE
  - LC_IDENTIFICATION
  - LC_MEASUREMENT
  - LC_MESSAGES
  - LC_MONETARY
  - LC_NAME
  - LC_NUMERIC
  - LC_PAPER
  - LC_TELEPHONE
  - LC_TIME
  - XMODIFIERS

openssh_subsystem: sftp {{ openssh_sftp_server }}

# Specifies a file containing public keys of certificate authorities that are
# trusted to sign user certificates for authentication, or none to not use one.
openssh_trusted_user_ca_keys: none

# Restrict access to this (space separated list) of users or groups.
# For example: "openssh_allow_users: root my_user"
# openssh_allow_users:
#  - root

# For example: "openssh_allow_groups: wheel my_group"
# openssh_allow_groups: wheel

# The key exchange methods that are used to generate per-connection keys
# openssh_kexalgorithms:
#   - curve25519-sha256
#   - curve25519-sha256@libssh.org
#   - ecdh-sha2-nistp256
#   - ecdh-sha2-nistp384
#   - ecdh-sha2-nistp521
#   - diffie-hellman-group-exchange-sha256
#   - diffie-hellman-group16-sha512
#   - diffie-hellman-group18-sha512
#   - diffie-hellman-group14-sha256

# The public key algorithms accepted for an SSH server to authenticate itself to an SSH client
# openssh_hostkey_algorithms:
#   - ecdsa-sha2-nistp256-cert-v01@openssh.com
#   - ecdsa-sha2-nistp384-cert-v01@openssh.com
#   - ecdsa-sha2-nistp521-cert-v01@openssh.com
#   - sk-ecdsa-sha2-nistp256-cert-v01@openssh.com
#   - ssh-ed25519-cert-v01@openssh.com
#   - sk-ssh-ed25519-cert-v01@openssh.com
#   - rsa-sha2-512-cert-v01@openssh.com
#   - rsa-sha2-256-cert-v01@openssh.com
#   - ssh-rsa-cert-v01@openssh.com
#   - ecdsa-sha2-nistp256
#   - ecdsa-sha2-nistp384
#   - ecdsa-sha2-nistp521
#   - sk-ecdsa-sha2-nistp256@openssh.com
#   - ssh-ed25519
#   - sk-ssh-ed25519@openssh.com
#   - rsa-sha2-512
#   - rsa-sha2-256
#   - ssh-rsa

# The ciphers to encrypt the connection
# openssh_ciphers:
#   - chacha20-poly1305@openssh.com
#   - aes128-ctr
#   - aes192-ctr
#   - aes256-ctr
#   - aes128-gcm@openssh.com
#   - aes256-gcm@openssh.com

# The message authentication codes used to detect traffic modification
# openssh_macs:
#   - umac-64-etm@openssh.com
#   - umac-128-etm@openssh.com
#   - hmac-sha2-256-etm@openssh.com
#   - hmac-sha2-512-etm@openssh.com
#   - hmac-sha1-etm@openssh.com
#   - umac-64@openssh.com
#   - umac-128@openssh.com
#   - hmac-sha2-256
#   - hmac-sha2-512
#   - hmac-sha1
# openssh_allow_groups:
#  - wheel
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-openssh/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.selinux](https://galaxy.ansible.com/buluma/selinux)|[![Build Status GitHub](https://github.com/buluma/ansible-role-selinux/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-selinux/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-openssh/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-openssh/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-openssh/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
