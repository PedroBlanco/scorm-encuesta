<?php

/*** encuesta_p.php

	Primera encuesta personalizada

	Almacena en la BD los datos en la encuesta apropiada.

	***/

header("Content-type: text/plain");

$host = "localhost";
$user = "encuesta_p";
$pass = "encuesta_p";
$db = "encuestas";
$table = "encuesta_p";
$port = 3306;
$debug = FALSE;

$respuesta = array();

//Este contador nos servirá para saber el número de preguntas
$n_respuesta = 0;

// Si la valoración no es un entero entre 1 y 10, tomamos 10 como valor por defecto ;)
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_0_0']) ) {
	if ( ($_POST['pregunta_0_0'] <= 10) && ($_POST['pregunta_0_0'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_0_0'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_0_1']) ) {
	if ( ($_POST['pregunta_0_1'] <= 10) && ($_POST['pregunta_0_1'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_0_1'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_0_2']) ) {
	if ( ($_POST['pregunta_0_2'] <= 10) && ($_POST['pregunta_0_2'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_0_2'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_1_0']) ) {
	if ( ($_POST['pregunta_1_0'] <= 10) && ($_POST['pregunta_1_0'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_1_0'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_1_1']) ) {
	if ( ($_POST['pregunta_1_1'] <= 10) && ($_POST['pregunta_1_1'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_1_1'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_1_2']) ) {
	if ( ($_POST['pregunta_1_2'] <= 10) && ($_POST['pregunta_1_2'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_1_2'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_2_0']) ) {
	if ( ($_POST['pregunta_2_0'] <= 10) && ($_POST['pregunta_2_0'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_2_0'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_2_1']) ) {
	if ( ($_POST['pregunta_2_1'] <= 10) && ($_POST['pregunta_2_1'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_2_1'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}
$n_respuesta++;
if ( ctype_digit ($_POST['pregunta_2_2']) ) {
	if ( ($_POST['pregunta_2_2'] <= 10) && ($_POST['pregunta_2_2'] >= 1) ) {
		$respuesta[$n_respuesta] = $_POST['pregunta_2_2'] + 0;
	} else {
		$respuesta[$n_respuesta] = 10;
	}
} else {
	$respuesta[$n_respuesta] = 10;
}


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

$sentencia_sql .= 'pregunta_0_0,';
$sentencia_sql .= 'pregunta_0_1,';
$sentencia_sql .= 'pregunta_0_2,';
$sentencia_sql .= 'pregunta_1_0,';
$sentencia_sql .= 'pregunta_1_1,';
$sentencia_sql .= 'pregunta_1_2,';
$sentencia_sql .= 'pregunta_2_0,';
$sentencia_sql .= 'pregunta_2_1,';
$sentencia_sql .= 'pregunta_2_2,';

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
$respuesta[1],
$respuesta[2],
$respuesta[3],
$respuesta[4],
$respuesta[5],
$respuesta[6],
$respuesta[7],
$respuesta[8],
$respuesta[9],
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
