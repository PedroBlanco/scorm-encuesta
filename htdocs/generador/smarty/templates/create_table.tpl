CREATE TABLE `{$params.db_table}` ( `idFormulario` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT, `pregunta1` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta2` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta3` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta4` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta5` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta6` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta7` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta8` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta9` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta10` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta11` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta12` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta13` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta14` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta15` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta16` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta17` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `pregunta18` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10', `comentario` VARCHAR(3000) NOT NULL DEFAULT '' COMMENT 'La longitud del campo es 3000, para que haya sitio de sobre para los 1000 caracteres del formulario html al cada caracter utf8 poder ocupar 3bytes.', PRIMARY KEY (`idFormulario`) ) ENGINE=InnoDB;
