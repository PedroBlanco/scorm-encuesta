<div class="row col-sm-4">
  <table class="table table-hover table-bordered">
    <thead><h2>Preguntas</h2></thead>
{foreach from=$preguntas item=pregunta name=outer}
    <tr>
      <th scope="row">{$pregunta|print_r}</th>
      <td><ul>
{foreach from=$pregunta.items item=_q name=inner}
        <li>{$_q|print_r}</li>
{/foreach}</ul>
      </td>
    </tr>
{/foreach}
    <tr>
      <th scope="row">JSON</th>
      <td><pre style="white-space: pre-wrap;">{$preguntas}</pre></td>
    </tr>
  </table>
</div>
