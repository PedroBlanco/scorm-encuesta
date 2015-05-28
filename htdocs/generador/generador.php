<?php

/*** Constantes ***/

// Versión del script generador
$script_version = '0.1.2';

// Plantilla del script php
$php_template = 'fuentes/serverside.php';

// Nombre del archivo .html incluido en el SCORM
$html_scorm = 'formulario.html';

// Nombre del archivo .xml incluido en el SCORM
$xml_scorm = 'imsmanifest.xml';

//%%AUTHOR%% => Autor en el documento .html
$author = 'Pedro Blanco Wasmer';

//%%VERSION%% => Versión del paquete scorm generado
$sco_version = '0.9.9rc4';

$notas = '';

/*** Variables ***/
/** Valores por defecto **/

//%%NAME%% => Id del nombre del paquete (?)
$sco_name = "ENCUESTA-$script_version-".uniqid();

//%%ORGANIZATION%% => Id de Organizacion del SCORM
$sco_org = "ORG-ENCUESTA-$script_version-".uniqid();

//%%TITLE_ID%% => Id del elemento título
$sco_title = "TIT-ENCUESTA-$script_version-".uniqid();

//%%RES_ID%% = Id del recurso 'formulario'
$sco_resource = "RES-ENCUESTA-$script_version-".uniqid();

//%%TARGET%% => Cadena con una denominación simple del cuestionario; se usa también como nombre del archivo .php y como nombre de la tabla
$target = 'encuesta';

//%%TARGET_URL%% => Url donde se suben los archivos .php que conectarán con la BD
$target_url = 'http://localhost/encuesta-scorm';

//%%COMMENT%% => Comentario que aparece en el archivo .php y en el archivo .html con datos sobre el curso
$comment = 'Encuesta de prueba';

//%%DB_HOST%%
$db_host = 'localhost';

//%%DB_USER%%
$db_user = $target;

//%%DB_PASS%%
$db_pass = '';

//%%DB_NAME%%
$db_name = 'db_encuestas';

//%%DB_TABLE%%
$db_table = $target;

//%%BD_PORT%%
$db_port = 3306;

// Parejas de reemplazo por defecto en los archivos
$replace_pairs = array (
    '%%AUTHOR%%' => $author,
    '%%VERSION%%' => $sco_version,
    '%%NAME%%' => $sco_name,
    '%%ORGANIZATION%%' => $sco_org,
    '%%TITLE_ID%%' => $sco_title,
    '%%RES_ID%%' => $sco_resource,
    '%%TARGET%%' => $target,
    '%%TARGET_URL%%' => $target_url,
    '%%COMMENT%%' => $comment,
    '%%DB_HOST%%' => $db_host,
    '%%DB_USER%%' => $db_user,
    '%%DB_PASS%%' => $db_pass,
    '%%DB_NAME%%' => $db_name,
    '%%DB_TABLE%%' => $db_table,
    '%%BD_PORT%%' => $db_port
);

// Parámetros por defecto en el formulario
$default_params = array (
    'target_url' => $target_url,
    'comment' => $comment,
    'db_host' => $db_host,
    'db_name' => $db_name,
    'db_port' => $db_port,
);

/*** Inicialización de Smarty ***/
require_once('smarty/smarty_connect.php');
$smarty = new smarty_connect();


// TODO: Limpiar $_POST
$_POST_ok = $_POST;

