'use strict';

//console.debug ('Main executed');

var mensaje_no_localStorage ='Local storage: no soportado por su navegador.Por favor, deshabilite "Modo Privado", o actualícese a un navegador más moderno.';

$('#guardar_config').click(guardar_configuracion);
$('#recargar_config').click(recargar_configuracion);
$('#borrar_config').click(borrar_configuracion);
$('#clean').click(limpiar_formulario);

// FIXME: Definir unos valores sensatos por defecto comunes a generador.php y a main.js, p.e. ¿en un JSON externo?
var default_settings = {
  target: 'encuesta',
  target_url: 'http://localhost/encuesta-scorm',
  comment: 'Encuesta de prueba',
  db_host: 'localhost',
  db_port: '3306',
  db_user: 'encuesta',
  db_name: 'db_encuestas',
  db_table: 'encuesta'
};

storejs_init();

function storejs_init ()
{
  if (!store.enabled) {
    $('#local_storage_ok').hide();
    $('#local_storage_fail').show();

    // Mejor que un alert podemos usar un mensaje del propio bootstrap
    //alert( mensaje_no_localStorage );
    addAlert( mensaje_no_localStorage, 'danger' );

    console.error ( mensaje_no_localStorage );

    return;
  } else {
    $('#local_storage_ok').show();
    $('#local_storage_fail').hide();
    console.info ('localStorage soportado');
  }
  // store.remove('scorm_encuesta');
  var _settings = store.get('scorm_encuesta');

  if (_settings === undefined) {
    // Definimos los valores

    store.set('scorm_encuesta', default_settings);

    // FIXME: Se supone que en ciertos navegadores el localStorage parece estar activado, pero al utilizarlo da fallo, así que habría que comprobar que las siguiente operación se realiza
    _settings = store.get('scorm_encuesta');

    //alert ( 'New settings: '+JSON.stringify(_settings));
    console.debug ( 'Configuración nueva: ' + JSON.stringify(_settings) );
  } else {
    // alert ( 'Old/updated settings: '+JSON.stringify(_settings));
    console.debug ( 'Configuración cargada: ' + JSON.stringify(_settings) );
  }
  $('#target').val( (_settings.target         !== undefined)?_settings.target    :default_settings.target );
  $('#target_url').val( (_settings.target_url !== undefined)?_settings.target_url:default_settings.target_url );
  $('#comment').val( (_settings.comment       !== undefined)?_settings.comment   :default_settings.comment );
  $('#db_host').val( (_settings.db_host       !== undefined)?_settings.db_host   :default_settings.db_host );
  $('#db_port').val( (_settings.db_port       !== undefined)?_settings.db_port   :default_settings.db_port );
  $('#db_user').val( (_settings.db_user       !== undefined)?_settings.db_user   :default_settings.db_user);
  $('#db_name').val( (_settings.db_name       !== undefined)?_settings.db_name   :default_settings.db_name);
  $('#db_table').val( (_settings.db_table     !== undefined)?_settings.db_table  :default_settings.db_table);
}

function guardar_configuracion ()
{
  // Seguramente haya que hacer algún tipo de comprobación de los campos que vamos a guardar (longitud, tipo, ...), tal vez la misma validación que debemos hacer antes de generar un paquete
  var _resultado;

  if (!store.enabled) {
    addAlert( mensaje_no_localStorage, 'danger' );
    console.error (mensaje_no_localStorage);
    _resultado = false;
  } else {
    store.set('scorm_encuesta', {
      target:     ( ( $('#target').val !== '')    ? $('#target').val() : '' ),
      target_url: ( ( $('#target_url').val !== '')? $('#target_url').val() : '' ),
      comment:    ( ( $('#comment').val !== '')   ? $('#comment').val() : '' ),
      db_host:    ( ( $('#db_host').val !== '')   ? $('#db_host').val() : '' ),
      db_port:    ( ( $('#db_port').val !== '')   ? $('#db_port').val() : '' ),
      db_user:    ( ( $('#db_user').val !== '')   ? $('#db_user').val() : '' ),
      db_name:    ( ( $('#db_name').val !== '')   ? $('#db_name').val() : '' ),
      db_table:   ( ( $('#db_table').val !== '')  ? $('#db_table').val() : '' )
    });
    addAlert( 'Configuraci&oacute;n guardada', 'success');
    console.debug ( 'Configuración guardada: ' + JSON.stringify( store.get('scorm_encuesta') ) );
    _resultado = true;
  }
  return _resultado;
}

