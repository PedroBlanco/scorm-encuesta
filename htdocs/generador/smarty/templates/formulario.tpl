<form role="form" target="_self" enctype="application/x-www-form-urlencoded" method="post" action="generador.php" id="introducir_parametros" name="introducir_parametros">
  <div class="row">
    <div class="col-md-3">
      <div class="form-group">
    	<label for="target">Denominaci&oacute;n simple del formulario:</label>
    	<input class="form-control" placeholder="Denominaci&oacute;n simple del formulario" maxlength="16" size="16" required="required" id="target" name="target" type="text" />
      </div>
      <div class="form-group">
    	<label for="target_url">URL de destino de los datos (carpeta contenedora):</label>
    	<input class="form-control" placeholder="URL de destino de los datos (carpeta contenedora)" required="required" id="target_url" name="target_url" type="text" value="{$params.target_url}" size="60" />
      </div>
    </div>
    <div class="col-md-3">
      <div class="form-group">
    	<label for="comment">Comentario:</label>
    	<br />
    	<textarea class="form-control" placeholder="Comentario" maxlength="200" required="required" wrap="hard" rows="5" cols="50" id="comment" name="comment">{$params.comment}</textarea>
      </div>
    </div>
    <div class="col-md-2">
      <div class="form-group">
    	<label for="db_host">Host de la BD:</label>
    	<input class="form-control" placeholder="Host de la BD" maxlength="16" size="16" required="required" value="{$params.db_host}" id="db_host" name="db_host" type="text" />
      </div>
      <div class="form-group">
    	<label for="db_port">Puerto de la BD:</label>
    	<input class="form-control" placeholder="Puerto de la BD" max="65536" min="1" required="required" value="{$params.db_port}" id="db_port" name="db_port" type="number" />
      </div>
    </div>
    <div class="col-md-2">
      <div class="form-group">
    	<label for="db_user">Usuario de la BD:</label>
    	<input class="form-control" placeholder="Usuario de la BD" maxlength="16" size="16" required="required" id="db_user" name="db_user" type="text" />
      </div>
      <div class="form-group">
    	<!-- FIXME: Pedir el password dos veces como medida de seguridad -->
    	<label for="db_pass">Contrase&ntilde;a de la BD:</label>
    	<input class="form-control" placeholder="Contrase&ntilde;a de la BD" maxlength="16" size="16" required="required" id="db_pass" name="db_pass" type="password" />
      </div>
    </div>
    <div class="col-md-2">
      <div class="form-group">
    	<label for="db_name">Nombre de la BD:</label>
    	<input class="form-control" placeholder="Nombre de la BD" maxlength="16" size="16" required="required" value="{$params.db_name}" id="db_name" name="db_name" type="text" />
      </div>
      <div class="form-group">
    	<label for="db_table">Nombre de la tabla de la BD:</label>
    	<input class="form-control" placeholder="Nombre de la tabla de la BD" maxlength="16" size="16" required="required" id="db_table" name="db_table" type="text" />
      </div>
    </div>
  </div>
  <div class="form-group row col-md-12 btn-group" role="group" aria-label="...">
    <button type="submit" class="btn btn-primary active" formtarget="_self" formenctype="application/x-www-form-urlencoded" formmethod="post" value="Siguiente paso" id="submit" name="submit" style="float:right;">Siguiente paso</button>
    <button class="btn btn-danger" type="reset" value="reset" id="reset" name="reset" style="float:right;">Reiniciar formulario</button>
    <button class="btn" type="button" value="clean" id="clean" name="clean" style="float:right;">Limpiar formulario</button>
  </div>
  <input value="paso_1" id="commit" name="commit" type="hidden"/>
</form>
