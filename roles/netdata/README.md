# [Ansible role netdata](#ansible-role-netdata)

Install and configure netdata.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-netdata/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-netdata/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-netdata.svg)](https://github.com/buluma/ansible-role-netdata/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-netdata.svg)](https://github.com/buluma/ansible-role-netdata/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-netdata.svg)](https://github.com/buluma/ansible-role-netdata/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/netdata)](https://galaxy.ansible.com/ui/standalone/roles/buluma/netdata/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-netdata/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  vars:
    netdata_epel_setup: "{{ ansible_facts['hostname'] == 'centos7' }}"
  tasks:
    - name: "Include buluma.netdata"
      ansible.builtin.include_role:
        name: "buluma.netdata"
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-netdata/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.git
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-netdata/blob/master/defaults/main.yml):

```yaml
---
# defaults file for netdata
# Adds installer flag to enable auto updates
# https://docs.netdata.cloud/packaging/installer/update/#auto-update
netdata_auto_updates:
  enabled: true
  day: "*"
  hour: 6
  minute: 0
  user: root
  weekday: "*"
  # WARNING: when you set this variable to 'true' and are migrating from an old version
  # of Netdata (< v1.11.0) then the cron will be removed from your system.
  # You will then need to launch the netdata installer manually to make sure
  # netdata installs the cron by itself with: `./netdata-installer.sh --auto-update`
  clean_legacy_cron: true

# The IP address and port to listen to. This is a space separated list of
# IPv4 or IPv6 address and ports. The default will bind to all IP addresses
netdata_bind_to:
  - "*"

# Defines if Netdata should be configured
netdata_config: true

# Defines location of Netdata configuration file
netdata_config_file: /etc/netdata/netdata.conf

# Defines the Git repo to pull down for installs
netdata_git_repo: "https://github.com/netdata/netdata.git"

# Defines the latest version tag to clone for installation
netdata_git_version_tag: "v2.12.2"

# Defines whether Netdata health is enabled
netdata_health_enabled: true

# Defines if Netdata health alarms should be configured
netdata_alarm_configure: false

# Defines location of Netdata health_alarm_notify.conf
netdata_alarm_config_file: /etc/netdata/health_alarm_notify.conf

# Define configuration for health_alarm_notify.conf.
# Example:
# netdata_health_alarm_notify_configs:
#   https_proxy: http://localhost:3128
#   SLACK_WEBHOOK_URL: https://hooks.slack.com/...
netdata_alarm_notify_configs: {}
# Define custom_sender function in health_alarm_notify.conf
# only the body of the function should be in there
# Exemple: netdata_custom_sender_function: "curl -X POST url"
# netdata_custom_sender_function: ""

# Defines path to alarm-notify.sh
netdata_health_alarm_script: /usr/libexec/netdata/plugins.d/alarm-notify.sh

# Defines how often a critical alarm is repeated
netdata_default_repeat_critical: never

# Defines how often a warning alarm is repeated
netdata_default_repeat_warning: never

# The host name displayed in netdata
netdata_hostname: "{{ ansible_facts['hostname'] }}"
# The number of entries the netdata daemon will by default keep in memory
# for each chart dimension.
netdata_history: 3996

# Defines Netdata installer script
netdata_installer: ./netdata-installer.sh

# Defines Netdata requirements installer script
netdata_requirements_installer: packaging/installer/install-required-packages.sh

# Defines Netdata requirements installer options (if we want morre complete requirements)
netdata_requirements_installer_options:
  - "--non-interactive"
  - netdata

# When set to save netdata will save its round robin database on exit and
# load it on startup. When set to map the cache files will be updated in
# real time (check man mmap - do not set this on systems with heavy load or
# slow disks - the disks will continuously sync the in-memory database of
# netdata). When set to ram the round robin database will be temporary and it
# will be lost when netdata exits.
netdata_memory_mode: save

# This variables are only used if netdata_memory_mode is set to dbengine
netdata_dbengine_page_cache_size: 32
netdata_dbengine_multihost_disk_space: 256

# Defines the mode the web-server will run in
# static-threaded is a web server with a fix (configured number of threads)
# single-threaded is a simple web server running with a single thread
# multi-threaded is a web server that spawns a thread for each client connection
# none will disable the web-server and the API
netdata_web_mode: multi-threaded

# The default port to listen for web clients.
netdata_default_port: 19999

netdata_epel_setup: false
netdata_epel_repo_url: "https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ ansible_facts['distribution_major_version'] }}.noarch.rpm"
netdata_epel_repo_gpg_key_url: "https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-{{ ansible_facts['distribution_major_version'] }}"
netdata_epel_repofile_path: "/etc/yum.repos.d/epel.repo"
netdata_centos6_install_okay: false

# Defines if Netdata host should be enabled as a registry
# https://github.com/firehol/netdata/wiki/mynetdata-menu-item
netdata_registry_enabled: false

# https://registry.my-netdata.io
# https://github.com/firehol/netdata/wiki/mynetdata-menu-item
netdata_registry_to_announce: "https://registry.my-netdata.io"

# Defines directory to store install source from Git repo
netdata_source_dir: /usr/local/src/netdata

# Defines if Netdata streaming should be configured
# https://github.com/firehol/netdata/wiki/Monitoring-ephemeral-nodes
netdata_stream_enabled: false

# Defines location of Netdata stream configuration file
netdata_stream_config_file: /etc/netdata/stream.conf

# Defines Netdata API Keys (must be generated with command uuidgen)
netdata_stream_api_key: 11111111-2222-3333-4444-555555555555
netdata_stream_send_api_key: "{{ netdata_stream_api_key }}"
netdata_stream_receive_api_key: "{{ netdata_stream_api_key }}"

# Defines Netdata master node and port (e.g. 127.0.0.1:19999)
netdata_stream_master_node: ""

# Defines whether the netdata node is acting as a proxy
netdata_stream_proxy: false

# Defines client ssl configuration
# netdata_client_ssl_options:
#   ssl skip certificate verification: "true"
#   CAfile: /etc/ssl/certs/ca-certificates.crt
netdata_client_ssl_options: {}
# Defines if Netdata should be uninstalled
# Caution: This does not prompt for uninstall as the original script
# was intended.
# https://github.com/firehol/netdata/wiki/Installation#uninstalling-netdata
netdata_uninstall: false

# Defines the Netdata uninstaller script
netdata_uninstaller: ./netdata-uninstaller.sh

# Defines if Netdata should be updated
# Not the same as auto_updates
netdata_update: false
# Force the update. Sometimes the update script skips installing new plugins.
netdata_update_force: false

# The frequency in seconds, for data collection
netdata_update_every: 1

# Defines Netdata update script
netdata_updater: ./netdata-updater.sh

# Defines Netdata user info
netdata_user_info:
  group: netdata
  user: netdata

# Defines if Netdata should store data in a backend
netdata_configure_archive: false

# Defines Netdata backend for long term datastorage
# https://github.com/firehol/netdata/wiki/netdata-backends
# Defines if the Netdata backend is enabled
netdata_archive_enabled: "true"

# Defines the backend type as one of
# graphite | opentsdb | json
netdata_archive_type: "opentsdb"

# Defines the host(s) and ports netdata should send data to
netdata_archive_destination:
  - localhost
  # - "{{ vip }}:5252"

# Defines how to send the archive data as one of
# as collected, average, sum
netdata_archive_data_source: "average"

# Defines a prefix for the archive data
netdata_archive_prefix: "netdata"

# Defines how often to send archive data in seconds
netdata_archive_update: 1

# Defines the number of update intervals
# after which dataloss occurs
netdata_archive_buffer_on_failures: 30

# Defines when to timeout sending to a backend in milliseconds
netdata_archive_timeout: 20000

# Defines if Netdata sends metric names or UUIDs
netdata_archive_send_names: true

# Defines the flood protection period
netdata_errors_flood_protection_period: 1200

# Defines when to trigger flood proctection
netdata_errors_to_trigger_flood_protection: 200
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-netdata/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.git](https://galaxy.ansible.com/buluma/git)|[![Build Status GitHub](https://github.com/buluma/ansible-role-git/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-git/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-netdata/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|[EL](https://hub.docker.com/r/buluma/docker-molecule-images)|10, 9|
|[Debian](https://hub.docker.com/r/buluma/docker-molecule-images)|bookworm, trixie|
|[Ubuntu](https://hub.docker.com/r/buluma/docker-molecule-images)|24.04, 22.04|

The minimum version of Ansible required is 2.12, tests have been done on:

- The previous version.
- The current version.
- The development version.

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-netdata/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-netdata/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
