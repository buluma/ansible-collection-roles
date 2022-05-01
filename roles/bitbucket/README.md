# [bitbucket](#bitbucket)

Ansible Role for Atlassian Bitbucket Installation

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-bitbucket/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bitbucket/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-bitbucket/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bitbucket)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/bitbucket)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/bitbucket)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-bitbucket.svg)](https://github.com/buluma/ansible-role-bitbucket/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.git
    - role: buluma.openjdk
    - role: buluma.bitbucket
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - name: buluma.bootstrap
    - name: buluma.git
    - name: buluma.openjdk

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
        DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 ca-certificates curl gcc gnupg gzip hostname iproute2 passwd procps python3 python3-apt python3-jmespath python3-lxml python3-pip python3-setuptools python3-venv python3-virtualenv python3-wheel rsync sudo tar unzip util-linux xz-utils zip
      when: ansible_os_family | lower == "debian"
      changed_when: false
      failed_when: false

    - name: fedora | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip hostname iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_distribution | lower == "fedora"
      changed_when: false
      failed_when: false

    - name: redhat-9 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum-config-manager --enable crb || echo $?
        yum-config-manager --enable codeready-builder-beta-for-rhel-9-x86_64-rpms || echo $?
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip hostname iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "9"
      changed_when: false
      failed_when: false

    - name: redhat-8 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip hostname iproute procps-ng python3 python3-dnf-plugin-versionlock python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "8"
      changed_when: false
      failed_when: false

    - name: redhat-7 | yum install *.rpm
      ansible.builtin.raw: |
        set -eu
        subscription-manager repos --enable=rhel-7-server-optional-rpms || echo $?
        yum install -y http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        yum install -y bzip2 ca-certificates curl gcc gnupg2 gzip hostname iproute procps-ng python3 python3-jmespath python3-libselinux python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow-utils sudo tar unzip util-linux xz yum-plugin-versionlock yum-utils zip
      when: ansible_os_family | lower == "redhat" and ansible_distribution_major_version | lower == "7"
      changed_when: false
      failed_when: false

    - name: suse | zypper -n install *.rpm
      ansible.builtin.raw: |
        set -eu
        zypper -n install -y bzip2 ca-certificates curl gcc gpg2 gzip hostname iproute2 procps python3 python3-jmespath python3-lxml python3-pip python3-setuptools python3-virtualenv python3-wheel rsync shadow sudo tar unzip util-linux xz zip
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

# Bitbucket release.
bitbucket_release: "7.21"

# Bitbucket version.
bitbucket_version: "{{ _bitbucket_version[bitbucket_release] }}"

# Bitbucket download details.
bitbucket_download: "{{ _bitbucket_download[bitbucket_version] }}"

# Owner and group for Bitbucket.
bitbucket_owner: "bitbucket"
bitbucket_group: "bitbucket"

# Bitbucket home directory.
bitbucket_home: "/var/atlassian/application-data/bitbucket"

# Bitbucket installation directory.
bitbucket_catalina: "/opt/atlassian/bitbucket"

# JVM minimal and maximum memory usage.
bitbucket_jvm_minimum_memory: "2048m"
bitbucket_jvm_maximum_memory: "2048m"

# Proxy and context path setup.
bitbucket_catalina_connector_proxyname: ~
bitbucket_catalina_connector_proxyport: ~
bitbucket_catalina_connector_scheme: "http"
bitbucket_catalina_connector_secure: "false"
bitbucket_catalina_context_path: ~

# Atlassian Support recommended JVM arguments.
bitbucket_jvm_support_recommended_args: >-
  -Datlassian.plugins.enable.wait=300
  -XX:+UnlockExperimentalVMOptions
  -XX:+UseCGroupMemoryLimitForHeap
  -XX:MaxRAMFraction=1

# Session timeout (in mintues).
bitbucket_session_timeout: "120"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-bitbucket/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-git/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-git)|
|[buluma.openjdk](https://galaxy.ansible.com/buluma/openjdk)|[![Build Status GitHub](https://github.com/buluma/ansible-role-openjdk/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-openjdk/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-openjdk/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-openjdk)|
|[community.general](https://galaxy.ansible.com/buluma/community.general)|[![Build Status GitHub](https://github.com/buluma/community.general/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/community.general/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/community.general/badges/master/pipeline.svg)](https://gitlab.com/buluma/community.general)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-bitbucket/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|el|all|
|opensuse|all|
|debian|all|
|fedora|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-bitbucket/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-bitbucket/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
