<table class="table table-hover table-bordered">
  <thead><h2>Preguntas</h2></thead>
{foreach from=$preguntas item=_set name=outer}
  <tr>
    <th scope="row">
      {$_set['title']}
    </th>
    <td><ul>
{foreach from=$_set['items'] item=_pregunta name=inner}
      <li>{$_pregunta}</li>
{/foreach}</ul>
    </td>
  </tr>
{/foreach}
{*<tr>
    <th scope="row">JSON</th>
    <td><pre style="white-space: pre-wrap;">{$preguntas}</pre></td>
  </tr>*}
</table>
