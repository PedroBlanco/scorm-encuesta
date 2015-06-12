<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{$app_name}</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <link rel="icon" type="image/x-icon" href="favicon.ico">

{if $estado_pagina eq 10}
    <link rel="stylesheet" href="css/highlight/idea.css">
    <script src="js/vendor/highlight.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
{/if}

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            padding-top: 20px;
            padding-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">

    <!-- ¿Incluimos los archivos para jquery-ui actualizado ? -->
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/jquery-ui.structure.css">


    <!-- Incluimos los archivos para jquery-ui + bootstrap -->
    <link rel="stylesheet" href="css/jquery.ui.1.10.0.ie.css">
    <link rel="stylesheet" href="css/jquery-ui-1.10.0.custom.css">


{if $estado_pagina eq 2}
    <link rel="stylesheet" href="css/definir_preguntas.css">
{/if}

    <link rel="stylesheet" href="css/main.css">

    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
</head>
<body>
  {include file='about_modal.tpl'}
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
  <div class="container-fluid"> <!-- *** container *** -->
    <div class="row col-sm-12 cabecera">
      <div class="navbar-header">
        <a class="navbar-brand" href="."><img src="css/images/scorm_logo.png" alt="{$app_name}"/></a>
      </div>
      <div id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
              <span class="glyphicon glyphicon-ok" id="local_storage_ok"></span>
              <span class="glyphicon glyphicon-warning-sign" id="local_storage_fail"></span> Configuración
              <span class="caret"></span>
              <ul class="dropdown-menu">
                <li><a id="guardar_config" href="#">Guardar</a></li>
                <li><a id="recargar_config" href="#">Recargar</a></li>
                <li class="divider"></li>
                <li><a id="borrar_config" href="#">Borrar</a></li>
              </ul>
            </a>
          </li>
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
              <span class="glyphicon glyphicon-question-sign"></span> Ayuda
              <span class="caret"></span>
              <ul class="dropdown-menu">
                <li><a id="menu_ayuda" href="#">Manual de usuario</a></li>
                <li class="divider"></li>
                <li><a id="menu_about" data-toggle="modal" data-target="#about_modal" href="#">Acerca de...</a></li>
              </ul>
            </a>
          </li>
        </ul>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
{if $estado_pagina eq 1}
        <ol class="breadcrumb">
          <li id="miga_1"><strong>1. Introducir par&aacute;metros</strong></li>
        </ol>
{elseif $estado_pagina eq 2}
        <ol class="breadcrumb">
          <li id="miga_1"><a href="#" onclick="javascript:history.go(-1);">1. Introducir par&aacute;metros</a></li>
          <li id="miga_2"><strong>2. Definir preguntas</strong></li>
        </ol>
{elseif $estado_pagina eq 10}
        <ol class="breadcrumb">
          <li id="miga_1"><a href="#" onclick="javascript:history.go(-2);">1. Introducir par&aacute;metros</a></li>
          <li id="miga_2"><a href="#" onclick="javascript:history.go(-1);">2. Definir preguntas</a></li>
          <li id="miga_10"><strong>3. Encuesta generada</strong></li>
        </ol>
{else}
        <div class="alert alert-danger">Error: Estado de p&aacute;gina desconocido: '{$estado_pagina}'</div>
{/if}
      </div>
    </div>
