<h1>{$app_name}</h1>
<div style="text-align: left;">
    <h2>Par&aacute;metros</h2>
    Denominaci&oacute;n simple del formulario: {$params.target}<br /><br />
    URL de destino de los datos:<br />{$params.target_url}<br /><br />
    Comentario:<br />
      <textarea disabled="disabled" maxlength="200" required="required" wrap="hard" rows="4" cols="50" name="comment">{$params.comment}</textarea>
      <br /><br />
    Host de la BD:{$params.db_host}<br /><br />
    Usuario de la BD: {$params.db_user}<br /><br />
    Contrase&ntilde;a de la BD:{$params.db_pass}<br /><br />
    Nombre de la BD:{$params.db_name}<br /><br />
    Nombre de la tabla de la BD:{$params.db_table}<br /><br />
    Puerto de la BD: {$params.db_port}<br /><br />
</div>
