<?php

/*** Constantes ***/

// Versión del script generador
$script_version = '0.1.1';

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

//%%NAME%% => Id del nombre del paquete (?)
$sco_name = "ENCUESTA-$script_version-".uniqid();

//%%ORGANIZATION%% => Id de Organizacion del SCORM
$sco_org = "ORG-ENCUESTA-$script_version-".uniqid();

//%%TITLE_ID%% => Id del elemento t�tulo
$sco_title = "TIT-ENCUESTA-$script_version-".uniqid();

//%%RES_ID%% = Id del recurso 'formulario'
$sco_resource = "RES-ENCUESTA-$script_version-".uniqid();

//%%TARGET%% => Cadena con una denominaci�n simple del cuestionario; se usa tambi�n como nombre del archivo .php y como nombre de la tabla
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
$db_name = 'encuestas';

//%%DB_TABLE%%
$db_table = $target;

//%%BD_PORT%%
$db_port = 3306;

// Parejas de reemplazo en los archivos
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

/*** Inicializaci�n de Smarty ***/
require_once('smarty/smarty_connect.php');
$smarty = new smarty_connect();

$smarty->display( 'cabecera.tpl' );

if ( isset ( $_POST["commit"] ) AND !( stristr ( $_POST["commit"], 'TRUE' ) === FALSE ) ) {
    // * Mostrar los par�metros elegidos
    $smarty->assign ( 'params', $_POST );
    $smarty->display( 'parametros.tpl' );

    if (! file_put_contents ( 'generados/'.$_POST['target'].'_table.sql', $smarty->fetch( 'create_table.tpl' ) ) ) {
        $notas .= "ERROR: No se ha creado el archivo ".$_POST['target']."_table.sql
        ";
    }

    if (! file_put_contents ( 'generados/'.$_POST['target'].'_user.sql', $smarty->fetch( 'create_user.tpl' ) ) ) {
        $notas .= "ERROR: No se ha creado el archivo ".$_POST['target']."_user.sql
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
        '%%TARGET%%' => $_POST['target'],
        '%%TARGET_URL%%' => $_POST['target_url'],
        '%%COMMENT%%' => $_POST['comment'],
        '%%DB_HOST%%' => $_POST['db_host'],
        '%%DB_USER%%' => $_POST['db_user'],
        '%%DB_PASS%%' => $_POST['db_pass'],
        '%%DB_NAME%%' => $_POST['db_name'],
        '%%DB_TABLE%%' => $_POST['db_table'],
        '%%BD_PORT%%' => $_POST['db_port']
    );
    $php_connect = strtr ( file_get_contents ( $php_template ), $replace_pairs );

    if (! file_put_contents ( 'generados/'.$_POST['target'].'.php', $php_connect ) ) {
        $smarty->assign ( 'php_connect_file', "<span style='color:red;'>ERROR: No se ha creado el archivo ".$_POST['target'].".phps</span><br/>" );
    } else {
        $smarty->assign ( 'php_connect_file', '<a href="generados/'.$_POST['target'].'.php">Enlace: '.$_POST['target'].'.php</a>' );
    }

    // ** SCORM (realmente es un archivo .zip ...) **
    $fichero_zip = new ZipArchive;
    $error_ZIP = $fichero_zip->open ( 'generados/'.$_POST['target'].'.zip', ZipArchive::CREATE );
    if ( $error_ZIP === TRUE) {

        $fichero_zip->addFile('fuentes/scorm/adlcp_rootv1p2.xsd', 'adlcp_rootv1p2.xsd' );
        $fichero_zip->addFile('fuentes/scorm/ims_xml.xsd', 'ims_xml.xsd' );
        $fichero_zip->addFile('fuentes/scorm/imscp_v1p1.xsd', 'imscp_v1p1.xsd' );
        $fichero_zip->addFile('fuentes/scorm/imsmd_v1p2p2.xsd', 'imsmd_v1p2p2.xsd' );

        $fichero_zip->addFromString ( $html_scorm, strtr ( file_get_contents ( 'fuentes/scorm/'.$html_scorm ), $replace_pairs ) );
        $fichero_zip->addFromString ( $xml_scorm, strtr ( file_get_contents ( 'fuentes/scorm/'.$xml_scorm ), $replace_pairs ) );

        $fichero_zip->close();

        $smarty->assign( 'scorm_file', '<a href="generados/'.$_POST['target'].'.zip">Enlace: '.$_POST['target'].'.zip</a>' );
    } else {
        $smarty->assign( 'scorm_file', "<span style='color:red;'>ERROR: No se ha creado el archivo .zip: $error_ZIP</span><br/>" );
    }
    $notas .= $sco_name.'
    '.$sco_org.'
    '.$sco_title.'
    '.$sco_resource;
    $smarty->assign ( 'notas', $notas );

    $smarty->display( 'resultado.tpl' );

} else {
    // Mostrar formulario con par�metros
    $smarty->assign ( 'params', $default_params );
    $smarty->display( 'formulario.tpl' );
}

$smarty->display('pie.tpl');
