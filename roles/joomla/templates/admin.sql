#INSERT  INTO `{{joomla_site_dbprefix}}users`   (`name`, `username`, `password`, `params`)
#SELECT * FROM (SELECT 'Administrator', '{{joomla_admin_login}}', md5('{{joomla_admin_passwd}}'), '') AS TMP
#WHERE NOT EXISTS (
#        select `username`
#        from `{{joomla_site_dbprefix}}users`
#        where `username` = '{{joomla_admin_login}}'
#) LIMIT 1;


#INSERT INTO `{{joomla_site_dbprefix}}user_usergroup_map` (`user_id`,`group_id`) VALUES (LAST_INSERT_ID(),'8')
#WHERE NOT EXISTS (select `username` from `{{joomla_site_dbprefix}}users` where `username` = '{{joomla_admin_login}}');


INSERT  INTO `{{joomla_site_dbprefix}}users`   (`name`, `username`, `password`, `params`) VALUES ('Administrator', '{{joomla_admin_login}}', md5('{{joomla_admin_passwd}}'), '');
INSERT INTO `{{joomla_site_dbprefix}}user_usergroup_map` (`user_id`,`group_id`) VALUES (LAST_INSERT_ID(),'8');
