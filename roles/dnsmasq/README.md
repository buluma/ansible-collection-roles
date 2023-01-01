# [dnsmasq](#dnsmasq)

Set up dnsmasq in Debian-like systems.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-dnsmasq/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-dnsmasq/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-dnsmasq/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-dnsmasq)|[![quality](https://img.shields.io/ansible/quality/59135)](https://galaxy.ansible.com/buluma/dnsmasq)|[![downloads](https://img.shields.io/ansible/role/d/59135)](https://galaxy.ansible.com/buluma/dnsmasq)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-dnsmasq.svg)](https://github.com/buluma/ansible-role-dnsmasq/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-dnsmasq.svg)](https://github.com/buluma/ansible-role-dnsmasq/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-dnsmasq.svg)](https://github.com/buluma/ansible-role-dnsmasq/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: yes
  gather_facts: yes
  pre_tasks:
    - name: include vars
      # TODO: move to vars
      include_vars: "{{ playbook_dir }}/../../tests/vars/main.yml"

  roles:
    - role: buluma.dnsmasq
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes

  roles:
    - role: buluma.bootstrap
    - role: buluma.sysctl
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
# defaults file
---
dnsmasq_service_state: "{{ service_default_state | default('started') }}"
dnsmasq_service_enabled: "{{ service_default_enabled | default(true) }}"

dnsmasq_service_resolved_disabled: false

dnsmasq_etc_default_config_dir: '/etc/dnsmasq.d,.dpkg-dist,.dpkg-old,.dpkg-new'

# TODO: Clean this up (some day)
dnsmasq_etc_default:
  - |
    # This file has five functions:
    # 1) to completely disable starting dnsmasq,
    # 2) to set DOMAIN_SUFFIX by running `dnsdomainname`
    # 3) to select an alternative config file
    #    by setting DNSMASQ_OPTS to --conf-file=<file>
    # 4) to tell dnsmasq to read the files in /etc/dnsmasq.d for
    #    more configuration variables.
    # 5) to stop the resolvconf package from controlling dnsmasq's
    #    idea of which upstream nameservers to use.

    # NB. If systemd is installed and starting dnsmasq, this file is IGNORED.

    # For upgraders from very old versions, all the shell variables set
    # here in previous versions are still honored by the init script
    # so if you just keep your old version of this file nothing will break.

    {% if dnsmasq_etc_default_domain_suffix is defined %}
    DOMAIN_SUFFIX=`{{ dnsmasq_etc_default_domain_suffix }}`
    {% else %}
    #DOMAIN_SUFFIX=`dnsdomainname`
    {% endif %}
    {% if dnsmasq_etc_default_dnsmasq_opts is defined %}
    DNSMASQ_OPTS="{{ dnsmasq_etc_default_dnsmasq_opts }}"
    {% else %}
    #DNSMASQ_OPTS="--conf-file=/etc/dnsmasq.alt"
    {% endif %}

    # Whether or not to run the dnsmasq daemon; set to 0 to disable.
    ENABLED={{ dnsmasq_service_enabled | bool | ternary(1, 0) }}

    # By default search this drop directory for configuration options.
    # Libvirt leaves a file here to make the system dnsmasq play nice.
    # Comment out this line if you don't want this. The dpkg-* are file
    # endings which cause dnsmasq to skip that file. This avoids pulling
    # in backups made by dpkg.
    {% if dnsmasq_etc_default_config_dir %}
    CONFIG_DIR={{ dnsmasq_etc_default_config_dir }}
    {% else %}
    #CONFIG_DIR=/etc/dnsmasq.d,.dpkg-dist,.dpkg-old,.dpkg-new
    {% endif %}


    # If the resolvconf package is installed, dnsmasq will use its output
    # rather than the contents of /etc/resolv.conf to find upstream
    # nameservers. Uncommenting this line inhibits this behaviour.
    # Not that including a "resolv-file=<filename>" line in
    # /etc/dnsmasq.conf is not enough to override resolvconf if it is
    # installed: the line below must be uncommented.
    {% if dnsmasq_etc_default_ignore_resolvconf is defined %}
    IGNORE_RESOLVCONF={{ dnsmasq_etc_default_ignore_resolvconf | bool | ternary('yes', 'no') }}
    {% else %}
    #IGNORE_RESOLVCONF=yes
    {% endif %}

    {% for line in dnsmasq_etc_default_options | default([]) %}
    {{ line }}
    {% endfor %}

dnsmasq_dnsmasq_conf: []
dnsmasq_dnsmasq_d_files_present: {}
dnsmasq_dnsmasq_d_files_absent: {}
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-dnsmasq/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.sysctl](https://galaxy.ansible.com/buluma/sysctl)|[![Build Status GitHub](https://github.com/buluma/ansible-role-sysctl/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-sysctl/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-sysctl/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-sysctl)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-dnsmasq/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|ubuntu|all|
|debian|all|

The minimum version of Ansible required is 2.10, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-dnsmasq/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-dnsmasq/blob/master/CHANGELOG.md)

## [License](#license)

Apache-2.0

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
