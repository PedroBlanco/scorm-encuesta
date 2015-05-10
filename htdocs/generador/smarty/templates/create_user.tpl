CREATE USER `{$params.db_user}`@`{$params.db_host}` IDENTIFIED BY '{$params.db_pass}';
GRANT INSERT ON TABLE `{$params.db_name}`.`{$params.db_table}` TO `{$params.db_user}`@`{$params.db_host}`;