function recargar_configuracion ()
{
  var _resultado;

  if (!store.enabled) {
    addAlert (mensaje_no_localStorage, 'danger');
    console.error (mensaje_no_localStorage);
    _resultado = false;
  } else {
    var _settings = store.get('scorm_encuesta');

    if ( _settings === undefined ) {
      // Mostrar mensaje de error/warning diciendo que no hay configuración que cargar
      console.error (mensaje_no_localStorage);
      addAlert ('Error: No hay configuraci&oacute;n que cargar', 'danger');
      _resultado = false;
    } else {
      $('#target').val( (_settings.target         !== '')?_settings.target    : '');
      $('#target_url').val( (_settings.target_url !== '')?_settings.target_url: '');
      $('#comment').val( (_settings.comment       !== '')?_settings.comment   : '');
      $('#db_host').val( (_settings.db_host       !== '')?_settings.db_host   : '');
      $('#db_port').val( (_settings.db_port       !== '')?_settings.db_port   : '');
      $('#db_user').val( (_settings.db_user       !== '')?_settings.db_user   : '');
      $('#db_name').val( (_settings.db_name       !== '')?_settings.db_name   : '');
      $('#db_table').val( (_settings.db_table     !== '')?_settings.db_table  : '');
      addAlert ( 'Configuraci&oacute;n recargada', 'info');
      console.debug ( 'Configuración recargada: ' + JSON.stringify( _settings ) );
      _resultado = true;
    }
  }
  return _resultado;
}

function borrar_configuracion ()
{
  var _resultado;

  if (!store.enabled) {
    console.error (mensaje_no_localStorage);
    addAlert ('Error: No se ha borrado la configuraci&acute;n.', 'danger');
    _resultado = false;
  } else {
    store.remove('scorm_encuesta');
    console.debug ( 'Configuración eliminada de localStorage.' );
    addAlert ('Configuraci&oacute;n borrada.', 'info');
    _resultado = true;
  }
  return _resultado;
}

function limpiar_formulario ()
{
  $('#target').val( '' );
  $('#target_url').val( '' );
  $('#comment').val( '' );
  $('#db_host').val( '' );
  $('#db_port').val( '' );
  $('#db_user').val( '' );
  $('#db_pass').val( '' );
  $('#db_name').val( '' );
  $('#db_table').val( '' );
  console.info ('Formulario limpiado.');
  // No creo que haga falta decir que el formulario ha sido limpiado (se ve claramente)
  //addAlert ('Formulario limpiado.', 'info');
}

function addAlert ( _message,_class )
// Función tomada de stackoverflow
// Añade un mensaje _message de alerta (bootstrap) a un div en la cabecera
// Como tipo de alerta _class acepta: danger, info, success, warning
{
  $('#alerts').append(
    '<div class="alert alert-'+_class+'">' +
    '<a href="#" class="close" data-dismiss="alert" aria-label="close">'+
    '<span class="glyphicon glyphicon-remove"></span></a>'+_message + '</div>')
    .fadeTo(5000, 0)
    .slideUp(500, function(){
      $(this).remove();
    });
}

// Basado en http://jsfiddle.net/vralle/qX4Pt/
$.fn.ready(function() {
    // Spoiler
    $(document).on('click', '.spoiler-btn', function (e) {
        e.preventDefault();
        $(this).parent().children('.spoiler-body').collapse('toggle');
        var _swap = $(this).html();
        $(this).html($(this).attr('value'));
        $(this).attr('value', _swap);
    });
});
