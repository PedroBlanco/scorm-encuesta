 <div class="row"> <!-- FIXME -->
   <div class="col-sm-1">
     &nbsp;
   </div>
   <div class="col-sm-10">
    <br />
    <form role="form" target="_self" enctype="application/x-www-form-urlencoded" method="post" action="generador.php" id="generar_encuesta" name="generar_encuesta">
      <div class="form-group">
        <label for="target">Denominaci&oacute;n simple del formulario:</label>
        <input class="form-control" maxlength="16" size="16" required="required" id="target" name="target" type="text" />
      </div>
      <div class="form-group">
        <label for="target_url">URL de destino de los datos (carpeta contenedora):</label>
        <input class="form-control" required="required" id="target_url" name="target_url" type="text" value="{$params.target_url}" size="60" />
      </div>
      <div class="form-group">
        <label for="comment">Comentario:</label>
        <br />
        <textarea class="form-control" maxlength="200" required="required" wrap="hard" rows="4" cols="50" id="comment" name="comment">{$params.comment}</textarea>
      </div>
      <div class="form-group">
        <label for="db_host">Host de la BD:</label>
        <input class="form-control" maxlength="16" size="16" required="required" value="{$params.db_host}" id="db_host" name="db_host" type="text" />
      </div>
      <div class="form-group">
        <label for="db_user">Usuario de la BD:</label>
        <input class="form-control" maxlength="16" size="16" required="required" id="db_user" name="db_user" type="text" />
      </div>
      <div class="form-group">
        <!-- FIXME: Pedir el password dos veces como medida de seguridad -->
        <label for="db_pass">Contrase&ntilde;a de la BD:</label>
        <input class="form-control" maxlength="16" size="16" required="required" id="db_pass" name="db_pass" type="password" />
      </div>
      <div class="form-group">
        <label for="db_name">Nombre de la BD:</label>
        <input class="form-control" maxlength="16" size="16" required="required" value="{$params.db_name}" id="db_name" name="db_name" type="text" />
      </div>
      <div class="form-group">
        <label for="db_table">Nombre de la tabla de la BD:</label>
        <input class="form-control" maxlength="16" size="16" required="required" id="db_table" name="db_table" type="text" />
      </div>
      <div class="form-group">
        <label for="db_port">Puerto de la BD:</label>
        <input class="form-control" max="65536" min="1" required="required" value="{$params.db_port}" id="db_port" name="db_port" type="number" />
      </div>
      <div class="form-group">
        <button type="submit" class="btn btn-default" formtarget="_self" formenctype="application/x-www-form-urlencoded" formmethod="post" value="Generar encuesta..." id="submit" name="submit">Generar encuesta...</button>
        <br />
        <input value="true" id="commit" name="commit" type="hidden">
      </div>
    </form>
  </div>
  <div class="col-sm-1">
    &nbsp;
  </div>
</div>