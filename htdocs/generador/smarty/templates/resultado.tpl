<h2>Ficheros</h2>
<div id="BD_DEF">
<h3>Definici&oacute;n de la BD</h3>
<textarea maxlength="1500" wrap="hard" rows="15" cols="100">{include file='create_table.tpl' scope=parent}</textarea><br/><br/>
<h3>Definici&oacute;n del usuario de la BD</h3>
<textarea maxlength="1500" wrap="hard" rows="3" cols="100">{include file='create_user.tpl' scope=parent}</textarea><br/><br/>
</div>
<div id="PHP_DEF">
<h3>Archivo .php</h3>{$php_connect_file}<br/>
{*
<textarea maxlength="1500" wrap="hard" rows="15" cols="100">{$php_connect|escape:'htmlall'}</textarea><br/><br/>
*}
</div>
<div id="SCORM_DEF">
<h3>Archivo SCORM</h3>
{$scorm_file}<br/>
</div>
<div id="NOTAS">
<h3>Notas varias</h3><br/>
<textarea maxlength="1500" wrap="hard" rows="15" cols="100">{$notas}</textarea><br/><br/>
</div>