// Si recibimos un commit, comprobamos de qué paso es
if ( isset ( $_POST_ok["commit"] ) ) {
  if ( !( stristr ( $_POST_ok["commit"], 'paso_2' ) === FALSE ) ) {
    // Si es del paso 2 "Definir preguntas", ejecutamos el paso final "Generar encuesta"

    if (! file_put_contents ( 'generados/'.$_POST_ok['target'].'_table.sql', $smarty->fetch( 'create_table.tpl' ) ) ) {
        $notas .= "ERROR: No se ha creado el archivo ".$_POST_ok['target']."_table.sql
        ";
    }

    if (! file_put_contents ( 'generados/'.$_POST_ok['target'].'_user.sql', $smarty->fetch( 'create_user.tpl' ) ) ) {
        $notas .= "ERROR: No se ha creado el archivo ".$_POST_ok['target']."_user.sql
        ";
    }


    // *** Generar los ficheros ***
    // ** PHP **
    // Parejas de reemplazo en los archivos
    $replace_pairs = array (
        '%%AUTHOR%%' => $author,
        '%%VERSION%%' => $sco_version,
        '%%NAME%%' => $sco_name,
        '%%ORGANIZATION%%' => $sco_org,
        '%%TITLE_ID%%' => $sco_title,
        '%%RES_ID%%' => $sco_resource,
        '%%TARGET%%' => $_POST_ok['target'],
        '%%TARGET_URL%%' => $_POST_ok['target_url'],
        '%%COMMENT%%' => $_POST_ok['comment'],
        '%%DB_HOST%%' => $_POST_ok['db_host'],
        '%%DB_USER%%' => $_POST_ok['db_user'],
        '%%DB_PASS%%' => $_POST_ok['db_pass'],
        '%%DB_NAME%%' => $_POST_ok['db_name'],
        '%%DB_TABLE%%' => $_POST_ok['db_table'],
        '%%BD_PORT%%' => $_POST_ok['db_port']
    );
    $php_connect = strtr ( file_get_contents ( $php_template ), $replace_pairs );

    if (! file_put_contents ( 'generados/'.$_POST_ok['target'].'.phps', $php_connect ) ) {
        $smarty->assign ( 'php_connect_file', "<span style='color:red;'>ERROR: No se ha creado el archivo ".$_POST_ok['target'].".phps</span><br/>" );
    } else {
        $smarty->assign ( 'php_connect_file', '<a href="generados/'.$_POST_ok['target'].'.phps">Enlace: '.$_POST_ok['target'].'.phps</a>' );
    }

    // ** SCORM (realmente es un archivo .zip ...) **
    $fichero_zip = new ZipArchive;
    $error_ZIP = $fichero_zip->open ( 'generados/'.$_POST_ok['target'].'.zip', ZipArchive::CREATE );
    if ( $error_ZIP === TRUE) {

        $fichero_zip->addFile('fuentes/scorm/adlcp_rootv1p2.xsd', 'adlcp_rootv1p2.xsd' );
        $fichero_zip->addFile('fuentes/scorm/ims_xml.xsd', 'ims_xml.xsd' );
        $fichero_zip->addFile('fuentes/scorm/imscp_v1p1.xsd', 'imscp_v1p1.xsd' );
        $fichero_zip->addFile('fuentes/scorm/imsmd_v1p2p2.xsd', 'imsmd_v1p2p2.xsd' );

        $fichero_zip->addFromString ( $html_scorm, strtr ( file_get_contents ( 'fuentes/scorm/'.$html_scorm ), $replace_pairs ) );
        $fichero_zip->addFromString ( $xml_scorm, strtr ( file_get_contents ( 'fuentes/scorm/'.$xml_scorm ), $replace_pairs ) );

        $fichero_zip->close();

        $smarty->assign( 'scorm_file', '<a href="generados/'.$_POST_ok['target'].'.zip">Enlace: '.$_POST_ok['target'].'.zip</a>' );
    } else {
        $smarty->assign( 'scorm_file', "<span style='color:red;'>ERROR: No se ha creado el archivo .zip: $error_ZIP</span><br/>" );
    }
    $notas .= $sco_name.'
    '.$sco_org.'
    '.$sco_title.'
    '.$sco_resource;
    $smarty->assign ( 'notas', $notas );

    // Mostrar los parámetros elegidos
    // FIXME: Estoy seguro de que esto no es PARA NADA SEGURO
    $smarty->assign ( 'params', $_POST_ok );

    $set_preguntas = json_decode ( $_POST_ok['preguntas'], true );

    $smarty->assign ( 'preguntas', $set_preguntas );

    $smarty->assign ( 'estado_pagina', 10 );

    $smarty->display( 'cabecera.tpl' );

    $smarty->display( 'parametros.tpl' );

    $smarty->display( 'resultado.tpl' );

    $smarty->display( 'mostrar_preguntas.tpl' );

 } elseif ( !( stristr ( $_POST_ok["commit"], 'paso_1' ) === FALSE ) ) {
   // Si es del paso 1 "Introducir parámetros", ejecutamos el paso 2 "Definir preguntas"

   // Mostrar los parámetros elegidos
   // FIXME: Estoy seguro de que esto no es PARA NADA SEGURO
   $smarty->assign ( 'params', $_POST_ok );

   $smarty->assign ('estado_pagina', 2 );

   $smarty->display( 'cabecera.tpl' );

   $smarty->display( 'inicio_definir_preguntas.tpl' );
   $smarty->display( 'definir_preguntas.tpl' );
   $smarty->display( 'separador_definir_preguntas.tpl' );
   $smarty->display( 'parametros.tpl' );
   $smarty->display( 'fin_definir_preguntas.tpl' );
 } else {
   // Error: commit definido con un paso no reconocido
   $smarty->assign ('estado_pagina', 112 );

   $smarty->display( 'cabecera.tpl' );

   // No hace falta definir la plantilla de error, porque cabecera.tpl detecta el estado de página anómalo
   // TODO: Mostrar un mensaje de error con algo de sentido
 }
} else {
    // Mostrar formulario con parámetros
    $smarty->assign ( 'params', $default_params );

    $smarty->assign ('estado_pagina', 1 );

    $smarty->display( 'cabecera.tpl' );

    $smarty->display( 'formulario.tpl' );
}

$smarty->display('pie.tpl');
