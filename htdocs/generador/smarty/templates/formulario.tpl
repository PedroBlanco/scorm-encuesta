<div style="width: 20em;text-align: left;">
    <h1>{$app_name}</h1>
    <br />
    <form target="_self" enctype="application/x-www-form-urlencoded" method="post" action="generador.php" name="generar_encuesta">
      <label for="target">Denominaci�n simple del formulario:�</label>
      <input maxlength="16" size="16" required="required" name="target" type="text" />
      <br />
      <label for="target_url">URL de destino de los datos (carpeta contenedora):�</label>
      <input required="required" name="target_url" type="text" value="{$params.target_url}" size="60" />
      <br />
      <label for="comment">Comentario:�</label>
      <br />
      <textarea maxlength="200" required="required" wrap="hard" rows="4" cols="50" name="comment">{$params.comment}</textarea>
      <br />
      <label for="db_host">Host de la BD:�</label>
      <input maxlength="16" size="16" required="required" value="{$params.db_host}" name="db_host" type="text" />
      <br />
      <label for="db_user">Usuario de la BD:�</label>
      <input maxlength="16" size="16" required="required" name="db_user" type="text" />
      <br />
      <label for="db_pass">Contrase�a de la BD:�</label>
      <input maxlength="16" size="16" required="required" name="db_pass" type="text" />
      <br />
      <label for="db_name">Nombre de la BD:�</label>
      <input maxlength="16" size="16" required="required" value="{$params.db_name}" name="db_name" type="text" />
      <br />
      <label for="db_table">Nombre de la tabla de la BD:�</label>
      <input maxlength="16" size="16" required="required" name="db_table" type="text" />
      <br />
      <label for="db_port">Puerto de la BD:�</label>
      <input max="65536" min="1" required="required" value="{$params.db_port}" name="db_port" type="number" />
      <br />
      <input formtarget="_self" formenctype="application/x-www-form-urlencoded" formmethod="post" value="Generar archivos..."
      name="submit" type="submit" />
      <br />
      <input value="true" name="commit" type="hidden">
    </form>
</div>
