# [Ansible role jira](#ansible-role-jira)

Ansible Role for Atlassian Jira Installation

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-jira/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-jira/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/jira)](https://galaxy.ansible.com/ui/standalone/roles/buluma/jira/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-jira/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  roles:
    - role: buluma.jira
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-jira/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-jira/blob/master/defaults/main.yml):

```yaml
---
# PostgreSQL JDBC release.
postgresql_jdbc_release: "42.7"

# PostgreSQL JDBC version.
postgresql_jdbc_version: "{{ _postgresql_jdbc_version[postgresql_jdbc_release] }}"

# PostgreSQL JDBC download details.
postgresql_jdbc_download: "{{ _postgresql_jdbc_download[postgresql_jdbc_version] }}"

# Jira release.
jira_release: "8.22"

# Jira version.
jira_version: "{{ _jira_version[jira_release] }}"

# Jira download details.
jira_download: "{{ _jira_download[jira_version] }}"

# Owner and group for Jira.
jira_owner: "jira"
jira_group: "jira"

# Jira home directory.
jira_home: "/var/atlassian/application-data/jira"

# Jira installation directory.
jira_catalina: "/opt/atlassian/jira"

# JVM minimal and maximum memory usage.
jira_jvm_minimum_memory: "2048m"
jira_jvm_maximum_memory: "2048m"

# Proxy and context path setup.
jira_catalina_connector_proxyname:
jira_catalina_connector_proxyport:
jira_catalina_connector_scheme: "http"
jira_catalina_connector_secure: "false"
jira_catalina_context_path:
# Atlassian Support recommended JVM arguments.
jira_jvm_support_recommended_args: >-
  -Datlassian.plugins.enable.wait=300
  -XX:+UnlockExperimentalVMOptions
  -XX:+UseCGroupMemoryLimitForHeap
  -XX:MaxRAMFraction=1

# Session timeout (in minutes).
jira_session_timeout: "120"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-jira/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[alvistack.openjdk](https://galaxy.ansible.com/buluma/alvistack.openjdk)|[![Build Status GitHub](https://github.com/buluma/alvistack.openjdk/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/alvistack.openjdk/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-jira/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-jira/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-jira/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
