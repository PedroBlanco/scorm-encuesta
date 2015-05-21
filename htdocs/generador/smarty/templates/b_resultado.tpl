<h2>Ficheros</h2>
<div id="BD_DEF" class="form-group">
  <label for="create_table">Definici&oacute;n de la BD</label>
    <textarea maxlength="1500" wrap="hard" rows="15" cols="100" class="form-control" id="create_table">{include file='create_table.tpl' scope=parent}</textarea>
    <br/><br/>
    <label for="create_user">Definici&oacute;n del usuario de la BD</label>
    <textarea maxlength="1500" wrap="hard" rows="3" cols="100" class="form-control" id="create_user">{include file='create_user.tpl' scope=parent}</textarea>
    <br/><br/>
</div>
<div id="PHP_DEF">
  <h3>Archivo .phps</h3>
  {$php_connect_file}<br/>
  {*
  <textarea maxlength="1500" wrap="hard"
  rows="15" cols="100">{$php_connect|escape:'htmlall'}</textarea><br/><br/>
  *}
</div>
<div id="SCORM_DEF">
  <h3>Archivo SCORM</h3>
  {$scorm_file}<br/>
</div>
<div id="NOTAS" class="form-group">
  <label for="notes">Notas varias</label>
  <textarea maxlength="1500" wrap="hard" rows="15" cols="100" class="form-control" id="notes">{$notas}</textarea>
  <br/><br/>
</div>
