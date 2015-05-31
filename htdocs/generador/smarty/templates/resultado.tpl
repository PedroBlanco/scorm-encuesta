<table class="table table-hover table-bordered">
  <thead><h2>Archivos generados</h2></thead>
  <tr>
    <th scope="row">Definici&oacute;n de la BD</th>
    <td><pre><code class="sql">{include file='create_table.tpl' scope=parent}</code></pre></td>
  </tr>
  <tr>
    <th scope="row">Definici&oacute;n del usuario de la BD</th>
    <td><pre><code class="sql">{include file='create_user.tpl' scope=parent}</code></pre></td>
  </tr>
  <tr>
    <th scope="row">Archivo .phps</th>
    <td>{$php_connect_file}
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar archivo">Mostrar archivo</div>
        <div class="spoiler-body collapse mono"><pre><code class="php">{$php_connect_file_contents|escape}</code></pre></div>
      </div>
    </td>
  </tr>
  <tr>
    <th scope="row">Archivo SCORM</th>
    <td>{$scorm_file}</td>
  </tr>
</table>
