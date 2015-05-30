/* _jshint ignore: start */
'use strict';


// Visto en http://stackoverflow.com/a/14044646
var idCounter = 0;
var _uniqueId = function(prefix) {
  var id = '' + ++idCounter;
  return prefix ? prefix + id : id;
};

// Añadir pestaña
$('.add-question-tab').click(function(){
  var _id = _uniqueId('_auto_');
  var _id_2 = _uniqueId('sortable_auto_');

  var _new_tab = $('<div class="question-group-container col-md-3"><div class="ui-state-highlight question-tab"> <span class="glyphicon glyphicon-plus"></span><span class="glyphicon glyphicon-remove"></span><span class="glyphicon glyphicon-pencil"></span><span class="question-tab-title">&nbsp;Pesta&ntilde;a&nbsp;<br/></span> <span class="question-tab-text text-edit" id="'+_id+'">Nueva pesta&ntilde;a</span></div><ul id="'+_id_2+'" class="tab-sortable droptrue"></ul>');

  $(this).next().before(_new_tab);

  _new_tab.find('ul.droptrue').sortable({
    connectWith: 'ul',
    dropOnEmpty: false
  });

  _new_tab.find('ul.dropfalse').sortable({
    connectWith: 'ul'
  });

  _new_tab.find('.glyphicon-plus').click();

});

// Construir el conjunto de pestañas y preguntas a enviar con el formulario
$('#submit').click(function(){
  var _tab = [];
  var _j = 0; // iterador sobre tab

  $('.question-group-container').each(function() {

    var _k = 0; // iterador sobre item (solo preguntas, no titulos de pestañas)

    _tab[_j] = {
      'id': '',
      'title': '',
      'items': {}
    };

    $(this).find('span.text-edit').each(function(){

      if( $(this).hasClass('question-tab-text')) {

        _tab[_j].id = $( this ).attr('id');
        _tab[_j].title = $( this ).html();
        console.log( 'Tab: '+$( this ).parent().next().attr('id')+'#' + _tab[_j].id + ' > '+ _tab[_j].title );

      } else if ($(this).hasClass('question-item-text')) {

        console.log( 'Item: '+$(this).parent().parent().attr('id')+'#' + $( this ).attr('id') + ' > ' + $( this ).html() );
        _tab[_j].items[_k] = $( this ).html();
        _k++;

      }
    });
    _j++;
  });

  $('#preguntas').val(JSON.stringify ( _tab ));
});

// Vuelva a atrás
$('#go-back').click(function(){
  history.go(-1);
});

