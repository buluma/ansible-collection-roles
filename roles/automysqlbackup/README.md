# Ansible Role: automysqlbackup

[![Build Status](https://travis-ci.com/buluma/ansible-role-automysqlbackup.svg?branch=master)](https://travis-ci.com/buluma/ansible-role-automysqlbackup)

Installs automysqlbackup on Debian/Ubuntu linux servers.

## Requirements

**`mail` must be available**

Use `apt install mailutils` or fake mail by `touch /usr/local/bin/mail`

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    # database username and password that will perform the backups
    automysqlbackup_username: "$(grep user /etc/mysql/debian.cnf | tail -n 1 | cut -d'=' -f2 | awk '{print $1}')"
    automysqlbackup_password: "$(grep password /etc/mysql/debian.cnf | tail -n 1 | cut -d'=' -f2 | awk '{print $1}')"
    
    # hostname or ip address of the database server
    automysqlbackup_host: localhost
    
    # space separated string of databases to include or ignore in the backup
    #automysqlbackup_db_ames: "all"
    automysqlbackup_db_exclude:
      - 'information_schema'
      - 'mysql'
      - 'performance_schema'
      - 'test'
    
    automysqlbackup_table_exclude: []
    
    automysqlbackup_backup_dir: /var/backup/db
    automysqlbackup_multicore: "{{ 'yes' if ansible_processor_cores > 0 else 'no' }}"
    automysqlbackup_multicore_threads: "{{ (ansible_processor_cores/2 | int) if ansible_processor_cores > 2 else 1 }}"
    automysqlbackup_multicore_threads: "{{ 1 if ansible_processor_cores <= 3 else (ansible_processor_cores/2) }}"
    
    # day of the week for weekly backbackups (6 - Saturday)
    automysqlbackup_do_monthly: '01'
    automysqlbackup_do_weekly: '5'
    automysqlbackup_rotation_daily: '6'
    automysqlbackup_rotation_weekly: '35'
    automysqlbackup_rotation_monthly: '150'
    
    automysqlbackup_mysql_dump_single_transaction: 'yes'
    automysqlbackup_mysql_dump_dbstatus: 'yes'
    automysqlbackup_mysql_dump_create_database: 'no'
    automysqlbackup_mysql_dump_use_separate_dirs: 'yes'
    automysqlbackup_mysql_dump_compression: 'gzip'
    automysqlbackup_mysql_dump_latest: 'yes'
    automysqlbackup_mysql_dump_latest_clean_filenames: 'yes'
    
    # output location (log, files, stdout, quiet) and where output is sent (user / email address)
    automysqlbackup_mailcontent: quiet
    automysqlbackup_mailaddr: root
    
    # default cron configuration
    automysqlbackup_cron_minute: 6
    automysqlbackup_cron_hour: 20
    automysqlbackup_cron_day: '*'
    automysqlbackup_cron_month: '*'
    automysqlbackup_cron_weekday: '*'
    
    # requires full access as root user on cli
    automysqlbackup_export_priviledges: true


## Dependencies

None.

## Example Playbook

    - hosts: server
      roles:
        - { role: tschifftner.automysqlbackup }

## Export priviledges

User credentials can be exported via cron. Please set ```automysqlbackup_export_priviledges``` to true and make sure
root user does not require login on cli.


## Restore database

### gzip
```
gzip -dc my_database.sql.gz | mysql -h localhost -u root -p my_database
```

### bzip2
```
bunzip2 < my_database.sql.bz2 | mysql -h localhost -u root -p my_database
```
or
```
bzip2 -d my_database.sql.bz2 | mysql -h localhost -u root -p my_database
```

## Supported OS

 - Debian 9 (Stretch)
 - Debian 8 (Jessie)
 - Ubuntu 18.04 (Bionic Beaver)
 - Ubuntu 16.04 (Xenial Xerus)
 
## Required ansible version

Ansible 2.5+

## License

[MIT License](http://choosealicense.com/licenses/mit/)

## Author Information

 - [Tobias Schifftner](https://twitter.com/tschifftner), [ambimax® GmbH](https://www.ambimax.de)
