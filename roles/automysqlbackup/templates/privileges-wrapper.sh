#!/usr/bin/env bash
#
# {{ ansible_managed }}
#
/usr/bin/mysqldump -nt mysql user db | gzip > /var/backup/db/privileges.sql.gz
