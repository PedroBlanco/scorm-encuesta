<table class="table table-hover table-bordered">
  <thead><h2>Par&aacute;metros</h2></thead>
  <tr>
    <th scope="row">Denominaci&oacute;n simple del formulario</th>
    <td class="mono">{$params.target}</td>
  </tr>
  <tr>
    <th scope="row">URL de destino de los datos</th>
    <td class="mono">{$params.target_url}</td>
  </tr>
  <tr>
    <th scope="row">Comentario</th>
    <td class="mono">{$params.comment}</td>
  </tr>
  <tr>
    <th scope="row">Host de la BD</th>
    <td class="mono">{$params.db_host}</td>
  </tr>
  <tr>
    <th scope="row">Usuario de la BD</th>
    <td class="mono">{$params.db_user}</td>
  </tr>
  <tr>
    <th scope="row">Contrase&ntilde;a de la BD</th>
    <td>
      <div class="spoiler">
        <div class="spoiler-btn" value="Ocultar contrase&ntilde;a">Mostrar contrase&ntilde;a</div>
        <div class="spoiler-body collapse mono">{$params.db_pass}</div>
      </div>
    </td>
  </tr>
  <tr>
    <th scope="row">Nombre de la BD</th>
    <td class="mono">{$params.db_name}</td>
  </tr>
  <tr>
    <th scope="row">Nombre de la tabla de la BD</th>
    <td class="mono">{$params.db_table}</td>
  </tr>
  <tr>
    <th scope="row">Puerto de la BD</th>
    <td class="mono">{$params.db_port}</td>
  </tr>
{if $estado_pagina eq 10}
  <tr>
    <th scope="row">Notas varias</th>
    <td><pre>{$notas}</pre></td>
  </tr>
{/if}
</table>
