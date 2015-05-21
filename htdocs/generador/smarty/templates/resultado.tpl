<div class="row col-sm-6">
<h2>Ficheros</h2>
<div id="BD_DEF">
  <h3>Definici&oacute;n de la BD</h3>
    <br />
    <mark>{include file='create_table.tpl' scope=parent}</mark>
    <br/><br/>
    <h3>Definici&oacute;n del usuario de la BD</h3>
    <br />
    <mark>{include file='create_user.tpl' scope=parent}</mark>
    <br/><br/>
</div>
<div id="PHP_DEF">
  <h3>Archivo .phps</h3>
  {$php_connect_file}<br/>
</div>
<div id="SCORM_DEF">
  <h3>Archivo SCORM</h3>
  {$scorm_file}<br/>
</div>
<div id="NOTAS">
  <h3>Notas varias</h3>
  <br />
  <mark>{$notas}</mark>
  <br/><br/>
</div>
</div>