$(function() {
  // Configuración de droppable
  $( 'ul.droptrue' ).sortable({
    connectWith: 'ul'
  });
  $( 'ul.dropfalse' ).sortable({
    connectWith: 'ul',
    dropOnEmpty: false
  });

  //$( '.tab-sortable' ).disableSelection();


  // $( '.question-tab' )
  //   .draggable( {disabled:true} )
  //   .sortable( {disabled:true} )
  //   .droppable( {disabled:true} )
  //   //.selectable( {disabled:true} )
  //   //FIXME: la línea anterior permite que el elemento se quede fijo, pero evita que sus botones reciban eventos...
  //   ;

  // $('body').on('hidden.bs.modal', '#myModal', function(){
  //   console.log("Modal oculto");
  //   $('#myModal').remove();
  //   console.log("Modal eliminado");
  // });

  // Editar pregunta
  $( '#question-tabs-container' ).on('click', '.question-group-container .tab-sortable .question-item .glyphicon-pencil', function(){
    console.log ('Editando Item: #'+$(this).next().next().attr('id'));

    var _itemHtml = $(this).next().next().html();
    var _editableText = $('<input type="text" required="required"/>');
    var _button_ok = $('<span class="glyphicon glyphicon-ok"></span>');
    var _button_cancel = $('<span class="glyphicon glyphicon-remove"></span>');
    var _form = $('<form class="inline-form" onsubmit="return false;"></form>');

    _editableText.val(_itemHtml);
    $(this).parent().parent().removeClass('tab-sortable').addClass('tab-sortable-disabled');
    $(this).parent().parent().selectable( {disabled:true} );
    $(this).parent().children().hide();
    $(this).next().next().after(_form);
    $(_form).append(_editableText);
    $(_form).append(_button_cancel);
    $(_form).append(_button_ok);
    //$(this).next().next().after(_editableText);
    // $(this).next().next().hide();
    _editableText.focus();

    _editableText.keypress(function(event){
      var _key = event.which || event.keyCode;

      // 13 es el código Unicode de la tecla Enter, según http://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_event_key_keycode
      if ( _key === 13 ) {
        var _html = $(this).val();
        console.log('_editableText.keypress(13): ' + _html);

        $(this).parent().prev().html(_html);
        // $(this).parent().prev().show();
        $(this).parent().parent().children().show();
        $(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
        $(this).parent().parent().parent().selectable( {disabled:false} );
        $(this).parent().remove();
      }
    });

    _editableText.blur(function(){
      var _html = $(this).val();
      console.log('_editableText.blur: ' + _html);

      $(this).parent().prev().html(_html);
      // $(this).parent().prev().show();
      $(this).parent().parent().children().show();
      $(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      $(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });

    _button_ok.click(function(){
      var _html = $(this).prev().prev().val();

      console.log ('Ok: '+_html);

      $(this).parent().prev().html(_html);
      $(this).parent().parent().children().show();
      // $(this).parent().prev().show();
      $(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      $(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });

    _button_cancel.click(function(){
      var _html = $(this).prev().val();

      console.log ('Cancel: '+_html);

      // $(this).parent().prev().show();
      $(this).parent().parent().children().show();
      $(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      $(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });
  });

  // Eliminar pregunta
  $( '#question-tabs-container' ).on('click', '.question-group-container .tab-sortable .question-item .glyphicon-remove', function(){
    console.log ('Eliminando: #'+$(this).next().next().next().attr('id'));
    $(this).parent().remove();
    console.log ('...Eliminado');
  });

  // Eliminar pestaña
  $( '#question-tabs-container' ).on('click', '.question-group-container .question-tab .glyphicon-remove', function(){
    console.log ('Eliminando: #'+$(this).next().next().next().attr('id'));
    $(this).parent().parent().remove();
    console.log ('...Eliminado');
  });

  // Añadir pregunta
  $( '#question-tabs-container' ).on('click', '.question-group-container .question-tab .glyphicon-plus', function(){
    console.log ('Añadiendo pregunta a: #'+$(this).next().next().next().next().attr('id'));

    var _id = _uniqueId('_auto_');

    $(this).parent().next().append(' <li class="ui-state-default question-item"> <span class="glyphicon glyphicon-move"></span> <span class="glyphicon glyphicon-remove"></span> <span class="glyphicon glyphicon-pencil"></span> <span class="question-item-title">&nbsp;Pregunta&nbsp;<br/></span> <span class="question-item-text text-edit" id="'+_id+'">Nueva pregunta</span> </li>');

    console.log ('... pregunta añadida');
  });

  // Editar pestaña
  $( '#question-tabs-container' ).on('click', '.question-group-container .question-tab .glyphicon-pencil', function(){
    console.log ('Editando Item: #'+$(this).next().next().attr('id'));

    var _itemHtml = $(this).next().next().html();
    var _editableText = $('<input type="text" required="required"/>');
    var _button_ok = $('<span class="glyphicon glyphicon-ok"></span>');
    var _button_cancel = $('<span class="glyphicon glyphicon-remove"></span>');
    var _form = $('<form class="inline-form" onsubmit="return false;"></form>');

    _editableText.val(_itemHtml);
    //$(this).parent().parent().removeClass('tab-sortable').addClass('tab-sortable-disabled');
    //$(this).parent().parent().selectable( {disabled:true} );
    $(this).parent().children().hide();
    $(this).next().next().after(_form);
    $(_form).append(_editableText);
    $(_form).append(_button_cancel);
    $(_form).append(_button_ok);
    //$(this).next().next().after(_editableText);
    // $(this).next().next().hide();
    _editableText.focus();

    _editableText.keypress(function(event){
      var _key = event.which || event.keyCode;

      // 13 es el código Unicode de la tecla Enter, según http://www.w3schools.com/jsref/tryit.asp?filename=tryjsref_event_key_keycode
      if ( _key === 13 ) {
        var _html = $(this).val();
        console.log('_editableText.keypress(13): ' + _html);

        $(this).parent().prev().html(_html);
        // $(this).parent().prev().show();
        $(this).parent().parent().children().show();
        // $(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
        // $(this).parent().parent().parent().selectable( {disabled:false} );
        $(this).parent().remove();
      }
    });

    _editableText.blur(function(){
      var _html = $(this).val();
      console.log('_editableText.blur: ' + _html);

      $(this).parent().prev().html(_html);
      // $(this).parent().prev().show();
      $(this).parent().parent().children().show();
      //$(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      //$(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });

    _button_ok.click(function(){
      var _html = $(this).prev().prev().val();

      console.log ('Ok: '+_html);

      $(this).parent().prev().html(_html);
      $(this).parent().parent().children().show();
      // $(this).parent().prev().show();
      //$(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      //$(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });

    _button_cancel.click(function(){
      var _html = $(this).prev().val();

      console.log ('Cancel: '+_html);

      // $(this).parent().prev().show();
      $(this).parent().parent().children().show();
      //$(this).parent().parent().parent().removeClass('tab-sortable-disabled').addClass('tab-sortable');
      //$(this).parent().parent().parent().selectable( {disabled:false} );
      $(this).parent().remove();
    });

  });

//  $( '.tab-sortable' ).on('click', '.glyphicon-pencil', function(){
//    alert('Edit: "'+$(this).prev().html()+'" !');
//      console.log ('Editando: #'+$(this).prev().prev().attr('id'));


//      $('body').append(
//      '<div class="modal fade" id="myModal" role="dialog"> <div class="modal-dialog"> <!-- Modal content--> <div class="modal-content"> <div class="modal-header"> <span>Cambie el texto del elemento</span> <button type="button" class="close" data-dismiss="modal">&times;</button> </div> <div class="modal-body"> <form role="form"> <div class="form-group"> <input type="text" class="form-control" id="_text" value="'+$(this).prev().html()+'"/></div> <button type="button" class="btn btn-default btn-success" onclick="$(this).prev().html(\''+$('#_text').val()+'\');return false;"><span class="glyphicon glyphicon-ok"> </span> Aceptar</button> <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button> </form> </div> </div> </div> </div>');

//      $('body').append(
//      '<div class="modal fade" id="myModal" role="dialog"> <div class="modal-dialog"> <!-- Modal content--> <div class="modal-content"> <div class="modal-header"> <span>Cambie el texto del elemento</span> <button type="button" class="close" data-dismiss="modal">&times;</button> </div> <div class="modal-body"> <form role="form"> <div class="form-group"> <input type="text" class="form-control" id="_text" value="'+$(this).prev().html()+'"/></div> <button type="button" class="btn btn-default btn-success" onclick="$(\'#'+$(this).prev().attr('id')+'\').html($(\'#_text\').val());$(\'#myModal\').remove();console.log (\'Modal eliminado\');return false;"><span class="glyphicon glyphicon-ok"> </span> Aceptar</button> <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal" onclick="$(\'#myModal\').remove();console.log (\'Modal eliminado\');return false;"><span class="glyphicon glyphicon-remove"></span> Cancel</button> </form> </div> </div> </div> </div>');

//      $("#myModal").modal();

//      console.log ('Modal ejecutado');
/*
      $('#myModal').on('hidden', function(){
   		   console.log("Modal hidden");
    	   $('#myModal').remove();
      });*/

    /*
    $('body').append(
'<div id="myModal" class="custom-modal modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">'+
'<div class="modal-header">'+
'<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>'+
'</div><div class="modal-body">Editando: "'+$(this).prev().html()+'"</div>'+
'<div class="modal-footer"><button class="btn" data-dismiss="modal">Cerrar</button></div></div>'
    );
    // $(this).find($('h3')).clone().appendTo('.custom-modal .modal-header');
    // $(this).find('.device-product, .device-details').clone().appendTo('.custom-modal .modal-body');
    $('.custom-modal .hide').show();
    $('.custom-modal').modal();

  	$('.custom-modal').on('hidden', function(){
 		   console.log("Modal hidden");
    	$('.custom-modal').remove();
	   });
*/
//  });
/*
  $( '.tab-sortable' ).on('click','.question-item-title .glyphicon-remove',function(){
      console.log ('Eliminando item: #'+$(this).prev().prev().attr('id'));
      $(this).parent().remove();
      console.log ('...Eliminado');
  });
*/
/*
  $( '.tab-sortable' ).on('click','.question-tab-title .glyphicon-remove',function(){
      console.log ('Eliminando tab: #'+$(this).prev().prev().attr('id'));
      $(this).parent().parent().remove();
      console.log ('...Eliminado');
  });
*/
/*
  $( '.tab-sortable' ).on('click','.question-tab-title .glyphicon-plus',function(){
    console.log ('Añadiendo #'+_id+'a #'+$(this).next().attr('id'));
    var _id = _uniqueId('_auto_');
    console.log ('Añadiendo #'+_id+'a #'+$(this).next().attr('id'));
    $(this).parent().after('<li class="ui-state-default question-item-title"> <span class="glyphicon glyphicon-move"></span> <span class="question-item-text" id="'+_id+'">Nueva pregunta</span> <span class="glyphicon glyphicon-pencil"></span> <span class="glyphicon glyphicon-remove"></span> </li>');
  });
*/

});

/*

$('#sortable1 .question-tab-text').each(function( index ) {
  console.log( index + ": " + $( this ).text() );
});
$('#sortable1 .question-item-text').each(function( index ) {
  console.log( index + ": " + $( this ).text() );
});

*/
