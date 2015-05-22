'use strict';

console.debug ('Main executed');

storejs_init();

function storejs_init ()
{
  if (!store.enabled) {
    $('#local_storage_ok').hide();
    $('#local_storage_fail').show();

    alert('Local storage is not supported by your browser. Please disable "Private Mode", or upgrade to a modern browser.');

    return;
  } else {
    $('#local_storage_ok').show();
    $('#local_storage_fail').hide();
  }
  // store.remove('scorm_encuesta');
  var _settings = store.get('scorm_encuesta');

  if (_settings === undefined) {
    // Definimos los valores
    store.set('scorm_encuesta',{
      target: 'TARGET',
      target_url: 'http://example.com/encuestas',
      comment: 'COMMENT',
      db_host: 'example',
      db_port: '4000',
      db_user: 'USER',
      db_name: 'NAME',
      db_table: 'TABLE'
    });

    _settings = store.get('scorm_encuesta');

    alert ( 'New settings: '+JSON.stringify(_settings));
  } else {
    $('#target').val( (_settings.target !== undefined)?_settings.target:(_settings.target ='target') );
    $('#target_url').val( (_settings.target_url !== undefined)?_settings.target_url:(_settings.target_url ='http://google.es/') );
    $('#comment').val( (_settings.comment !== undefined)?_settings.comment:(_settings.comment ='live_comment') );
    $('#db_host').val( (_settings.db_host !== undefined)?_settings.db_host:(_settings.db_host ='host') );
    $('#db_port').val( (_settings.db_port !== undefined)?_settings.db_port:(_settings.db_port ='4000') );
    $('#db_user').val( (_settings.db_user !== undefined)?_settings.db_user:(_settings.db_user ='user') );
    $('#db_name').val( (_settings.db_name !== undefined)?_settings.db_name:(_settings.db_name ='name') );
    $('#db_table').val( (_settings.db_table !== undefined)?_settings.db_table:(_settings.db_table ='table') );
    alert ( 'Old/updated settings: '+JSON.stringify(_settings));
  }

  // Si _settings no tenía valores, hemos metido unos valores por defecto y podemos usarlos
  // Si _settings sí tenía valores, seguimos pudiendo usarlos ;)

  $('#target').val(_settings.target);
  $('#target_url').val(_settings.target_url);
  $('#comment').val(_settings.comment);
  $('#db_host').val(_settings.db_host);
  $('#db_port').val(_settings.db_port);
  $('#db_user').val(_settings.db_user);
  $('#db_name').val(_settings.db_name);
  $('#db_table').val(_settings.db_table);


/*
  if (_settings !== undefined) {
    $('#target').val(_settings.target);
    $('#target_url').val(_settings.target_url);
    $('#comment').val(_settings.comment);
    $('#db_host').val(_settings.db_host);
    $('#db_port').val(_settings.db_port);
    $('#db_user').val(_settings.db_user);
    $('#db_name').val(_settings.db_name);
    $('#db_table').val(_settings.db_table);
  } else {
    alert ('Settings: '+_settings);
  }
*/
/*
  if (_settings !== undefined) {
    $('#target').val( (_settings.target !== undefined)?_settings.target:(_settings.target ='target') );
    $('#target_url').val( (_settings.target_url !== undefined)?_settings.target_url:(_settings.target_url ='http://google.es/') );
    $('#comment').val( (_settings.comment !== undefined)?_settings.comment:(_settings.comment ='live_comment') );
    $('#db_host').val( (_settings.db_host !== undefined)?_settings.db_host:(_settings.db_host ='host') );
    $('#db_port').val( (_settings.db_port !== undefined)?_settings.db_port:(_settings.db_port ='4000') );
    $('#db_user').val( (_settings.db_user !== undefined)?_settings.db_user:(_settings.db_user ='user') );
    $('#db_name').val( (_settings.db_name !== undefined)?_settings.db_name:(_settings.db_name ='name') );
    $('#db_table').val( (_settings.db_table !== undefined)?_settings.db_table:(_settings.db_table ='table') );
  } else {
    alert ('Settings: '+_settings);
  }
*/

  //var user = store.get('user')
  // ... and so on ...

}
