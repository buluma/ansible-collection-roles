indigo-dc.galaxycloud
=====================

Install Galaxy Production environment.
This role has been specifically developed to be used in the INDIGO project.

Requirements
------------
This ansible role supports CentOS 7 and Ubuntu 16.04 Xenial

Minimum ansible version: 2.1.2.0

Role Variables
--------------

### Path ###

``galaxy_instance_description``: set Galaxy brand

``galaxy_user``: set linux user to launch the Galaxy portal (default: ``galaxy``).

``GALAXY_UID``: set user UID (default: ``4001``).

``galaxy_FS_path``: path to install Galaxy (default: ``/home/galaxy``).

``galaxy_directory``: Galaxy directory (usually galaxy or galaxy-dist, default ``galaxy``).

``galaxy_install_path``: Galaxy installation directory (default: ``/home/galaxy/galaxy``).

``galaxy_config_path``: Galaxy config pat location.

``galaxy_config_file``: Galaxy primary configuration file.

``galaxy_venv_path``:  Galaxy virtual environment directory (usually located to ``<galaxy_install_path>/.venv``).

``galaxy_custom_config_path``: Galaxy custom configuration files path (default: ``/etc/galaxy``).

``galaxy_custom_script_path``: Galaxy custom script path (defautl: ``/usr/local/bin``).

``galaxy_log_path``: log file directory (default: ``/var/log/galaxy``).

