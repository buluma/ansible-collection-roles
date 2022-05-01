# [jira](#jira)

Ansible Role for Atlassian Jira Installation

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-jira/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-jira/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-jira/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-jira)|[![quality](https://img.shields.io/ansible/quality/58886)](https://galaxy.ansible.com/buluma/jira)|[![downloads](https://img.shields.io/ansible/role/d/58886)](https://galaxy.ansible.com/buluma/jira)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-jira.svg)](https://github.com/buluma/ansible-role-jira/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- hosts: all
  remote_user: root
  become: true
  tasks:
    - name: include role
      ansible.builtin.include_role:
        name: openjdk
      tags: openjdk
  roles:
    - role: buluma.jira
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- hosts: all
  remote_user: root
  become: true
  gather_facts: false
  tasks:
    - name: redhat | subscription-manager register
      ansible.builtin.raw: |
        set -eu
        subscription-manager register \
          --username={{ lookup('env', 'REDHAT_USERNAME') }} \
          --password={{ lookup('env', 'REDHAT_PASSWORD') }} \
          --auto-attach
      changed_when: false
      failed_when: false

    - name: debian | apt-get install python3
      ansible.builtin.raw: |
        set -eu
        apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install -y python3
      changed_when: false
      failed_when: false

    - name: redhat | yum install python3
      ansible.builtin.raw: |
        set -eu
        yum makecache
        yum install -y python3
      changed_when: false
      failed_when: false

    - name: suse | zypper install python3
      ansible.builtin.raw: |
        set -eu
        zypper -n --gpg-auto-import-keys refresh
        zypper -n install -y python3
      changed_when: false
      failed_when: false

- hosts: all
  remote_user: root
  become: true
  tasks:
    - name: cp -rfT /etc/skel /root
      ansible.builtin.raw: |
        set -eu
        cp -rfT /etc/skel /root
      changed_when: false
      failed_when: false

    - name: setenforce 0
      ansible.builtin.raw: |
        set -eu
        setenforce 0
        sed -i 's/^SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config
      changed_when: false
      failed_when: false

    - name: systemctl stop firewalld.service
      ansible.builtin.raw: |
        set -eu
        systemctl stop firewalld.service
        systemctl disable firewalld.service
      changed_when: false
      failed_when: false

    - name: systemctl stop ufw.service
      ansible.builtin.raw: |
        set -eu
        systemctl stop ufw.service
        systemctl disable ufw.service
      changed_when: false
      failed_when: false

    - name: debian | apt-get install *.deb
      ansible.builtin.raw: |
        set -eu
        DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 ca-certificates curl gcc gnupg gzip iproute2 passwd procps python3 python3-apt python3-jmespath python3-lxml python3-pip python3-setuptools python3-venv python3-virtualenv python3-wheel rsync sudo tar unzip util-linux xz-utils zip
      when: ansible_os_family | lower == "debian"
      changed_when: false
      failed_when: false

    - name: fedora | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_distribution | lower == "fedora"
      changed_when: false
      failed_when: false

    - name: redhat-9 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum-config-manager --enable crb || echo $?
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "9"
      changed_when: false
      failed_when: false

    - name: redhat-8 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "8"
      changed_when: false
      failed_when: false

    - name: redhat-7 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        subscription-manager repos --enable=rhel-7-server-optional-rpms || echo $?
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip iproute procps-ng python3 python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-plugin-versionlock yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "7"
      changed_when: false
      failed_when: false

    - name: suse | zypper -n install *.rpm
      ansible.builtin.raw: |
        set -eu
        zypper -n install -y bzip2 ca-certificates curl gcc gpg2 gzip iproute2 procps python3 python3-jmespath python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow sudo tar unzip util-linux xz zip
      when: ansible_os_family | lower == "suse"
      changed_when: false
      failed_when: false
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# PostgreSQL JDBC release.
postgresql_jdbc_release: "42.3"

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
jira_catalina_connector_proxyname: ~
jira_catalina_connector_proxyport: ~
jira_catalina_connector_scheme: "http"
jira_catalina_connector_secure: "false"
jira_catalina_context_path: ~

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

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-jira/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[openjdk](https://galaxy.ansible.com/buluma/openjdk)|[![Build Status GitHub](https://github.com/buluma/openjdk/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/openjdk/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/openjdk/badges/master/pipeline.svg)](https://gitlab.com/buluma/openjdk)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-jira/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 4.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-jira/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-jira/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
