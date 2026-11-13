# [Ansible role telegraf](#ansible-role-telegraf)

Installing and configuring Telegraf

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-telegraf/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-telegraf/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/telegraf)](https://galaxy.ansible.com/ui/standalone/roles/buluma/telegraf/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-telegraf/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: false
  gather_facts: true
  pre_tasks:
    - ansible.builtin.apt: update_cache=yes cache_valid_time=600
      name: Update apt cache.
      changed_when: false
      when: ansible_facts['os_family'] == 'Debian'
  roles:
    - role: buluma.telegraf
  tasks:
    - ansible.builtin.dnf:
        name: which
        state: present
      name: Installing packages on CentOS
      when:
        - ansible_facts['os_family'] == 'RedHat'
    - name: Apt get update
      ansible.builtin.command: apt-get update
      tags:
        - molecule-idempotence-notest
      when:
        - ansible_facts['os_family'] == 'Debian'
    - name: Installing packages on Debian
      ansible.builtin.apt:
        name:
          - wget
          - "{{ 'gnupg-agent' if ansible_facts['distribution_major_version'] in ['8', '18', '16'] else 'gpg-agent' }}"
        state: present
        update_cache: true
      when:
        - ansible_facts['os_family'] == 'Debian'
        - ansible_facts['distribution_major_version'] not in [9, 10]
    - name: Installing packages on Debian
      ansible.builtin.apt:
        name:
          - wget
          - python-apt
          - "{{ 'gnupg-agent' if ansible_facts['distribution_major_version'] in ['8', '18', '16'] else 'gpg-agent' }}"
        state: present
        update_cache: true
      when:
        - ansible_facts['os_family'] == 'Debian'
        - ansible_facts['distribution_major_version'] in [9, 10]
    - name: Installing packages on Suse
      community.general.zypper:
        name:
          - aaa_base
        state: present
      when:
        - ansible_facts['os_family'] == 'Suse'
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-telegraf/blob/master/molecule/default/prepare.yml):

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

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-telegraf/blob/master/defaults/main.yml):

```yaml
---
telegraf_agent_aws_tags: false
telegraf_agent_aws_tags_prefix: ""
telegraf_agent_collection_jitter: 0
telegraf_agent_config_path: /etc/telegraf
telegraf_agent_debug: false
telegraf_agent_docker: false
telegraf_agent_docker_image_version: "{{ telegraf_agent_version }}"
telegraf_agent_docker_name: telegraf
telegraf_agent_docker_network_mode: bridge
telegraf_agent_docker_restart_policy: unless-stopped
telegraf_agent_flush_interval: 10
telegraf_agent_flush_jitter: 0
telegraf_agent_hostname: "{{ ansible_facts['fqdn'] }}"
telegraf_agent_interval: 10
telegraf_agent_logfile: ""
telegraf_agent_metric_batch_size: 1000
telegraf_agent_metric_buffer_limit: 10000
telegraf_agent_omit_hostname: false
telegraf_agent_output:
  - config:
      - urls = ["http://localhost:8086"]
      - database = "telegraf"
      - precision = "s"
    type: influxdb
telegraf_agent_package: telegraf
telegraf_agent_package_file_deb: telegraf_{{ telegraf_agent_version }}-{{ telegraf_agent_version_patch }}_{{ telegraf_agent_package_arch }}.deb
telegraf_agent_package_file_rpm: telegraf-{{ telegraf_agent_version }}-{{ telegraf_agent_version_patch }}.{{ ansible_facts['architecture'] }}.rpm
telegraf_agent_package_method: repo
telegraf_agent_package_path: /tmp
telegraf_agent_package_state: present
telegraf_agent_quiet: false
telegraf_agent_round_interval: true
telegraf_agent_version: "1.40.2"
telegraf_agent_version_patch: 1
telegraf_enabled: true
telegraf_gid_docker: 995
telegraf_global_tags: []
telegraf_mac_group: admin
telegraf_mac_user: user
telegraf_plugins_default:
  - config:
      - percpu = true
    plugin: cpu
  - plugin: disk
  - plugin: io
  - plugin: mem
  - plugin: net
  - plugin: system
  - plugin: swap
  - plugin: netstat
  - plugin: processes
  - plugin: kernel
telegraf_plugins_extra: {}
telegraf_plugins_extra_exclusive: false
telegraf_redhat_releasever: $releasever
telegraf_uid_docker: 998
telegraf_win_include: "C:\\Telegraf\\telegraf_agent.d"
telegraf_win_install_dir: "C:\\Telegraf"
telegraf_win_logfile: "C:\\Telegraf\\telegraf.log"
telegraf_win_logfile_rotation_max_archives: 3
telegraf_win_service_args:
  - -service install
  - -config "{{ telegraf_win_install_dir }}\telegraf.conf"
  - --config-directory "{{ telegraf_win_include }}"
telegraf_yum_baseurl:
  amazon: https://repos.influxdata.com/centos/6/$basearch/stable
  centos: https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable
  default: https://repos.influxdata.com/{{ ansible_facts['distribution']|lower }}/{{ telegraf_redhat_releasever }}/$basearch/stable
  redhat: https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable
  rocky: https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable
telegraf_yum_gpgkey: "https://repos.influxdata.com/influxdata-archive_compat.key"
telegraf_zypper_repos:
  default: http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Factory/
  opensuse leap: http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_{{ ansible_facts['distribution_version'] }}/
  opensuse tumbleweed: http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Factory/
  sles: http://download.opensuse.org/repositories/devel:/languages:/go/SLE_{{ ansible_facts['distribution_major_version'] }}_SP{{
    ansible_facts['distribution_release'] }}/
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-telegraf/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-telegraf/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-telegraf/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-telegraf/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
