<?php

/*** {$dato['TARGET']}.php

	{$dato['COMMENT']}

	Almacena en la BD los datos en la encuesta apropiada.

	***/

header("Content-type: text/plain");

$host = "{$dato['DB_HOST']}";
$user = "{$dato['DB_USER']}";
$pass = "{$dato['DB_PASS']}";
$db = "{$dato['DB_NAME']}";
$table = "{$dato['DB_TABLE']}";
$port = {$dato['BD_PORT']};
$debug = FALSE;

$respuesta = array();

//Este contador nos servirá para saber el número de preguntas
$n_respuesta = 0;

// Si la valoración no es un entero entre 1 y 10, tomamos 10 como valor por defecto ;)
{foreach from=$preguntas item=_set key=_tab name=outer}
{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_{$_tab}_{$_id}']) ) {
	if ( ($_POST['pregunta_{$_tab}_{$_id}'] <= 10) && ($_POST['pregunta_{$_tab}_{$_id}'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_{$_tab}_{$_id}'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
{/foreach}
{/foreach}


$mysqli = new mysqli( $host, $user, $pass, $db, $port);

if ($mysqli->connect_errno) {
    print ( "Error(1): Ha habido un problema con la encuesta. Avise al coordinador de la actividad." );
	if ( $debug ) {
		echo "Fallo en la conexi&oacute;n a MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
	}
}

if ( strlen ( $_POST['comentario'] ) == 0 ) {
	$comentario = '';
} else {
	$comentario = htmlentities ( $_POST['comentario'], ENT_QUOTES | ENT_SUBSTITUTE | ENT_XHTML );
	// Prefiero codificar las comillas como entidades html en vez de escaparlas
	//$comentario = $mysqli->real_escape_string ( $_POST['comentario'] );
}


$sentencia_sql = "INSERT INTO `".$table."` (";
$sentencia_sql_aux = '';
$val_prep_sql = '';

for ( $_i = 1; $_i <= $n_respuesta; $_i++ ) {
	$val_prep_sql .= 'i';
	$sentencia_sql_aux .= '?,';
}
$val_prep_sql .= 's';

{foreach from=$preguntas item=_set key=_tab name=outer}
{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
$sentencia_sql .= 'pregunta_{$_tab}_{$_id},';
{/foreach}
{/foreach}

$sentencia_sql = $sentencia_sql . 'comentario) VALUES (' . $sentencia_sql_aux . '?)';

/* Prepared statement, stage 1: prepare */
if (!($stmt = $mysqli->prepare($sentencia_sql))) {
     print ( "Error(2): Ha habido un problema con la encuesta. Avise al coordinador de la actividad." );
	if ( $debug ) {
		echo "Fallo al preparar: (" . $mysqli->errno . ")\n" . $mysqli->error.'\nConsulta: '.$sentencia_sql;
	}
}

/* Prepared statement, stage 2: bind and execute */
if (!$stmt->bind_param($val_prep_sql,
{assign var=_n_temp value=1}
{foreach from=$preguntas item=_set key=_tab name=outer}
{foreach from=$_set['items'] key=_id item=_pregunta name=inner}
$respuesta[{$_n_temp}],
{$_n_temp=$_n_temp+1}
{/foreach}
{/foreach}
$comentario )) {
    print ( "Error(3): Ha habido un problema con la encuesta. Avise al coordinador de la actividad." );
	if ( $debug ) {
		echo "Fallo al vincular: (" . $stmt->errno . ") " . $stmt->error;
	}
}

if (!$stmt->execute()) {
    print ( "Error(4): Ha habido un problema con la encuesta. Avise al coordinador de la actividad." );
	if ( $debug ) {
		echo "Fallo al ejecutar: (" . $stmt->errno . ") " . $stmt->error;
	}
} else {
	print ( "Gracias por realizar la encuesta. Ya puede salir de la actividad." );
}

/* explicit close recommended */
$stmt->close();
