#!/usr/bin/env bash
#
# {{ ansible_managed }}
#
NOW=`date +"%Y-%m-%d_%Hh%Mm"`
echo `/usr/local/bin/automysqlbackup` > {{ automysqlbackup_log_dir }}/backup-$NOW.log \
&& echo $NOW > {{ automysqlbackup_backup_dir }}/automysqlbackup_status

chown root.root /var/backup/db* -R
find /var/backup/db* -type f -exec chmod 400 {} \;
find /var/backup/db* -type d -exec chmod 700 {} \;