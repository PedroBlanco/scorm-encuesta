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
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            padding-top: 20px;
            padding-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="css/main.css">

    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
</head>
<body>
    <!--[if lt IE 8]>
        <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
  <div class="container-fluid"> <!-- *** container *** -->
    <div class="row col-sm-12">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">{$app_name}</a>
      </div>
      <div id="myNavbar">
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
              <span class="glyphicon glyphicon-ok" id="local_storage_ok"></span>
              <span class="glyphicon glyphicon-remove" id="local_storage_fail"></span> localStorage
              <span class="caret"></span>
              <ul class="dropdown-menu">
                <li><a id="guardar_config" href="#">Guardar</a></li>
                <li><a id="recargar_config" href="#">Recargar</a></li>
                <li class="divider"></li>
                <li><a id="borrar_config" href="#">Borrar</a></li>
              </ul>
            </a>
          </li>
          <li><a href="#"><span class="glyphicon glyphicon-question-sign"></span> Ayuda</a></li>
        </ul>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <ol class="breadcrumb">
          <li id="miga_1"><a href="#">Inicio</a></li>
          <li style="display:hidden" id="miga_2"><a href="#">Paquete generado</a></li>
        </ol>
      </div>
      <div class="col-sm-6" id="alerts">
      </div>
    </div>
