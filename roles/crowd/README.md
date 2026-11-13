# [Ansible role crowd](#ansible-role-crowd)

Install and configure crowd on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-crowd/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-crowd/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-crowd.svg)](https://github.com/buluma/ansible-role-crowd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-crowd.svg)](https://github.com/buluma/ansible-role-crowd/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-crowd.svg)](https://github.com/buluma/ansible-role-crowd/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/crowd)](https://galaxy.ansible.com/ui/standalone/roles/buluma/crowd/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-crowd/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.crowd
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-crowd/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.java
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-crowd/blob/master/defaults/main.yml):

```yaml
---
# defaults file for crowd

# PostgreSQL JDBC release.
postgresql_jdbc_release: "42.7"

# PostgreSQL JDBC version.
postgresql_jdbc_version: "{{ _postgresql_jdbc_version[postgresql_jdbc_release] }}"

# PostgreSQL JDBC download details.
postgresql_jdbc_download: "{{ _postgresql_jdbc_download[postgresql_jdbc_version] }}"

# Crowd release.
crowd_release: "6.3"

# Crowd version.
crowd_version: "{{ _crowd_version[crowd_release] }}"

# Crowd download details.
crowd_download: "{{ _crowd_download[crowd_version] }}"

# Owner and group for Crowd.
crowd_owner: "crowd"
crowd_group: "crowd"

# Crowd home directory.
crowd_home: "/var/atlassian/application-data/crowd"

# Crowd installation directory.
crowd_catalina: "/opt/atlassian/crowd"

# JVM minimal and maximum memory usage.
crowd_jvm_minimum_memory: "1024m"
crowd_jvm_maximum_memory: "1024m"

# Proxy and context path setup.
crowd_catalina_connector_proxyname:
crowd_catalina_connector_proxyport:
crowd_catalina_connector_scheme: "http"
crowd_catalina_connector_secure: "false"
crowd_catalina_context_path:
# Atlassian Support recommended JVM arguments.
# UseCGroupMemoryLimitForHeap was dropped for good starting with Java 11
# ("Unrecognized VM option") - container memory awareness is on by default
# since Java 10 (UseContainerSupport), so it's no longer needed anyway.
crowd_jvm_support_recommended_args: >-
  -Datlassian.plugins.enable.wait=300
  -XX:MaxRAMFraction=1

# Session timeout (in minutes).
crowd_session_timeout: "120"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-crowd/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.java](https://galaxy.ansible.com/buluma/java)|[![Build Status GitHub](https://github.com/buluma/ansible-role-java/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-java/actions)|
|[alvistack.openjdk](https://galaxy.ansible.com/buluma/alvistack.openjdk)|[![Build Status GitHub](https://github.com/buluma/alvistack.openjdk/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/alvistack.openjdk/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-crowd/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-crowd/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-crowd/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
