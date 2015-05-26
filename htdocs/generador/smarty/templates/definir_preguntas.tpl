<div class="row col-sm-6">
  <form role="form" target="_self" enctype="application/x-www-form-urlencoded" method="post" action="generador.php" id="definir_preguntas" name="definir_preguntas">
    <h1>Aqu&iacute; definiremos las preguntas</h1>

    <input id="target" name="target" type="hidden" value="{$params.target}" />
    <input id="target_url" name="target_url" type="hidden" value="{$params.target_url}" />
    <input id="comment" name="comment" type="hidden" value="{$params.comment}" />
    <input id="db_host" name="db_host" type="hidden" value="{$params.db_host}" />
    <input id="db_user" name="db_user" type="hidden" value="{$params.db_user}" />
    <input id="db_pass" name="db_pass" type="hidden" value="{$params.db_pass}" />
    <input id="db_name" name="db_name" type="hidden" value="{$params.db_name}" />
    <input id="db_table" name="db_table" type="hidden" value="{$params.db_table}" />
    <input id="db_port" name="db_port" type="hidden" value="{$params.db_port}" />

    <div class="form-group row col-md-12 btn-group" role="group" aria-label="...">
      <button type="submit" class="btn btn-primary active" formtarget="_self" formenctype="application/x-www-form-urlencoded" formmethod="post" value="Generar encuesta" id="submit" name="submit">Generar encuesta</button>
      {* FIXME: estudiar qué botones deben aparecer en este formulario, porque no deberíamos poder tocar los valores del anterior formulario...  *}
      <button class="btn btn-danger" type="reset" value="reset" id="reset" name="reset">Reiniciar formulario</button>
      <button class="btn" type="button" value="clean" id="clean" name="clean">Limpiar formulario</button>
    </div>
    <input value="paso_2" id="commit" name="commit" type="hidden"/>
  </form>
</div>