``galaxy_instance_url``: instance url (default:  ``http://<ipv4_address>/galaxy/``).

``galaxy_instance_key_pub``: instance ssh public key to configure <galaxy_user> access.

``galaxy_lrms``: enable  Galaxy virtual elastic cluster support. Currently supported local and slurm (default: ``local``, possible values: ``local, slurm``).

### main options ###

``GALAXY_VERSION``: set Galaxy version (e.g. ``master``, ``release_17.01``, ``release_17.05``...).

# Enable Galaxy administrator user creation.
``create_galaxy_admin``: if true the administrator user will be created (default: ``true``).

``GALAXY_ADMIN_USERNAME``: Galaxy administrator username.

``GALAXY_ADMIN_PASSWORD``: Galaxy administrator password.

``GALAXY_ADMIN_API_KEY``: Galaxy administrator API_KEY. https://wiki.galaxyproject.org/Admin/API. Please note that this key acts as an alternate means to access your account, and should be treated with the same care as your login password. To be changed by the administrator.(default value: ``GALAXY_ADMIN_API_KEY``)

``GALAXY_ADMIN_EMAIL``: Galaxy administrator e-mail address

### Galaxy configuration ###

``export_dir``: Galaxy userdata are stored here (defatult: ``/export``).

``tool_deps_path``: change tool dependency directory (default: ``{{ export_dir }}/tool_deps``)

``conda_prefix``: change conda prefix directory (default: ``{{ export_dir }}/_conda``).

``conda_channels``: change conda channels (default: ``iuc,bioconda,r,defaults,conda-forge``).

``update_ucsc: update UCSC genome database (default: ``true``). A monthly cron job is added to keep update ucsc genome db.

``fast_update``: force database update by copying cached files (default: ``true``).

``use_pbkdf2``: enable pbkdf2 cryptograpy (default: ``true``).

### Galaxy user login options ### 
``require_login``: force everyone to log in, i.e. disable anonymous access (default: ``True``).

``allow_user_creation``: allow unregistered users to create new accounts (default: ``True``).

``allow_user_impersonation``: allow administrators to log in as other users (default: ``True``).

``new_user_dataset_access_role_default_private``: by default users data will be public, but setting this to True will cause it to be private (default: ``True``).


### Postgres database details ###

``postgresql_version``: set postgres version to be installed (current default: ``9.6``).

``galaxy_db_dir``: change galaxy database directory to store jobs results  (default: ``{{export_dir}}/galaxy/database``).

``galaxy_db_port``: set postgres port (default: ``5432``).

``galaxy_db_passwd``: set database password. By default it is generated a random password 20 characters long.

``set_pgsql_random_password``: if set to ``false`` the role takes the password specified through ``galaxy_db_passwd`` variable (default: ``true``).

### NGINX ###

``nginx_upload_store_path``: set nginx upload dataset directory (default: ``{{galaxy_db_dir}}/tmp/nginx_upload_store``).

### https mode ###

The Galaxy portal runs through an `nginx` http proxy by default. The following
variables enable you to set nginx in https mode:

```
nginx_https: true
ssl_cert: /etc/certs/cert.pem
ssl_key: /etc/certs/key.pem
ssl_dhparam: /etc/certs/dhparam.pem
```

If `nginx_https` is set to `true`, the other ssl variables are required.
You can either request a signed trusted certificate or generated self-signed
certificate. An ansible role to generate self-signed certificate can be found
in https://galaxy.ansible.com/LIP-Computing/ssl-certs/

### PROFTPD ###

``proftpd_welcome``: set proftpd welcome message (default: ``galaxy ftp server``).

``proftpd_conf_path``: set proftpd configuration file path.

``proftpd_db_user``: set proftpd database user (default: ``galaxyftp``).

``proftpd_db_passwd``: set postgresql database password. By default it is generated a random password 20 characters long.

``proftpd_files_path``: set proftpd upload directory (default: ``{{galaxy_db_dir}}/ftp``).

``proftpd_ftp_port``: set proftpd port (default: ``21``).

``proftpd_passive_port_low``: set passive port range minimum (default: ``30000``).

``proftpd_passive_port_high``: set passive port reng maximum (default:``40000``).

``set_proftpd_random_password``: if set to ``false`` the role takes the password specified through ``proftpd_db_passwd`` variable (default: ``true``).

### Init system ###

Currently this role support supervisord and systemd/upstart to start Galaxy services.
``init_type``: if set to ``supervisord``, it use to manage Galaxy. If set to ``init`` systemd/upstart is used to start Galaxy.

It is possible to exploit supervisord to manage postegreSQL, NGINX and proftpd setting to ``true`` the following variables. To run this role on docker container you have to set them to ``true``.
``supervisor_manage_postgres``: enable supervisord postgresql management (default: ``false``).

``supervisor_manage_nginx``: enable supervisord nginx management (default: ``false``).

``supervisor_manage_proftpd``: enable supervisord proftpd management (default: ``false``).

### Advanced storage configuration ###

``enable_storage_advanced_options``: this option, ``false`` by the default, has to be set to ``true`` only if you run the ansible role indigo-dc.galaxycloud-os, for advanced path configuration, onedata and filesystem encryption support. More details here: :doc:`ansible_galaxycloud-os` (default: ``false``).

### Tools and Reference data ###

Inform the role if galaxy tools and reference data will be installed. If yes, galaxy is not started to configure tools and reference data.

``galaxy_flavor``: specify the galaxy flavour. (default: ``galaxy-no-tools``, i.e. galaxy without tools).

``get_refdata``: specify if reference data will be configured (default: ``false``)

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```yaml
    - hosts: servers
      roles:
         - role: indigo-dc.galaxycloud
           GALAXY_ADMIN_EMAIL: "admin@elixir-italy.org"
           GALAXY_ADMIN_USERNAME: "admin"
           GALAXY_VERSION: "release_17.05"
           galaxy_instance_key_pub: "your_public_key"
           galaxy_instance_description: "INDIGO-CNR test"
```

Install Galaxy setting postgresql passwords:

```yaml
    - hosts: servers
      roles:
         - role: indigo-dc.galaxycloud
           GALAXY_ADMIN_EMAIL: "admin@elixir-italy.org"
           GALAXY_ADMIN_USERNAME: "admin"
           GALAXY_VERSION: "release_17.05"
           galaxy_instance_key_pub: "your_public_key"
           galaxy_instance_description: "INDIGO-CNR test"
           set_pgsql_random_password: false
           galaxy_db_passwd: 'galaxy'
           set_proftpd_random_password: false
           proftpd_db_passwd: 'galaxy'
```

Setup Galaxy Docker container. The role, using ansible, automatically recognize the virtual platform (virtual machine or Docker contanier).

```yaml
    - hosts: servers
      roles:
         - role: indigo-dc.galaxycloud
           GALAXY_ADMIN_EMAIL: "admin@elixir-italy.org"
           GALAXY_ADMIN_USERNAME: "admin"
           GALAXY_VERSION: "release_17.05"
           galaxy_instance_key_pub: "your_public_key"
           galaxy_instance_description: "INDIGO-CNR test"
           supervisor_manage_postgres: "True"
           supervisor_manage_nginx: "True"
           supervisor_manage_proftpd: "True"
```

License
-------

Apache Licence v2

References
----------

Galaxy: https://galaxyproject.org/

Apache licence: http://www.apache.org/licenses/LICENSE-2.0
