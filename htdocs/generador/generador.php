<?php

/*** Declaración de valores por defecto ***/
require_once ( 'conf/config.php' );

/*** Inicialización de Smarty ***/
require_once('smarty/smarty_connect.php');
$smarty = new smarty_connect();


// TODO: Limpiar $_POST
$_POST_ok = $_POST;

// Si recibimos un commit, comprobamos de qué paso es
if ( isset ( $_POST_ok["commit"] ) ) {
  if ( !( stristr ( $_POST_ok["commit"], 'paso_2' ) === FALSE ) ) {
    // Si es del paso 2 "Definir preguntas", ejecutamos el paso final "Generar encuesta"

    // Extraemos las preguntas de $_POST_ok para empezar a trabajar con ellas
    $set_preguntas = json_decode ( $_POST_ok['preguntas'], true );

    $smarty->assign ( 'preguntas', $set_preguntas );

    $smarty->assign ( 'params', $_POST_ok );

    // Generamos: definición de la tabla de la BD que almacena las preguntas
    // FIXME: En un primer momento sólo tenemos preguntas de valoración 1-10, por lo que vamos a incluir siempre un campo de comentarios con título "Comentarios"
    $sql_table_file = $_POST_ok['target'].'_table.sql';
    if (! file_put_contents ( 'generados/'.$sql_table_file, $smarty->fetch( 'create_table.tpl' ) ) ) {
      $notas .= "ERROR: No se ha creado el archivo ".$sql_table_file."
      ";
      $smarty->assign ( 'sql_create_table', '<span style="color:red;">ERROR: No se ha creado el archivo generados/'.$sql_table_file.'</span><br/>' );
    } else {
      $smarty->assign ( 'sql_create_table', '<a target="_blank" href="generados/'.$sql_table_file.'">Enlace: '.$sql_table_file.'</a>' );
    }

    $sql_user_file = $_POST_ok['target'].'_user.sql';
    // Generamos: definición del usuario de acceso a la BD
    if (! file_put_contents ( 'generados/'.$sql_user_file, $smarty->fetch( 'create_user.tpl' ) ) ) {
      $notas .= "ERROR: No se ha creado el archivo ".$sql_user_file."
      ";
      $smarty->assign ( 'sql_create_user', '<span style="color:red;">ERROR: No se ha creado el archivo generados/'.$sql_user_file.'</span><br/>' );
    } else {
      $smarty->assign ( 'sql_create_user', '<a target="_blank" href="generados/'.$sql_user_file.'">Enlace: '.$sql_user_file.'</a>' );
    }


    // *** Generar los ficheros ***

    // A la vez que generamos los ficheros, insertamos su contenido en un array para mostrarlos en la página de resultados
    // Ficheros en el paquete SCORM
    $files_array = array ();
    // Ficheros en el paquete completo
    $package_files_array = array ();


    // Parejas de reemplazo en los archivos
    $replace_pairs = array (
        'AUTHOR' => AUTHOR,
        'VERSION' => SCO_VERSION,
        'GENERATOR_VERSION' => SCRIPT_VERSION,
        'NAME' => $sco_name,
        'ORGANIZATION' => $sco_org,
        'TITLE_ID' => $sco_title,
        'RES_ID' => $sco_resource,
        'TARGET' => $_POST_ok['target'],
        'TARGET_URL' => $_POST_ok['target_url'],
        'COMMENT' => $_POST_ok['comment'],
        'DB_HOST' => $_POST_ok['db_host'],
        'DB_USER' => $_POST_ok['db_user'],
        'DB_PASS' => $_POST_ok['db_pass'],
        'DB_NAME' => $_POST_ok['db_name'],
        'DB_TABLE' => $_POST_ok['db_table'],
        'BD_PORT' => $_POST_ok['db_port']
    );

    // Cargamos la tabla de valores en Smarty para combinarlos con las plantillas
    $smarty->assign ( 'dato', $replace_pairs );

    // ** PHP **
    $php_connect = $smarty->fetch ( 'scorm/serverside.tpl' );

    $nombre_php_connect = $_POST_ok['target'].'.phps';
    if (! file_put_contents ( 'generados/'.$nombre_php_connect, $php_connect ) ) {
        $smarty->assign ( 'php_connect_file', "<span style='color:red;'>ERROR: No se ha creado el archivo ".$nombre_php_connect."</span><br/>" );
    } else {
        $smarty->assign ( 'php_connect_file', '<a target="_blank" href="generados/'.$nombre_php_connect.'">Enlace: '.$nombre_php_connect.'</a>' );
        $smarty->assign ( 'php_connect_file_contents', $php_connect );
        $files_array['php'] = array ( $nombre_php_connect, $php_connect );
    }

    // ** SCORM (realmente es un archivo .zip ...) **
    $fichero_zip = new ZipArchive;
    $error_ZIP = $fichero_zip->open ( 'generados/'.$_POST_ok['target'].'.zip', ZipArchive::CREATE );
    if ( $error_ZIP === TRUE) {

      $files_array['scorm'] = array ();

      $fichero_zip->addFile('fuentes/scorm/ims_xml.xsd', 'ims_xml.xsd' );
      $files_array['scorm'][] = array ( 'ims_xml.xsd', file_get_contents ( 'fuentes/scorm/ims_xml.xsd' ), 'Archivo con esquema XML seg&uacute;n est&aacute;ndar SCORM', 0 );

      $fichero_zip->addFile('fuentes/scorm/adlcp_rootv1p2.xsd', 'adlcp_rootv1p2.xsd' );
      $files_array['scorm'][] = array ( 'adlcp_rootv1p2.xsd', file_get_contents ( 'fuentes/scorm/adlcp_rootv1p2.xsd' ), 'Archivo con esquema XML seg&uacute;n est&aacute;ndar SCORM', 0 );

      $fichero_zip->addFile('fuentes/scorm/imscp_v1p1.xsd', 'imscp_v1p1.xsd' );
      $files_array['scorm'][] = array ( 'imscp_v1p1.xsd', file_get_contents ( 'fuentes/scorm/imscp_v1p1.xsd' ), 'Archivo con esquema XML seg&uacute;n est&aacute;ndar SCORM', 0 );

      $fichero_zip->addFile('fuentes/scorm/imsmd_v1p2p2.xsd', 'imsmd_v1p2p2.xsd' );
      $files_array['scorm'][] = array ( 'imsmd_v1p2p2.xsd', file_get_contents ( 'fuentes/scorm/imsmd_v1p2p2.xsd' ), 'Archivo con esquema XML seg&uacute;n est&aacute;ndar SCORM', 0 );


      // Generamos el archivo XML_SCORM con los parámetros
      $xml_scorm_fetched_tpl = strtr ( file_get_contents ( 'fuentes/scorm/'.XML_SCORM ), $replace_pairs );
      $fichero_zip->addFromString ( XML_SCORM, $xml_scorm_fetched_tpl );
      $files_array['scorm'][] = array ( XML_SCORM, $xml_scorm_fetched_tpl, 'Archivo XML que configura el comportamiento y contenido del paquete, seg&uacute;n est&aacute;ndar SCORM', 1 );

      // Generamos el archivo HTML_SCORM (el formulario a mostrar) con los parámetros dados
      // Versión para previsualizar
      $smarty->assign( 'formulario_scorm_version', false );
      $formulario_web_preview = $smarty->fetch ( 'scorm/formulario.tpl');
      // Versión para incluir en el SCORM
      $smarty->assign( 'formulario_scorm_version', true );
      $formulario_fetched_tpl = $smarty->fetch ( 'scorm/formulario.tpl');
      $fichero_zip->addFromString ( HTML_SCORM, $formulario_fetched_tpl );
      $files_array['scorm'][] = array ( HTML_SCORM, $formulario_fetched_tpl, 'Archivo HTML con la encuesta', 2, $formulario_web_preview );

      $fichero_zip->close();

      $smarty->assign( 'scorm_file', '<a target="_blank" href="generados/'.$_POST_ok['target'].'.zip">Enlace: '.$_POST_ok['target'].'.zip</a>' );
    } else {
      $smarty->assign( 'scorm_file', "<span style='color:red;'>ERROR: No se ha creado el archivo .zip: $error_ZIP</span><br/>" );
    }

    $smarty->assign ( 'files_array', $files_array );


    // ** Paquete completo (un archivo .zip con todos los componentes necesarios, ver #23) **
    $nombre_paquete_completo = $_POST_ok['target'].'_completo.zip';
    $paquete_completo = new ZipArchive;
    $error_ZIP = $paquete_completo->open ( 'generados/'.$nombre_paquete_completo, ZipArchive::CREATE );
    if ( $error_ZIP === TRUE) {

      // Añadimos el paquete SCORM
      $paquete_completo->addFile('generados/'.$_POST_ok['target'].'.zip', $_POST_ok['target'].'.zip' );
      $package_files_array['scorm'] = array ( $_POST_ok['target'].'.zip', 'Archivo SCORM generado' );

      // Añadimos los archivos SQL
      $paquete_completo->addFile('generados/'.$sql_table_file, $sql_table_file );
      $package_files_array['sql_table'] = array ( $sql_table_file, 'Archivo SQL para crear la base de datos y la tabla' );
      $paquete_completo->addFile('generados/'.$sql_user_file, $sql_user_file );
      $package_files_array['sql_user'] = array ( $sql_user_file, 'Archivo SQL para crear el usuario' );

      // Añadimos el archivo receptor PHP
      $paquete_completo->addFile('generados/'.$nombre_php_connect, rtrim ( $nombre_php_connect, 's' ) );
      $package_files_array['php'] = array ( rtrim ( $nombre_php_connect, 's' ), 'Archivo receptor PHP' );

      // Incluimos instrucciones de instalación y uso

      $package_files_array['txt'] = array ( INSTRUCCIONES, 'Instrucciones de instalaci&oacute; y uso' );
      // Se invierte el orden de definición y asignación de esta sección para que aparezcan los valores correctos en la plantilla instrucciones.tpl
      $smarty->assign ( 'package_files_array', $package_files_array );
      $instrucciones_fetched_tpl = $smarty->fetch ( 'scorm/instrucciones.tpl');
      $paquete_completo->addFromString( INSTRUCCIONES, $instrucciones_fetched_tpl );
      // FIXME: Si en algún momento queremos previsualizar las instrucciones generadas en el interfaz web, vamos a tener que cambiar las variables referenciadas en la plantilla, puesto que ahora mismo utilizamos profusamente $package_files_array

      $paquete_completo->close();

      $smarty->assign( 'package_file', '<a target="_blank" href="generados/'.$nombre_paquete_completo.'">Enlace: '.$nombre_paquete_completo.'</a>' );
    } else {
      $smarty->assign( 'package_file', "<span style='color:red;'>ERROR: No se ha creado el paquete completo $nombre_paquete_completo : $error_ZIP</span><br/>" );
    }

    $smarty->assign ( 'package_files_array', $package_files_array );

    $notas .= $sco_name.'
    '.$sco_org.'
    '.$sco_title.'
    '.$sco_resource;

    $smarty->assign ( 'notas', $notas );

    // Mostrar los parámetros elegidos
    // FIXME: Estoy seguro de que esto no es PARA NADA SEGURO
    $smarty->assign ( 'estado_pagina', 10 );

    $smarty->display( 'cabecera.tpl' );

    $smarty->assign ( 'plantilla_mostrar_preguntas', $smarty->fetch( 'mostrar_preguntas.tpl' ) );

    $smarty->assign ( 'plantilla_parametros', $smarty->fetch( 'parametros.tpl' ) );

    $smarty->assign ( 'plantilla_resultado', $smarty->fetch( 'resultado.tpl' ) );

    $smarty->display ( 'plantilla_generar_paquete.tpl' );

 } elseif ( !( stristr ( $_POST_ok["commit"], 'paso_1' ) === FALSE ) ) {
   // Si es del paso 1 "Introducir parámetros", ejecutamos el paso 2 "Definir preguntas"

   // Mostrar los parámetros elegidos
   // FIXME: Estoy seguro de que esto no es PARA NADA SEGURO
   $smarty->assign ( 'params', $_POST_ok );

   $smarty->assign ('estado_pagina', 2 );

   $smarty->display( 'cabecera.tpl' );

   $smarty->assign ( 'plantilla_definir_preguntas', $smarty->fetch( 'definir_preguntas.tpl' ) );

   $smarty->assign ( 'plantilla_parametros', $smarty->fetch( 'parametros.tpl' ) );

   $smarty->display ( 'plantilla_definir_preguntas.tpl' );

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
