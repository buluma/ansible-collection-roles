# [Ansible role collectd](#ansible-role-collectd)

Install and configure collectd on your system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-collectd/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-collectd/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/collectd)](https://galaxy.ansible.com/ui/standalone/roles/buluma/collectd/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-collectd/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  vars:
    collectd_plugin_logging: logfile
    collectd_basic_plugins:
      - cpu
      - interface
      - load
      - memory
    collectd_plugins:
      - name: network
        config: |
          Server 127.0.0.0 25826
      - name: df
        config: |
          MountPoint "/proc"
          MountPoint "/dev"
          MountPoint "/\/docker\/containers\//"
          MountPoint "/\/docker\/devicemapper\//"
          MountPoint "/\/docker\/plugins\//"
          MountPoint "/\/docker\/overlay\//"
          MountPoint "/\/docker\/overlay2\//"
          MountPoint "/\/docker\/netns\//"
          FSType "overlay"
          FSType "proc"
          FSType "tmpfs"
          IgnoreSelected true
          ReportInodes true
      - name: disk
        config: |
          Disk "/^hd"
          IgnoreSelected true
      - name: interface
        config: |
          Interface "lo"
          Interface "/veth.*/"
          IgnoreSelected true
      - name: swap
        config: |
          ReportByDevice false
          ReportBytes true
      - name: write_http
        config: |
          <Node "test">
            URL "127.0.0.1:8080/test.collectd"
            Format "JSON"
            StoreRates true
          </Node>
      - name: postgresql
        config: |
          <Query tickets>
            Statement "SELECT count(t.id) AS count FROM tickets t WHERE t.closed is null;"
            <Result>
              Type gauge
              InstancePrefix "tickets"
              ValuesFrom "count"
            </Result>
          </Query>
          <Database "test">
            Host "psql-database.hostname.com"
            Port "5432"
            User "my_psqladminuser"
            Password "my_passwd"
            SSLMode "prefer"
            Query tickets
          </Database>
  pre_tasks:
    - name: Update apt cache.
      ansible.builtin.apt:
        update_cache: true
        cache_valid_time: 600
      when: ansible_facts['os_family'] == 'Debian'
  roles:
    - role: buluma.collectd
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-collectd/blob/master/molecule/default/prepare.yml):

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
    - role: buluma.epel
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-collectd/blob/master/defaults/main.yml):

```yaml
---
# defaults file for collectd

collectd_conf_hostname: "{{ ansible_facts['hostname'] }}"
collectd_conf_fqdnlookup: "false"
collectd_conf_basedir: /var/lib/collectd
collectd_conf_pidfile: /var/run/collectd.pid
collectd_conf_typesdb: /usr/share/collectd/types.db

collectd_conf_autoloadplugin: "false"
collectd_conf_collectinternalstats: "false"

collectd_conf_interval: 10
collectd_conf_maxreadinterval: 86400
collectd_conf_timeout: 2
collectd_conf_readthreads: 5
collectd_conf_writethreads: 5

collectd_conf_include_dir: /etc/collectd.d
collectd_conf_fnmatch_filters:
  - "*.conf"

collectd_conf_extra:
# ### Logging Configuration

collectd_plugin_logging: syslog

collectd_plugin_logging_directory: "/var/log/collectd"

collectd_plugin_logfile_loglevel: "info"
collectd_plugin_logfile_file: "{{ collectd_plugin_logging_directory }}/collectd.log"
collectd_plugin_logfile_timestamp: "true"
collectd_plugin_logfile_printseverity: "false"

collectd_plugin_logstash_loglevel: "info"
collectd_plugin_logstash_file: "{{ collectd_plugin_logging_directory }}/collectd.json.log"

collectd_plugin_syslog_loglevel: "info"
# collectd_plugin_syslog_notifylevel: ""

# Use 'collectd_basic_plugins' to enable plugins not requiring additional
# configuration.
collectd_basic_plugins:
  - cpu
  - interface
  - load
  - memory
  # - aggregation
  # - amqp
  # - apache
  # - apcups
  # - apple_sensors
  # - aquaero
  # - ascent
  # - barometer
  # - battery
  # - bind
  # - ceph
  # - cgroups
  # - chrony
  # - conntrack
  # - contextswitch
  # - cpu
  # - cpufreq
  # - cpusleep
  # - csv
  # - curl
  # - curl_json
  # - curl_xml
  # - dbi
  # - df
  # - disk
  # - dns
  # - dpdkevents
  # - dpdkstat
  # - drbd
  # - email
  # - entropy
  # - ethstat
  # - exec
  # - fhcount
  # - filecount
  # - fscache
  # - gmond
  # - gps
  # - grpc
  # - hddtemp
  # - hugepages
  # - intel_pmu
  # - intel_rdt
  # - interface
  # - ipc
  # - ipmi
  # - iptables
  # - ipvs
  # - irq
  # - java
  # - load
  # - lpar
  # - lua
  # - lvm
  # - madwifi
  # - mbmon
  # - mcelog
  # - md
  # - memcachec
  # - memcached
  # - memory
  # - mic
  # - modbus
  # - mqtt
  # - multimeter
  # - mysql
  # - netapp
  # - netlink
  # - network
  # - nfs
  # - nginx
  # - notify_desktop
  # - notify_email
  # - notify_nagios
  # - ntpd
  # - numa
  # - nut
  # - olsrd
  # - onewire
  # - openldap
  # - openvpn
  # - oracle
  # - ovs_events
  # - ovs_stats
  # - perl
  # - pinba
  # - ping
  # - postgresql
  # - powerdns
  # - processes
  # - protocols
  # - python
  # - redis
  # - routeros
  # - rrdcached
  # - rrdtool
  # - sensors
  # - serial
  # - sigrok
  # - smart
  # - snmp
  # - snmp_agent
  # - statsd
  # - swap
  # - table
  # - tail
  # - tail_csv
  # - tape
  # - tcpconns
  # - teamspeak2
  # - ted
  # - thermal
  # - tokyotyrant
  # - turbostat
  # - unixsock
  # - uptime
  # - users
  # - uuid
  # - varnish
  # - virt
  # - vmem
  # - vserver
  # - wireless
  # - write_graphite
  # - write_http
  # - write_kafka
  # - write_log
  # - write_mongodb
  # - write_prometheus
  # - write_redis
  # - write_riemann
  # - write_sensu
  # - write_tsdb
  # - xencpu
  # - xmms
  # - zfs_arc
  # - zone
  # - zookeeper

# Use 'collectd_plugins' to enable plugins requiring additional configuration.
collectd_plugins: []
# examples:
#  - name: example
#    interval: 120 #seconds
#    flush_interval: 600 #seconds
#    flush_timeout:
#    config: |4
#      Something: true
#      <Nested block>
#        NestedKey: "value"
#      </Nested>
#  - name: write_http
#    config: |4
#      <Node "oms">
#         URL "127.0.0.1:26000/oms.collectd"
#         Format "JSON"
#         StoreRates true
#      </Node>
#  - name: postgresql
#    config: |4
#      <Query tickets>
#          Statement "SELECT count(t.id) AS count FROM tickets t WHERE t.closed is null;"
#          <Result>
#            Type gauge
#            InstancePrefix "tickets"
#            ValuesFrom "count"
#          </Result>
#      </Query>
#      <Database "test">
#        Host "psql-database.hostname.com"
#        Port "5432"
#        User "my_psqladminuser"
#        Password "my_passwd"
#        SSLMode "prefer"
#        Query tickets
#      </Database>
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-collectd/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-collectd/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-collectd/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-collectd/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
