# [telegraf](#telegraf)

Installing and configuring Telegraf

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-telegraf/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-telegraf/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-telegraf/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-telegraf)|[![quality](https://img.shields.io/ansible/quality/58622)](https://galaxy.ansible.com/buluma/telegraf)|[![downloads](https://img.shields.io/ansible/role/d/58622)](https://galaxy.ansible.com/buluma/telegraf)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-telegraf.svg)](https://github.com/buluma/ansible-role-telegraf/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- hosts: all
  roles:
    - role: buluma.bootstrap
    - role: buluma.ca_certificates
    - role: buluma.telegraf
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---

- hosts: all
  roles:
    - name: buluma.bootstrap
    - name: buluma.ca_certificates

  tasks:
    - name: "Installing packages on CentOS"
      yum:
        name: which
        state: present
      when:
        - ansible_os_family == 'RedHat'

    - name: "Apt get update"
      shell: apt-get update && apt-get install -y python3-apt
      when:
        - ansible_os_family == 'Debian'

    - name: "Installing packages on Debian"
      apt:
        name:
          - wget
          - python3-apt
          - "{{ 'gnupg-agent' if ansible_distribution_major_version in ['8', '18', '16'] else 'gpg-agent' }}"
        update_cache: True
        state: present
      when:
        - ansible_os_family == 'Debian'

    - name: "Installing packages on Suse"
      zypper:
        name:
          - aaa_base
        state: present
      when:
        - ansible_os_family == 'Suse'
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
telegraf_enabled: True

telegraf_agent_version: 1.22.0
telegraf_agent_version_patch: 1
telegraf_agent_package: telegraf
telegraf_agent_package_file_deb: telegraf_{{ telegraf_agent_version }}-{{ telegraf_agent_version_patch }}_{{ telegraf_agent_package_arch }}.deb
telegraf_agent_package_file_rpm: telegraf-{{ telegraf_agent_version }}-{{ telegraf_agent_version_patch }}.{{ ansible_architecture }}.rpm
telegraf_agent_package_path: /tmp
telegraf_agent_package_method: repo
telegraf_agent_package_state: present
telegraf_agent_hostname: "{{ ansible_fqdn }}"
telegraf_agent_interval: 10
telegraf_agent_debug: False
telegraf_agent_round_interval: True
telegraf_agent_flush_interval: 10
telegraf_agent_flush_jitter: 0
telegraf_agent_aws_tags: False
telegraf_agent_aws_tags_prefix: ""
telegraf_agent_config_path: /etc/telegraf
telegraf_win_logfile_rotation_max_archives: 3

# Docker specific settings
telegraf_uid_docker: 998
telegraf_gid_docker: 995
telegraf_agent_docker: False
telegraf_agent_docker_name: telegraf
telegraf_agent_docker_network_mode: bridge
telegraf_agent_docker_restart_policy: unless-stopped
telegraf_agent_docker_image_version: "{{ telegraf_agent_version }}"

# v0.13 settings (not sure if supported in older version):
telegraf_agent_collection_jitter: 0
telegraf_agent_metric_batch_size: 1000
telegraf_agent_metric_buffer_limit: 10000
telegraf_agent_quiet: False

# v1.1 settings:
telegraf_agent_logfile: ""
telegraf_agent_omit_hostname: False

telegraf_global_tags: []

telegraf_agent_output:
  - type: influxdb
    config:
      - urls = ["http://localhost:8086"]
      - database = "telegraf"
      - precision = "s"

# defaults - /etc/telegraf/telegraf.conf
telegraf_plugins_default:
  - plugin: cpu
    config:
      - percpu = true
  - plugin: disk
  - plugin: io
  - plugin: mem
  - plugin: net
  - plugin: system
  - plugin: swap
  - plugin: netstat
  - plugin: processes
  - plugin: kernel

# extra configuration - /etc/telegraf/telegraf.d/*
telegraf_plugins_extra: {}
telegraf_plugins_extra_exclusive: False

# RedHat specific settings for convenience
telegraf_redhat_releasever: "$releasever"

telegraf_yum_baseurl:
  amazon: "https://repos.influxdata.com/centos/6/$basearch/stable"
  centos: "https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable"
  default: "https://repos.influxdata.com/{{ ansible_distribution|lower }}/{{ telegraf_redhat_releasever }}/$basearch/stable"
  redhat: "https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable"
  rocky: "https://repos.influxdata.com/rhel/{{ telegraf_redhat_releasever }}/$basearch/stable"
telegraf_yum_gpgkey: "https://repos.influxdata.com/influxdb.key"

telegraf_zypper_repos:
  "opensuse tumbleweed": "http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Factory/"
  "default": "http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Factory/"
  "sles": "http://download.opensuse.org/repositories/devel:/languages:/go/SLE_{{ ansible_distribution_major_version }}_SP{{ ansible_distribution_release }}/"
  "opensuse leap": "http://download.opensuse.org/repositories/devel:/languages:/go/openSUSE_Leap_{{ ansible_distribution_version }}/"

telegraf_win_install_dir: 'C:\Telegraf'
telegraf_win_logfile: 'C:\\Telegraf\\telegraf.log'
telegraf_win_include: 'C:\Telegraf\telegraf_agent.d'
telegraf_win_service_args:
  - -service install
  - -config {{ telegraf_win_install_dir }}\telegraf.conf
  - --config-directory {{ telegraf_win_include }}

telegraf_mac_user: user
telegraf_mac_group: admin
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-telegraf/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.ca_certificates](https://galaxy.ansible.com/buluma/ca_certificates)|[![Build Status GitHub](https://github.com/buluma/ansible-role-ca_certificates/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-ca_certificates/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-ca_certificates/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-ca_certificates)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-telegraf/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-telegraf/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
