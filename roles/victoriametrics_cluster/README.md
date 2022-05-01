# [victoriametrics_cluster](#victoriametrics_cluster)

Role for installing VictoriaMetrics Cluster

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-victoriametrics_cluster/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-victoriametrics_cluster/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-victoriametrics_cluster/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-victoriametrics_cluster)|[![quality](https://img.shields.io/ansible/quality/58578)](https://galaxy.ansible.com/buluma/victoriametrics_cluster)|[![downloads](https://img.shields.io/ansible/role/d/58578)](https://galaxy.ansible.com/buluma/victoriametrics_cluster)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-victoriametrics_cluster.svg)](https://github.com/buluma/ansible-role-victoriametrics_cluster/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-victoriametrics_cluster.svg)](https://github.com/buluma/ansible-role-victoriametrics_cluster/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-victoriametrics_cluster.svg)](https://github.com/buluma/ansible-role-victoriametrics_cluster/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    - role: buluma.victoriametrics_cluster
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: true
  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults settings for all VictoriaMetrics nodes
victoriametrics_repo_url: "https://github.com/VictoriaMetrics/VictoriaMetrics"
victoriametrics_download_url: "{{ victoriametrics_repo_url }}/releases/download/{{ victoriametrics_version }}/victoria-metrics-amd64-{{ victoriametrics_version }}-cluster.tar.gz"
victoriametrics_version: "v1.58.0"
victoriametrics_system_user: "victoria"
victoriametrics_system_group: "victoria"

# variables for vmstorage nodes
victoriametrics_vmstorage_data_dir: "/usr/local/bin/victoria-storage"
victoriametrics_vmstorage_retention_period: "24"
victoriametrics_vmstorage_memory_allowed_percent: "60"
victoriametrics_vmstorage_service_args: "-search.maxUniqueTimeseries=3000000"

# variables for vmselect nodes
victoriametrics_vmselect_cache_dir: "/usr/local/bin/victoria-cache"
victoriametrics_vmselect_service_args: "-search.maxPointsPerTimeseries=1000000000 -search.maxQueryDuration=120s"
victoriametrics_vmselect_memory_allowed_percent: "60"

# variables for vminsert nodes
victoriametrics_vminsert_service_args: ""
victoriametrics_vminsert_memory_allowed_percent: "60"

# variables for service's listen address
victoriametrics_vmstorage_listen_address: "{{ ansible_default_ipv4.address }}"
victoriametrics_vmselect_listen_address: "{{ ansible_default_ipv4.address }}"
victoriametrics_vminsert_listen_address: "{{ ansible_default_ipv4.address }}"

# sysctl settings. more info :
custom_sysctl:
# http://www.nateware.com/linux-network-tuning-for-2013.html
# Increase Linux autotuning TCP buffer limits
# Set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE
# Don't set tcp_mem itself! Let the kernel scale it based on RAM.
  - { name: net.core.rmem_max, value: 16777216 }
  - { name: net.core.wmem_max, value: 16777216 }
  - { name: net.core.rmem_default, value: 16777216 }
  - { name: net.core.wmem_default, value: 16777216 }
  - { name: net.core.optmem_max, value: 40960 }
# cloudflare uses this for balancing latency and throughput
# https://blog.cloudflare.com/the-story-of-one-latency-spike/
  - { name: net.ipv4.tcp_rmem, value: 4096 1048576 2097152 }
# net.ipv4.tcp_rmem, value: 4096 87380 16777216 }
  - { name: net.ipv4.tcp_wmem, value: 4096 65536 16777216 }
# Also increase the max packet backlog
  - { name: net.core.netdev_budget, value: 50000 }
  - { name: net.core.netdev_max_backlog, value: 100000 }
# Make room for more TIME_WAIT sockets due to more clients,
# and allow them to be reused if we run out of sockets
  - { name: net.ipv4.tcp_max_syn_backlog, value: 30000 }
  - { name: net.ipv4.tcp_max_tw_buckets, value: 2000000 }
  - { name: net.ipv4.tcp_tw_reuse, value: 1 }
  - { name: net.ipv4.tcp_fin_timeout, value: 10 }
# Disable TCP slow start on idle connections
  - { name: net.ipv4.tcp_slow_start_after_idle, value: 0 }
# max open files https://medium.com/@muhammadtriwibowo/set-permanently-ulimit-n-open-files-in-ubuntu-4d61064429a
  - { name: fs.file-max, value: 65535 }
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-victoriametrics_cluster/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-victoriametrics_cluster/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|7, 8|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-victoriametrics_cluster/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-victoriametrics_cluster/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
