<table class="table table-hover table-bordered">
  <thead><h2>Archivos generados</h2></thead>
  <tr>
    <th scope="row" class="col-xs-3">Definici&oacute;n de la BD</th>
    <td>{$sql_create_table}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar archivo">Mostrar archivo</div>
        <div class="spoiler-body collapse mono"><pre><code class="sql">{include file='create_table.tpl' scope=parent}</code></pre></div>
      </div>
    </td>
  </tr>{*
  <tr>
    <th scope="row">Paquete completo</th>
    <td>{$package_file}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar contenido">Mostrar contenido</div>
        <div class="spoiler-body collapse">
          <table class="table table-hover table-bordered">
  {foreach from=$package_files_array['scorm'] item=_file key=_key}
            <tr>
              <th scope="row">{$_file[0]}</th>
  {if $_file[3] eq 0}
              <td colspan="2">{$_file[2]}</td>
  {else}
            <td>{$_file[2]}</td>
            <td>
              <button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal_file_{$_key}">Previsualizar</button>
            </td>
            <!-- FIXME: Creo que es un mal sitio para definir un modal, pero funciona por ahora ... -->
            <div id="modal_file_{$_key}" class="modal fade" role="dialog">
              <div class="modal-dialog modal-lg">
  {if $_file[3] eq 1}
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
                    <h4 class="modal-title">
                      {$_file[0]}
                    </h4>
                  </div>
                  <div class="modal-body">
                    <pre><code class="xml">{$_file[1]|escape}</code></pre>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
  {else}
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
                    <h4 class="modal-title">
                      {$_file[0]}
                    </h4>
                  </div>
                  <div class="modal-body">
                    <ul class="nav nav-tabs">
                      <li class="active">
                        <a data-toggle="tab" href="#previsualizar_formulario">Previsualizar formulario</a>
                        </li>
                      <li>
                        <a data-toggle="tab" href="#mostrar_codigo_formulario">Ver c&oacute;digo del formulario</a>
                      </li>
                    </ul>
                    <div class="tab-content">
                      <div id="previsualizar_formulario" class="tab-pane fade in active">
                        {$_file[4]}
                      </div>
                      <div id="mostrar_codigo_formulario" class="tab-pane fade in">
                        <pre><code class="html">{$_file[1]|escape}</code></pre>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
  {/if}
              </div>
            </div>
  {/if}
          </tr>
  {/foreach}
          </table>
        </div>
      </div>
    </td>
  </tr>*}
  <tr>
    <th scope="row">Definici&oacute;n del usuario de la BD</th>
    <td>{$sql_create_user}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar archivo">Mostrar archivo</div>
        <div class="spoiler-body collapse mono"><pre><code class="sql">{include file='create_user.tpl' scope=parent}</code></pre></div>
      </div>
    </td>
  </tr>
  <tr>
    <th scope="row">Paquete SCORM</th>
    <td>
      {$scorm_file}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar contenido">Mostrar contenido</div>
        <div class="spoiler-body collapse">
          <table class="table table-hover table-bordered">
{foreach from=$files_array['scorm'] item=_file key=_key}
            <tr>
              <th scope="row">{$_file[0]}</th>
{if $_file[3] eq 0}
              <td colspan="2">{$_file[2]}</td>
{else}
            <td>{$_file[2]}</td>
            <td>
              <button type="button" class="btn btn-info" data-toggle="modal" data-target="#modal_file_{$_key}">Previsualizar</button>
            </td>
            <!-- FIXME: Creo que es un mal sitio para definir un modal, pero funciona por ahora ... -->
            <div id="modal_file_{$_key}" class="modal fade" role="dialog">
              <div class="modal-dialog modal-lg">
{if $_file[3] eq 1}
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
                    <h4 class="modal-title">
                      {$_file[0]}
                    </h4>
                  </div>
                  <div class="modal-body">
                    <pre><code class="xml">{$_file[1]|escape}</code></pre>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
{else}
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span></button>
                    <h4 class="modal-title">
                      {$_file[0]}
                    </h4>
                  </div>
                  <div class="modal-body">
                    <ul class="nav nav-tabs">
                      <li class="active">
                        <a data-toggle="tab" href="#previsualizar_formulario">Previsualizar formulario</a>
                        </li>
                      <li>
                        <a data-toggle="tab" href="#mostrar_codigo_formulario">Ver c&oacute;digo del formulario</a>
                      </li>
                    </ul>
                    <div class="tab-content">
                      <div id="previsualizar_formulario" class="tab-pane fade in active">
                        {$_file[4]}
                      </div>
                      <div id="mostrar_codigo_formulario" class="tab-pane fade in">
                        <pre><code class="html">{$_file[1]|escape}</code></pre>
                      </div>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                  </div>
                </div>
{/if}
              </div>
            </div>
{/if}
          </tr>
{/foreach}
          </table>
        </div>
      </div>
    </td>
  </tr>
  <tr>
    <th scope="row">Archivo procesador/receptor de la encuesta</th>
    <td>{$php_connect_file}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar archivo">Mostrar archivo</div>
        <div class="spoiler-body collapse mono"><pre><code class="php">{$php_connect_file_contents|escape}</code></pre></div>
      </div>
    </td>
  </tr>
</table>
