<?php

/*** Constantes ***/

// Versión del script generador
define ( 'SCRIPT_VERSION', '0.1.2');

// Plantilla del script php
//define ( 'PHP_TEMPLATE', 'fuentes/serverside.php' );

// Nombre del archivo .html incluido en el SCORM
define ( 'HTML_SCORM', 'formulario.html' );

// Nombre del archivo .xml incluido en el SCORM
define ( 'XML_SCORM', 'imsmanifest.xml' );

// Nombre del archivo de instrucciones incluido en el paquete completo
define ( 'INSTRUCCIONES', 'Instrucciones.md' );

//AUTHOR => Autor en el documento .html
define ( 'AUTHOR', 'Pedro Blanco Wasmer' );

//VERSION => Versión del paquete scorm generado
define ( 'SCO_VERSION', '0.9.9rc4' );

/*** Variables ***/
/** Valores por defecto **/

//NAME => Id del nombre del paquete (?)
$sco_name = 'ENCUESTA-'.SCRIPT_VERSION.'-'.uniqid();

//ORGANIZATION => Id de Organizacion del SCORM
$sco_org = 'ORG-ENCUESTA-'.SCRIPT_VERSION.'-'.uniqid();

//TITLE_ID => Id del elemento título
$sco_title = 'TIT-ENCUESTA-'.SCRIPT_VERSION.'-'.uniqid();

//RES_ID = Id del recurso 'formulario'
$sco_resource = 'RES-ENCUESTA-'.SCRIPT_VERSION.'-'.uniqid();

//TARGET => Cadena con una denominación simple del cuestionario; se usa también como nombre del archivo .php y como nombre de la tabla
$target = 'encuesta';

//TARGET_URL => Url donde se suben los archivos .php que conectarán con la BD
$target_url = 'http://localhost/encuesta-scorm';

//COMMENT => Comentario que aparece en el archivo .php y en el archivo .html con datos sobre el curso
$comment = 'Encuesta de prueba';

//DB_HOST
$db_host = 'localhost';

//DB_USER
$db_user = $target;

//DB_PASS
$db_pass = '';

//DB_NAME
$db_name = 'db_encuestas';

//DB_TABLE
$db_table = $target;

//BD_PORT
$db_port = 3306;

// Parejas de reemplazo por defecto en los archivos
$replace_pairs = array (
    'AUTHOR' => AUTHOR,
    'VERSION' => SCO_VERSION,
    'NAME' => $sco_name,
    'ORGANIZATION' => $sco_org,
    'TITLE_ID' => $sco_title,
    'RES_ID' => $sco_resource,
    'TARGET' => $target,
    'TARGET_URL' => $target_url,
    'COMMENT' => $comment,
    'DB_HOST' => $db_host,
    'DB_USER' => $db_user,
    'DB_PASS' => $db_pass,
    'DB_NAME' => $db_name,
    'DB_TABLE' => $db_table,
    'BD_PORT' => $db_port
);

// Parámetros por defecto en el formulario
$default_params = array (
    'target_url' => $target_url,
    'comment' => $comment,
    'db_host' => $db_host,
    'db_name' => $db_name,
    'db_port' => $db_port,
);

$notas = '';
