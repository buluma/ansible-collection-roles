# [Ansible role service](#ansible-role-service)

Add custom services to your Linux system.

|GitHub|Issues|Pull Requests|Version|Downloads|
|------|------|-------------|-------|---------|
|[![github](https://github.com/buluma/ansible-role-service/actions/workflows/molecule.yml/badge.svg)](https://github.com/buluma/ansible-role-service/actions/workflows/molecule.yml)|[![Issues](https://img.shields.io/github/issues/buluma/ansible-role-service.svg)](https://github.com/buluma/ansible-role-service/issues/)|[![PullRequests](https://img.shields.io/github/issues-pr-closed-raw/buluma/ansible-role-service.svg)](https://github.com/buluma/ansible-role-service/pulls/)|[![Version](https://img.shields.io/github/release/buluma/ansible-role-service.svg)](https://github.com/buluma/ansible-role-service/releases/)|[![Ansible Role](https://img.shields.io/ansible/role/d/buluma/service)](https://galaxy.ansible.com/ui/standalone/roles/buluma/service/documentation)|

## [Example Playbook](#example-playbook)

This example is taken from [`molecule/default/converge.yml`](https://github.com/buluma/ansible-role-service/blob/master/molecule/default/converge.yml) and is tested on each push, pull request and release.

```yaml
---
- name: Converge
  hosts: all
  become: true
  gather_facts: true

  vars:
    _service_test_command:
      default: /usr/bin/sleep
      Alpine: /bin/sleep
      Debian: /bin/sleep
      Ubuntu-16: /bin/sleep
      Ubuntu-18: /bin/sleep
    service_test_command:
      "{{ _service_test_command[ansible_facts['distribution'] ~ '-' ~ ansible_facts['distribution_major_version']]
      | default(_service_test_command[ansible_facts['os_family']] | default(_service_test_command['default']))
      }}" # noqa 204 Just long.

  roles:
    - role: buluma.service
      service_list:
        - name: simple-service
          description: Simple Service
          start_command: "{{ service_test_command }} 3600"
          state: started
          enabled: true
        - name: stopped-service
          description: Simple Service
          start_command: "{{ service_test_command }} 3601"
          state: stopped
          enabled: false
        - name: specific-stop-service
          description: Specific Stop Service
          start_command: "{{ service_test_command }} 1440"
          stop_command: /usr/bin/killall -f "sleep 1440"
        - name: specific-user-group-service
          description: Specific User Group Service
          start_command: "{{ service_test_command }} 28800"
          user_name: root
          group_name: root
        - name: specific-workingdirectory-service
          description: Specific WorkingDirectory Service
          start_command: "{{ service_test_command }} 57600"
          working_directory: /tmp
        - name: specific-pattern-service
          description: Specific Status Pattern Service
          start_command: "{{ service_test_command }} 115200"
          status_pattern: 115200
        - name: variable-service
          description: Service with environment variables
          start_command: "{{ service_test_command }} ${time}"
          environment_variables:
            time: 230400
        - name: pidfile-service
          description: Service with pidfile
          start_command: "{{ service_test_command }} 460800"
          pidfile: /var/run/pidfile-service.pid
        - name: environmentfile-service
          description: Service with environmentfile
          start_command: "{{ service_test_command }} 921600"
          environmentfile: /environmentfile.txt
```

The machine needs to be prepared. In CI this is done using [`molecule/default/prepare.yml`](https://github.com/buluma/ansible-role-service/blob/master/molecule/default/prepare.yml):

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
```

Also see a [full explanation and example](https://buluma.github.io/how-to-use-these-roles.html) on how to use these roles.

## [Role Variables](#role-variables)

The default values for the variables are set in [`defaults/main.yml`](https://github.com/buluma/ansible-role-service/blob/master/defaults/main.yml):

```yaml
---
# defaults file for service

# service_list can contain a list of services to add to the system.
# The mandatory items for each item are:
# - name: The (short) name of the service, i.e. "tomcat".
# - description: A bit longer name, i.e. "Tomcat application server".
# - start_command: The command to start the daemon,
#   i.e. "/usr/local/bin/java -jar some.jar"
# The optional items are:
# - stop_command: By default the program that is started is found and stopped.
#   in case a running program is renamed or expanded (including a path) during
#   startup, you can specify a custom stop command here, i.e. "pkill foo"
# - status_pattern: What program (or pattern) to look for when finding the
#   status of a program, i.e. "artifactory".
# - type: How the program starts; "simple" or "forking". Simple means the
#   program runs on the foreground, i.e. "nc -l 1234". Forking means the
#   program itself forks, i.e. "nc -l 12345 &"
# - working_directory: The directory to cd into before starting the service.
# - environment_variables: A list for variables to set. for example:
#   environment_variables:
#     variable1: value1
#     variable2: value2
# - after: Start after the mentioned service.
# - restart_mode: The mode to use, for example "always".
# - restart_seconds: The time to allow restart to finish.
service_list: []
```

## [Requirements](#requirements)

- pip packages listed in [requirements.txt](https://github.com/buluma/ansible-role-service/blob/master/requirements.txt).

## [State of used roles](#state-of-used-roles)

The following roles are used to prepare a system. You can prepare your system in another way.

| Requirement | GitHub |
|-------------|--------|
|[buluma.bootstrap](https://galaxy.ansible.com/buluma/bootstrap)|[![Build Status GitHub](https://github.com/buluma/ansible-role-bootstrap/workflows/Ansible%20Molecule/badge.svg)](https://github.com/buluma/ansible-role-bootstrap/actions)|

## [Context](#context)

This role is part of many compatible roles. Have a look at [the documentation of these roles](https://buluma.github.io/) for further information.

Here is an overview of related roles:

![dependencies](https://raw.githubusercontent.com/buluma/ansible-role-service/png/requirements.png "Dependencies")

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

If you find issues, please register them on [GitHub](https://github.com/buluma/ansible-role-service/issues).

## [License](#license)

[Apache-2.0](https://github.com/buluma/ansible-role-service/blob/master/LICENSE).

## [Author Information](#author-information)

[buluma](https://buluma.github.io/)
