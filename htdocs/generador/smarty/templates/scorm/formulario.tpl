<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html lang="es-es" xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8" />
    <title>Encuesta an&oacute;nima</title>
    <meta name="author" content="{$dato['AUTHOR']}" />
	<meta name="target" content="{$dato['TARGET']}" />
	<meta name="version" content="{$dato['VERSION']}" />
    <!-- {$dato['COMMENT']} -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<script>
//<![CDATA[
"use strict";

// Desde dentro de un SCORM no se ejecuta ajaxSuccess...
function ajaxSuccess () {
  document.getElementById('exito').innerHTML = this.responseText;
  document.getElementById('exito').style.visibility = 'visible';
}

function ejecutar () {
	var oReq = new XMLHttpRequest();
	oReq.onload = ajaxSuccess;

	var oForm = new FormData ();


{foreach from=$preguntas item=_set key=_tab name=outer}{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
  oForm.append ( 'pregunta_'+{$_tab}+'_'+{$_id}, $( '#pregunta_'+{$_tab}+'_'+{$_id} ).val() );
{/foreach}{/foreach}

	oForm.append ( 'comentario', $( '#comentario' ).val() );

	oReq.open ( 'post', '{$dato["TARGET_URL"]}/{$dato["TARGET"]}.php', true );
    oReq.send ( oForm );

	document.getElementById('exito').style.visibility = 'visible';
}
//]]>
</script>
<script>
	$(function() {
		$( "#tabs" ).tabs();
	 }
  );
</script>
<script>
  $(function() {
    $( "div[id^='slider']" ).slider( {
      value:10,
      min: 1,
      max: 10,
      step: 1,
      slide: function( event, ui ) {
        $( "#" + $(this).attr("rel") ).val( ui.value );
      }
     }
  );

{foreach from=$preguntas item=_set key=_tab name=outer}{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
    $( '#pregunta_'+{$_tab}+'_'+{$_id} ).val( $( '#slider_'+{$_tab}+'_'+{$_id} ).slider( "value" ) );
{/foreach}{/foreach}
   }
  );
</script>

  </head>
  <body>
    <h1 class="ui-widget">
    Encuesta an&oacute;nima
    </h1>
	<p class="ui-widget">
	Este cuestionario es an&oacute;nimo, por tanto rogamos responda con sinceridad y objetividad. Su opini&oacute;n ser&aacute; de gran utilidad y ser&aacute; tenida en cuenta, por lo que esperamos que colabore en la medida de lo posible.
	</p>
	<p class="ui-widget">
	Valore de 1 a 10 su aceptaci&oacute;n de los diversos aspectos, (1 valor m&aacute;s negativo y 10 el m&aacute;s positivo).<br/>
  Para puntuar arrastre el bot&oacute;n de cada barra y se actualizar&aacute; el valor que se muestra junto a la pregunta.<br/>
  Cuando termine, pulse el bot&oacute;n "Enviar encuesta" en la pesta&ntilde;a de "Comentarios".
	</p>

  <div id="tabs">
    <ul>
  {foreach from=$preguntas key=_tab item=_set name=outer}
    <li><a href="#tabs-{$_tab}">{$_set['title']}</a></li>
  {/foreach}
    <li><a href="#tabs-comment">Comentarios</a></li>
  </ul>
  <form action="{$dato['TARGET_URL']}/{$dato['TARGET']}.php" method="post" enctype="multipart/form-data" onsubmit="document.getElementById('boton_submit').style.display = 'none'; ejecutar(); return false;">

{foreach from=$preguntas key=_tab item=_set name=outer}
    <div id="tabs-{$_tab}">
{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
      <p>
        <label for="pregunta_{$_tab}_{$_id}">{$_pregunta}</label>
        <input type="text" id="pregunta_{$_tab}_{$_id}" style="border:0; color:#f6931f; font-weight:bold;" />
      </p>
      <div id="slider_{$_tab}_{$_id}" rel="pregunta_{$_tab}_{$_id}"></div>
{/foreach}
    </div>
{/foreach}
  <div id="tabs-comment">
  <p>
	<p><label for="comentario">Comentarios (positivos y/o negativos):</label></p>
	<textarea id="comentario" rows="5" cols="50" maxlength="1000"></textarea>
	</p>
	<p>
	<input id="boton_submit" type="submit" value="Enviar encuesta" />
	<p class="ui-widget" id="exito" style="visibility: hidden;">
		Gracias por realizar la encuesta. Ya puede salir de la actividad.
	</p>
	</p>
  </div>
  </form>
</div>
</body>
</html>
