Ansible Gogs Role
=================

An ansible role for installing and configuring Gogs.

This role only installs Gogs ( and git as a dependency ). You will need to use a separate role to install and
configure the database backend (sqlite3, MySQL, PostgreSQL) and reverse proxy frontend of your choice.

For more information on Gogs, [visit the Gogs.io website](http://www.gogs.io)

Role Variables
--------------

```yaml
gogs_dependency_pkgs: list of dependency packages needed for Gogs and the installation
gogs_user: user to run gogs
gogs_user_home: home directory for the gogs user / installation
gogs_binary_url: URL to a binary package of gogs
gogs_version: zip-file containing the gogs binary
gogs_config: a dictionary holding you configuration parameters
```

View the default vars - defaults/main.yml - for a more detailed example.

Example Playbook
-------------------------

```yaml
- hosts: servers
  roles:
     - { role: MichaelRigart.gogs, become: true }
```

License
-------

GPLv3

Author Information
------------------

Michaël Rigart <michael@netronix.be>
