# [supervisor](#supervisor)

Supervisor (process state manager) for Linux.

|GitHub|GitLab|Quality|Downloads|Version|Issues|Pull Requests|
|------|------|-------|---------|-------|------|-------------|
|[![github](https://github.com/buluma/ansible-role-supervisor/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-supervisor/actions)|[![gitlab](https://gitlab.com/buluma/ansible-role-supervisor/badges/master/pipeline.svg)](https://gitlab.com/buluma/ansible-role-supervisor)|[![quality](https://img.shields.io/ansible/quality/58987)](https://galaxy.ansible.com/buluma/supervisor)|[![downloads](https://img.shields.io/ansible/role/d/58987)](https://galaxy.ansible.com/buluma/supervisor)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-supervisor.svg)](https://github.com/buluma/ansible-role-supervisor/releases/)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-supervisor.svg)](https://github.com/buluma/ansible-role-supervisor/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-supervisor.svg)](https://github.com/buluma/ansible-role-supervisor/pulls/)|

## [Example Playbook](#example-playbook)

This example is taken from `molecule/default/converge.yml` and is tested on each push, pull request and release.
```yaml
---
- name: Converge
  hosts: all
  become: true

  environment:
    PATH: "/usr/local/bin:{{ ansible_env.PATH }}"

  vars:
    supervisor_user: root
    supervisor_password: fizzbuzz

  pre_tasks:
    - name: update apt cache (Debian).
      apt: update_cache=true cache_valid_time=600
      when: ansible_os_family == 'Debian'

    # Install curl for test purposes.
    - name: install curl for testing purposes.
      package: name=curl state=present

    # Install Apache for test purposes.
    - block:
        - name: install Apache (RedHat).
          package: name=httpd state=present
        - name: ensure Apache is not running (RedHat).
          service: name=httpd state=stopped enabled=no
      when: ansible_os_family == 'RedHat'

    - block:
        - name: install Apache (Debian).
          package: name=apache2 state=present
        - name: ensure Apache is not running (Debian).
          service: name=apache2 state=stopped enabled=no
      when: ansible_os_family == 'Debian'

    - name: create a test HTML file to load.
      ansible.builtin.copy:
        content: "<html><head><title>Test</title></head><body>Test.</body></html>"
        dest: /var/www/html/index.html
        force: false
        group: root
        owner: root
        mode: 0644

    # Add Apache to supervisor_programs.
    - name: set Apache start command (Debian).
      ansible.builtin.set_fact:
        apache_start_command: apache2ctl -DFOREGROUND
      when: ansible_os_family == 'Debian'

    - name: set Apache start command (RedHat).
      ansible.builtin.set_fact:
        apache_start_command: httpd -DFOREGROUND
      when: ansible_os_family == 'RedHat'

    - name: add Apache to supervisor_programs.
      ansible.builtin.set_fact:
        supervisor_programs:
          - name: 'apache'
            command: "{{ apache_start_command }}"
            state: present
            configuration: |
              autostart=true
              autorestart=true
              startretries=1
              startsecs=1
              redirect_stderr=true
              stderr_logfile=/var/log/apache-err.log
              stdout_logfile=/var/log/apache-out.log
              user=root
              killasgroup=true
              stopasgroup=true

  roles:
    - role: buluma.supervisor

  tasks:
    - name: trigger handlers so supervisor runs everything it should run.
      meta: flush_handlers

  post_tasks:
    - name: wait for Apache to come up (if it's going to do so...).
      ansible.builtin.wait_for:
        port: 80
        delay: 2

    - name: verify Apache is responding on port 80.
      ansible.builtin.uri:
        url: http://127.0.0.1/
        method: GET
        status_code: 200

    - name: verify supervisorctl is available.
      command: supervisorctl --help
      args:
        warn: false
      changed_when: false

    - name: validate supervisorctl works through the default UNIX socket.
      community.general.supervisorctl:
        name: apache
        state: restarted
        username: "{{ supervisor_user }}"
        password: "{{ supervisor_password }}"
      changed_when: false

    - name: validate supervisorctl works with unix socket
      command: supervisorctl status
      args:
        warn: false
      changed_when: false
```

The machine needs to be prepared. In CI this is done using `molecule/default/prepare.yml`:
```yaml
---
- name: Prepare
  hosts: all
  gather_facts: no
  become: yes
  serial: 30%

  roles:
    - role: buluma.bootstrap
    - role: buluma.pip
    - role: buluma.core_dependencies
```


## [Role Variables](#role-variables)

The default values for the variables are set in `defaults/main.yml`:
```yaml
---
# Install a specific version of Supervisor by setting it here (e.g. '3.3.1').
supervisor_version: ''

# Choose whether to use an init script or systemd unit configuration to start
# Supervisor when it's installed and/or after a system boot.
supervisor_started: true
supervisor_enabled: true

supervisor_config_path: /etc/supervisor

# A list of `program`s Supervisor will control. Example commented out below.
supervisor_programs: []
# - name: 'apache'
#   command: apache2ctl -c "ErrorLog /dev/stdout" -DFOREGROUND
#   state: present
#   configuration: |
#     autostart=true
#     autorestart=true
#     startretries=1
#     startsecs=1
#     redirect_stderr=true
#     stderr_logfile=/var/log/apache-err.log
#     stdout_logfile=/var/log/apache-out.log
#     user=root
#     killasgroup=true
#     stopasgroup=true

supervisor_nodaemon: false

supervisor_log_dir: /var/log/supervisor

supervisor_user: root
supervisor_password: 'my_secret_password'

supervisor_unix_http_server_enable: true
supervisor_unix_http_server_socket_path: /var/run/supervisor.sock
supervisor_unix_http_server_password_protect: true

supervisor_inet_http_server_enable: false
supervisor_inet_http_server_port: '*:9001'
supervisor_inet_http_server_password_protect: true
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-supervisor/blob/main/requirements.txt).

## [Status of used roles](#status-of-requirements)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub | GitLab |
|-------------|--------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-bootstrap/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-bootstrap)|
|[buluma.pip](https://galaxy.ansible.com/buluma/pip)|[![Build Status GitHub](https://github.com/buluma/ansible-role-pip/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-pip/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-pip/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-pip)|
|[buluma.core_dependencies](https://galaxy.ansible.com/buluma/core_dependencies)|[![Build Status GitHub](https://github.com/buluma/ansible-role-core_dependencies/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-core_dependencies/actions)|[![Build Status GitLab ](https://gitlab.com/buluma/ansible-role-core_dependencies/badges/main/pipeline.svg)](https://gitlab.com/buluma/ansible-role-core_dependencies)|

## [Context](#context)

This role is a part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-supervisor/png/requirements.png "Dependencies")

## [Compatibility](#compatibility)

This role has been tested on these [container images](https://hub.docker.com/u/buluma):

|container|tags|
|---------|----|
|el|8|
|debian|all|
|ubuntu|all|

The minimum version of Ansible required is 2.4, tests have been done to:

- The previous version.
- The current version.
- The development version.



If you find issues, please register them in [GitHub](https://github.com/buluma/ansible-role-supervisor/issues)

## [Changelog](#changelog)

[Role History](https://github.com/buluma/ansible-role-supervisor/blob/master/CHANGELOG.md)

## [License](#license)

license (Apache-2.0)

## [Author Information](#author-information)

[Michael Buluma](https://buluma.github.io/)
