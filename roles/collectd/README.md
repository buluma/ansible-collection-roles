# [collectd](#collectd)

Install and configure collectd on your system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-collectd/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-collectd/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-collectd/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-collectd)|[![quality](https://img.shields.io/ansible/quality/58008)](https://galaxy.ansible.com/buluma/collectd)|[![downloads](https://img.shields.io/ansible/role/d/58008)](https://galaxy.ansible.com/buluma/collectd)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-collectd.svg)](https://github.com/buluma/ansible-role-collectd/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: converge
  hosts: all
  become: yes
  gather_facts: yes
  vars:
    collectd_plugin_logging: logfile
    collectd_basic_plugins:
      - cpu
      - interface
      - load
      - memory
    collectd_plugins:
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

  roles:
    - role: buluma.collectd
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: prepare
  hosts: all
  become: yes
  gather_facts: no

  roles:
    - role: buluma.bootstrap
    - role: buluma.epel
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# defaults file for collectd

collectd_conf_hostname: "{{ ansible_hostname }}"
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

#### Logging Configuration

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
#      Something: yes
#      <Nested block>
#        NestedKey: "value"
#      </Nested>
#  - name: write_http
#    config: |4
#      <Node "oms">
#         URL "127.0.0.1:26000/oms.collectd"
#         Format "JSON"
#         StoreRates yes
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

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-collectd/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.epel](https://galaxy.ansible.com/buluma/epel)|[![Build Status GitHub](https://github.com/buluma/ansible-role-epel/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-epel/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-epel/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-epel)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.co.ke/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-collectd/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|alpine|all|
|amazon|Candidate|
|el|8|
|debian|bullseye|
|fedora|all|
|opensuse|all|
|ubuntu|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| centos:7 | Plugin dependency collectd-write_http is missing. |


If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-collectd/issues)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
