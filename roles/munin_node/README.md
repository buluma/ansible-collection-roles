# [munin_node](#munin_node)

Munin node monitoring endpoint for RedHat/CentOS or Debian/Ubuntu.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-munin_node/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-munin_node/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-munin_node/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-munin_node)|[![quality](https://img.shields.io/ansible/quality/59034)](https://galaxy.ansible.com/buluma/munin_node)|[![downloads](https://img.shields.io/ansible/role/d/59034)](https://galaxy.ansible.com/buluma/munin_node)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-munin_node.svg)](https://github.com/buluma/ansible-role-munin_node/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-munin_node.svg)](https://github.com/buluma/ansible-role-munin_node/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-munin_node.svg)](https://github.com/buluma/ansible-role-munin_node/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  vars:
    munin_node_allowed_cidrs: ['10.0.0.0/8', '2001:db8::/32']
    munin_node_denied_cidrs: ['10.42.0.0/16', '2001:db8:42::/48']
    munin_node_plugins:
      - name: uptime
      - name: if_eth1
        plugin: if_

    munin_node_config: {
      "ps_test": {
        "env.regex": "bash",
        "env.name": "bash"
      }
    }

  roles:
    - role: buluma.munin_node
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Converge
  hosts: all
  become: true

  roles:
    - role: buluma.bootstrap
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
munin_node_bind_host: "*"
munin_node_bind_port: "4949"

munin_node_host_name: ''

# Munin requires IPs be added as regular expressions.
munin_node_allowed_ips:
  - '^127\.0\.0\.1$'
  - '^::1$'

munin_node_allowed_cidrs: []
munin_node_denied_cidrs: []

# Source and destination of munin plugins.
munin_plugin_src_path: /usr/share/munin/plugins/
munin_plugin_dest_path: /etc/munin/plugins/

# List of munin plugins to enable.
munin_node_plugins: []
# - name: uptime
# - name: if_eth0
#   plugin: if_
# - name: ps_test
#   plugin: ps_

# List of munin plugins to install.
munin_node_install_plugins: []
# - src: files/munin/redis_
# - remote_src: https://raw.githubusercontent.com/ohitz/phpfpm-multi-munin-plugin/master/phpfpm-multi

# Plugin configuration options (the key is the plugin heading, items within will
# be options for the plugin).
munin_node_config: {
# "ps_test": {
#   "env.regex": "bash",
#   "env.name": "bash"
# }
}
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-munin_node/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-munin_node/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.1, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-munin_node/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-munin_node/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
