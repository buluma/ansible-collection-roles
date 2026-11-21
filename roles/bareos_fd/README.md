# [Ansible role bareos_fd](#ansible-role-bareos_fd)

Install and configure [Bareos](https://www.bareos.com/) File Daemon.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-bareos_fd/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-bareos_fd/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bareos_fd.svg)](https://github.com/buluma/ansible-role-bareos_fd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bareos_fd.svg)](https://github.com/buluma/ansible-role-bareos_fd/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bareos_fd.svg)](https://github.com/buluma/ansible-role-bareos_fd/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/bareos_fd)](https://galaxy.ansible.com/ui/standalone/roles/buluma/bareos_fd/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-bareos_fd/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.bareos_repository
    - role: buluma.bareos_fd
      bareos_fd_backup_configurations: true
      bareos_fd_install_debug_packages: true
      bareos_fd_encryption_enabled: true
      bareos_fd_encryption_private_key: "{{ lookup('ansible.builtin.file', lookup('ansible.builtin.env', 'MOLECULE_EPHEMERAL_DIRECTORY') ~ '/bareos_fd_private.key', rstrip=False) }}"
      bareos_fd_encryption_master_public_key: |
        -----BEGIN CERTIFICATE-----
        MIIDyjCCArKgAwIBAgIJAIAjOIGqAGRwMA0GCSqGSIb3DQEBCwUAMIGSMQswCQYD
        VQQGEwJOTDEQMA4GA1UECAwHVVRSRUNIVDESMBAGA1UEBwwJQnJldWtlbGVuMSIw
        IAYDVQQKDBlBZGZpbmlzIElUIE5lZGVybGFuZCBCLlYuMQ8wDQYDVQQDDAZiYXJl
        b3MxKDAmBgkqhkiG9w0BCQEWGXJvYmVydC5kZWJvY2tAYWRmaW5pcy5jb20wHhcN
        MjMwOTExMDg1MzA0WhcNMjMxMDExMDg1MzA0WjCBkjELMAkGA1UEBhMCTkwxEDAO
        BgNVBAgMB1VUUkVDSFQxEjAQBgNVBAcMCUJyZXVrZWxlbjEiMCAGA1UECgwZQWRm
        aW5pcyBJVCBOZWRlcmxhbmQgQi5WLjEPMA0GA1UEAwwGYmFyZW9zMSgwJgYJKoZI
        hvcNAQkBFhlyb2JlcnQuZGVib2NrQGFkZmluaXMuY29tMIIBIjANBgkqhkiG9w0B
        AQEFAAOCAQ8AMIIBCgKCAQEAxFjcLKHDTf8dcT4kKtyZlIh4Zh7zNglaa6SJNBGW
        pmcvtgfR9aBCDbcEphcssdytrXIiLsCEfv1h63o58UXePKYJMtNzbn6NNyzamxB9
        CM4oHWr/td8i6fYaYXmqOxOimX707joWPlTB9+/rKWFrxwyg08oVGFdBNR6GmWek
        Y5aRaEMwRBhh+bSVR9/Rj/QmqlF9pCB9/TtY3hhBdQkcy1tLTDo7Mf/Z4gLpk7d2
        vRmpvVY8JloXjzuJNgVNbzY09pylqe78m9UsrJGBlzocZO5+AnO7wsqMAtUvplOM
        oE7GHrg1FpfLjY3bqTQka/fVd1bDt5eDjAJnPqO1RYpKjQIDAQABoyEwHzAdBgNV
        HQ4EFgQURTeY0pPxExJwTelsdBXr5PxgOdAwDQYJKoZIhvcNAQELBQADggEBALCi
        urw+j1Yg2QDkOzMxmr6r0O/kF3WfrfpcevOCGVN0GxdxP/nGcfAh8feq4xj4oAnS
        2CyhNfPPi+rIO1T0EkZWwL/kTByMGoR9Qc+juMgJ1HTYP6nEnBOXPMo1OyUdK5K3
        MefQpNgHdWNSjWtLuW3YW8rkIeF8ZjmlXOSmBdOmqFi7p3OwwF8FnuXze1RLTgPL
        VeI8D8DtzbX+mocuYxfIAFEmRXAmMeimXgwrVyI+w8+3IRGw8rDje0pFZX5X2aED
        Gcz2IVF2cw5k1ryYW5kN027oK9igd8qc6dcJC6nMJw1kLbBdo68Eq3EOx92Fljlg
        Wa7Dw2pD6yQGl/dfgQg=
        -----END CERTIFICATE-----
      bareos_fd_directors:
        - name: "bareos-dir"
          password: "secretpassword"
          monitor: false
          connection_from_client_to_director: true
          connection_from_director_to_client: false
          tls_enable: true
          tls_verify_peer: false
        - name: "disabled-director"
          enabled: false
      bareos_fd_messages:
        - name: "Standard"
          director:
            server: bareos-dir
            messages:
              - all
              - "!skipped"
              - "!restored"
          description: "Send relevant messages to the Director."
          append:
            file: "/var/log/bareos/bareos.log"
            messages:
              - all
              - "!skipped"
              - "!terminate"
          console:
            - all
            - "!skipped"
            - "!saved"
        - name: "disabled-message"
          enabled: false
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-bareos_fd/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.bareos_repository
      bareos_repository_enable_tracebacks: true
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-bareos_fd/blob/master/defaults/main.yml):

```yaml
---
# defaults file for bareos_fd

# The client has these configuration parameters.

# Backup existing configurations.
bareos_fd_backup_configurations: false

# Install debug packages. This requires the debug repositories to be enabled.
bareos_fd_install_debug_packages: false

# The hostname of the File Daemon.
bareos_fd_hostname: "{{ inventory_hostname }}"

# The maximum bandwidth to use.
bareos_fd_max_job_bandwidth: "10 mb/s"

# The message to use.
bareos_fd_message: "Standard"

# The maximum number of concurrent jobs.
bareos_fd_maximum_concurrent_jobs: 20

# Enable TLS.
bareos_fd_tls_enable: true

# Verify the peer.
bareos_fd_tls_verify_peer: false

# The inteval in seconds to send a heartbeat.
bareos_fd_heartbeat_interval: 0

# The Directors to connect to.
bareos_fd_directors:
  - name: "bareos-dir"
    password: "secretpassword"
    monitor: false
    description: "Allow the configured Director to access this file daemon."
  - name: bareos-mon
    password: "secretpassword"
    monitor: true
    description: "Restricted Director, used by tray-monitor to get the status of this file daemon."

# The Messages to configure.
bareos_fd_messages:
  - name: "Standard"
    director:
      server: bareos-dir
      messages:
        - all
        - "!skipped"
        - "!restored"
    description: "Send relevant messages to the Director."

# For encryption of data, set this to `true`.
bareos_fd_encryption_enabled: false

# You may bring your own private key. If not specified, a new one will be generated.
bareos_fd_encryption_private_key: ""

# The master public key to use.
bareos_fd_encryption_master_public_key: ""
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bareos_fd/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.bareos_repository](https://galaxy.ansible.com/buluma/bareos_repository)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bareos_repository/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bareos_repository/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bareos_fd/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|all|
|[Fedora](https://hub.docker.com/r/buluma/docker-molecule-images)|44, 43|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|all|

The minimum version of Ansible required is 2.19, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-bareos_fd/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-bareos_fd/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
