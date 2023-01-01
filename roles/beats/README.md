# [beats](#beats)

Deploys and configure Elastic beats

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-beats/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-beats/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-beats/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-beats)|[![quality](https://img.shields.io/ansible/quality/)](https://galaxy.ansible.com/buluma/beats)|[![downloads](https://img.shields.io/ansible/role/d/)](https://galaxy.ansible.com/buluma/beats)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-beats.svg)](https://github.com/buluma/ansible-role-beats/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-beats.svg)](https://github.com/buluma/ansible-role-beats/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-beats.svg)](https://github.com/buluma/ansible-role-beats/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    adminer_add_apache_config: true

  pre_tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=600
      when: ansible_os_family == 'Debian'
      changed_when: false

  roles:
    # - role: buluma.bootstrap
    # - role: buluma.apache
    - role: buluma.beats
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
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---

#### PACKAGING #################################################################

# The libbeat packages to install.
# Options: www.elastic.co/guide/en/beats/libbeat/master/installing-beats.html
beats_client_beats_packages:
  - filebeat
  - metricbeat

# Identifier for host sending logs. Sane default as hostname.
beats_client_shipper_name: "{{ ansible_hostname }}"

beats_client_version: 6.1.2
# The apt repo URL pegs minor versions (e.g. 5.x) to avoid unexpected upgrades
beats_client_major_version_abbreviated: 6.x

beats_client_beats_prereq:
  - apt-transport-https

# Elastic's PGP key for signing their repository
beats_client_elastic_pgp_key: "46095ACC8548582C1A2699A9D27D666CD88E42B4"
beats_client_elastic_gpg_key_url: "https://artifacts.elastic.co/GPG-KEY-elasticsearch"

# Elastic's beats debian repository
beats_client_elastic_repo_url: "deb https://artifacts.elastic.co/packages/{{ beats_client_major_version_abbreviated }}/apt stable main"

# Whether to inject templates (should really only be run on the same system that
# has direct elasticsearch access
beats_client_inject_templates: no

#### FILEBEAT ##################################################################


# Sane default of localhost. Override to set to the IP address/DNS of the Logstash server.
beats_client_logserver: "127.0.0.1"
beats_client_port: 5000

# Controls how often Topbeat reports stats (in seconds)
beats_client_topbeat_period: 10

beats_client_logfiles:
  - paths:
      - /var/log/syslog
      - /var/log/auth.log
    tags: ['syslog']

  - paths:
      - /var/log/dpkg.log
    tags: ['dpkg']

  - paths:
      - /var/log/apache2/*log
    tags: ['apache']

  - paths:
      - /var/log/mail.info
      - /var/log/mail.warn
      - /var/log/mail.err
    tags: ['postfix']

# To send additional logfiles, override the following list.
# See
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html#_literal_tags_literal
beats_client_extra_logfiles: []

beats_client_filebeat_combined_logfiles: "{{ beats_client_logfiles + beats_client_extra_logfiles }}"

beats_client_filebeat_logging:
  level: warning
  to_files: true
  to_syslog: false
  files:
    path: /var/log/
    name: filebeat.log
    keepfiles: 2

beats_client_filebeat_config:
  filebeat.inputs: "{{ beats_client_filebeat_combined_logfiles }}"
  output: "{{ beats_client_output }}"
  logging: "{{ beats_client_filebeat_logging }}"
  setup: "{{ beats_client_filebeat_setup }}"
  # https://www.elastic.co/guide/en/beats/filebeat/master/configuration-general-options.html#_literal_name_literal
  name: "{{ beats_client_shipper_name }}"

#### METRICBEAT ##################################################################
# See: www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-configuration-options.html

# See: www.elastic.co/guide/en/beats/metricbeat/master/metricbeat-modules.html
beats_client_metricbeat_modules:
  - module: system
    metricsets:
      - cpu
      - load
      - diskio
      - filesystem
      - fsstat
      - memory
      - network
      - process
      - socket
    enabled: true
    period: "{{ beats_client_topbeat_period }}s"
    processes: ['.*']

beats_client_metricbeat_logging:
  level: warning
  to_files: true
  to_syslog: false
  files:
    path: /var/log/
    name: metricbeat.log
    keepfiles: 2

beats_client_metricbeat_config:
  metricbeat.modules: "{{ beats_client_metricbeat_modules }}"
  output: "{{ beats_client_output }}"
  logging: "{{ beats_client_metricbeat_logging }}"
  setup: "{{ beats_client_metricbeat_setup }}"
  # https://www.elastic.co/guide/en/beats/filebeat/master/configuration-general-options.html#_literal_name_literal
  name: "{{ beats_client_shipper_name }}"

#### PACKETBEAT ##################################################################
# See: www.elastic.co/guide/en/beats/packetbeat/master/configuring-packetbeat.html
beats_client_packetbeat_config: {}

#### HEARTBEAT ##################################################################
beats_client_heartbeat_config: {}

#### KIBANA ##################################################################

# Section more for testing at this point. Previously for <=5.x this role was
# assisting with dashboard import. Now that the feature is integrated into the
# 6.x+ clients and is not backwards compat. - decided to just rip out the old
# functionality.

# Here how it might look now
#    beats_client_filebeat_setup:
#      dashboards:
#        enabled: true
#        index: "{{ beats_client_kibana_indices['filebeat'] }}"
#    beats_client_metricbeat_setup:
#      dashboards:
#        enabled: true
#        index: "{{ beats_client_kibana_indices['metricbeat'] }}"

beats_client_kibana_url_base: http://localhost:9200
beats_client_kibana_url: "{{ beats_client_kibana_url_base }}/.kibana"
beats_client_kibana_indices:
  metricbeat: metrics-logstash-*
  filebeat: syslog-*
beats_client_kibana_dash_search:
  metricbeat: Metricbeat*
  filebeat: Filebeat*

#### SHARED ##################################################################

# Note that SSL is disabled here by default, you'll need to override this
# variable using attributes from
# www.elastic.co/guide/en/beats/metricbeat/master/logstash-output.html
beats_client_output:
  logstash:
    enabled: true
    hosts:
      - "{{ beats_client_logserver }}:{{ beats_client_port }}"

# Added in 6.x series for among other things,
# dashboard setup
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-dashboards.html
beats_client_filebeat_setup: {}
beats_client_metricbeat_setup: {}

# Master config dictionary variable.
beats_clients_configs:
  filebeat: "{{ beats_client_filebeat_config }}"
  metricbeat: "{{ beats_client_metricbeat_config }}"
  packetbeat: "{{ beats_client_packetbeat_config }}"
  heartbeat: "{{ beats_client_heartbeat_config }}"
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-beats/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.apache](https://galaxy.ansible.com/buluma/apache)|[![Build Status GitHub](https://github.com/buluma/ansible-role-apache/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-apache/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-apache/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-apache)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-beats/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|debian|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-beats/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-beats/blob/master/CHANGELOG.md)

## [License](#license)

MIT

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
