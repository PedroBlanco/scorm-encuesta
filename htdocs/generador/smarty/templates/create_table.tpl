CREATE TABLE IF NOT EXISTS `{$params.db_table}` (
`idFormulario` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
{foreach from=$preguntas item=_set key=_tab name=outer}
{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
`pregunta_{$_tab}_{$_id}` TINYINT(3) UNSIGNED NOT NULL DEFAULT '10' COMMENT '{$_pregunta}',
{/foreach}
{/foreach}
`comentario` VARCHAR(3000) NOT NULL DEFAULT '' COMMENT 'La longitud del campo es 3000, para que haya sitio de sobre para los 1000 caracteres del formulario html al cada caracter utf8 poder ocupar 3bytes.',
PRIMARY KEY (`idFormulario`)
);
