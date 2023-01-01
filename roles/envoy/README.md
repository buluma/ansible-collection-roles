# [envoy](#envoy)

Install and configure Envoy on your linux system.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-envoy/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-envoy/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-envoy/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-envoy)|[![quality](https://img.shields.io/ansible/quality/60893)](https://galaxy.ansible.com/buluma/envoy)|[![downloads](https://img.shields.io/ansible/role/d/60893)](https://galaxy.ansible.com/buluma/envoy)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-envoy.svg)](https://github.com/buluma/ansible-role-envoy/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-envoy.svg)](https://github.com/buluma/ansible-role-envoy/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-envoy.svg)](https://github.com/buluma/ansible-role-envoy/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true
  vars:
    envoy_version: "1.24.0"
    envoy_arch: "linux-arm64"
    envoy_checksum: "sha256:2673a763aee8e60e466b67e54b8323f0f53d5ea8e4ac5d9186f41b0387a303ba"
    envoy_systemd: true
    envoy_config:
      admin:
        address:
          socket_address: {address: 127.0.0.1, port_value: 9901}
      static_resources:
        listeners:
          - name: listener_0
            address:
              socket_address: {address: 127.0.0.1, port_value: 10000}
        filter_chains:
          - filters:
              - name: envoy.filters.network.http_connection_manager
                typed_config:
                  "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
                stat_prefix: ingress_http
                codec_type: AUTO
                route_config:
                  name: local_route
                virtual_hosts:
                  - name: local_service
                    domains: ["*"]
                    routes:
                      - match: {prefix: "/"}
                        route: {cluster: some_service}
                http_filters:
                  - name: envoy.filters.http.router
                    typed_config:
                      "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
        clusters:
          - name: some_service
            connect_timeout: 0.25s
            type: STATIC
            lb_policy: ROUND_ROBIN
            load_assignment:
              cluster_name: some_service
              endpoints:
                - lb_endpoints:
                    - endpoint:
                        address:
                          socket_address:
                            address: 127.0.0.1
                            port_value: 1234

  roles:
    - role: "buluma.envoy"
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  become: true
  gather_facts: true

  tasks:
    - name: Debian | Install xz-utils
      ansible.builtin.package:
        name: "xz-utils"
        state: present
      when: ansible_os_family == "Debian"

    - name: RedHat | Install xz
      ansible.builtin.package:
        name:
          - "xz"
          - "tar"
        state: present
      when: ansible_os_family == "RedHat"
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
envoy_bin_path: "/usr/local/bin"

# Disabled if installed as sidecar servie for example consul usage
# https://learn.hashicorp.com/tutorials/consul/consul-terraform-sync-intro?in=consul/network-infrastructure-automation#install-envoy-optional
envoy_enable_conf: false
envoy_conf_path: "/etc/envoy"

envoy_user: "envoy"
envoy_group: "envoy"
# wether envoy user should be a system user or not
envoy_system_user: true

# Download
# https://archive.tetratelabs.io/envoy/envoy-versions.json
envoy_version: "1.22.2"
envoy_arch: "linux-amd64"
# optional
# clear if unused
envoy_checksum: "sha256:fbd2460189f330a6b1e6b4ff79b4604dff1847091d4abbdda2c6b3894fadb396"
envoy_download_url: "https://archive.tetratelabs.io/envoy/download/v{{ envoy_version }}/envoy-v{{ envoy_version }}-{{ envoy_arch }}.tar.xz"
envoy_download_path: "/tmp/envoy-v{{ envoy_version }}-{{ envoy_arch }}.tar.xz"
envoy_unarchive_dest: "/tmp"
envoy_unarchive_creates: "/tmp/envoy-v{{ envoy_version }}-{{ envoy_arch }}/bin/envoy"

# Create a systemd servicefile
envoy_systemd: false
envoy_systemd_enabled: true

# will be used with `to_nice_yaml`
envoy_config: []
# admin:
#   address:
#     socket_address: { address: 127.0.0.1, port_value: 9901 }
# static_resources:
#   listeners:
#   - name: listener_0
#     address:
#       socket_address: { address: 127.0.0.1, port_value: 10000 }
#     filter_chains:
#     - filters:
#       - name: envoy.filters.network.http_connection_manager
#         typed_config:
#           "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
#           stat_prefix: ingress_http
#           codec_type: AUTO
#           route_config:
#             name: local_route
#             virtual_hosts:
#             - name: local_service
#               domains: ["*"]
#               routes:
#               - match: { prefix: "/" }
#                 route: { cluster: some_service }
#           http_filters:
#           - name: envoy.filters.http.router
#             typed_config:
#               "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
#   clusters:
#   - name: some_service
#     connect_timeout: 0.25s
#     type: STATIC
#     lb_policy: ROUND_ROBIN
#     load_assignment:
#       cluster_name: some_service
#       endpoints:
#       - lb_endpoints:
#         - endpoint:
#             address:
#               socket_address:
#                 address: 127.0.0.1
#                 port_value: 1234
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-envoy/blob/main/requirements.txt).


## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-envoy/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|all|
|amazon|Candidate|
|fedora|all|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.

## [Exceptions](#exceptions)

Some roles can't run on a specific distribution or version. Here are some exceptions.

| variation                 | reason                 |
|---------------------------|------------------------|
| centos:7 | Current envoy version (1.22) not supported on CentOS 7 |

If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-envoy/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-envoy/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)

### [Special Thanks](#special-thanks)

Template inspired by [Robert de Bock](https://github.com/robertdebock)
