<div class="row col-sm-12">
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
      <div class="well">

{for $foo=1 to 3}
        <ul id="sortable{$foo}" class="tab-sortable droptrue">
          <li class="ui-state-highlight question-tab-title">
            <span class="glyphicon glyphicon-plus"></span>
            <span class="question-tab-text" id="_{$foo}">Tab {$foo}</span>
            <span class="glyphicon glyphicon-pencil"></span>
            <span class="glyphicon glyphicon-remove"></span>
          </li>
{for $bar=1 to 3}
          <li class="ui-state-default question-item-title">
            <span class="glyphicon glyphicon-move"></span>
            <span class="question-item-text" id="_{$foo}_{$bar}">Item {$foo}-{$bar}</span>
            <span class="glyphicon glyphicon-pencil"></span>
            <span class="glyphicon glyphicon-remove"></span>
          </li>
{/for}
        </ul>
{/for}
<!--
        <ul id="sortable1" class="tab-sortable droptrue">
          <li class="ui-state-highlight question-tab-title">
            <span>Titulo</span>
            <span class="glyphicon glyphicon-pencil"></span>
            <span class="glyphicon glyphicon-remove"></span>
          </li>
          <li class="ui-state-default">
            <span class="glyphicon glyphicon-move"></span>
            <span>Item 1</span>
            <span class="glyphicon glyphicon-pencil"></span>
            <span class="glyphicon glyphicon-remove"></span>
          </li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 2</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 3</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 4</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 5</li>
        </ul>

        <ul id="sortable2" class="tab-sortable droptrue">
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 1</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 2</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 3</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 4</li>
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 5</li>
        </ul>

        <ul id="sortable3" class="tab-sortable droptrue">
          <li class="ui-state-default"><span class="glyphicon glyphicon-move"></span>Item 1</li>
        </ul>
 -->
        <br style="clear:both" />
      </div>
      <button type="submit" class="btn btn-primary active" formtarget="_self" formenctype="application/x-www-form-urlencoded" formmethod="post" value="Generar encuesta" id="submit" name="submit">Generar encuesta</button>
      {* FIXME: estudiar qué botones deben aparecer en este formulario, porque no deberíamos poder tocar los valores del anterior formulario...  *}
      <button class="btn btn-danger" type="reset" value="reset" id="reset" name="reset">Reiniciar formulario</button>
      <button class="btn" type="button" value="clean" id="clean" name="clean">Limpiar formulario</button>
    </div>
    <input value="paso_2" id="commit" name="commit" type="hidden"/>
  </form>
</div>
