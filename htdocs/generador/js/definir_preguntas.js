'use strict';

// Visto en http://stackoverflow.com/a/14044646
var idCounter = 0;
var _uniqueId = function(prefix) {
  var id = '' + ++idCounter;
  return prefix ? prefix + id : id;
};


$(function() {
  $( 'ul.droptrue' ).sortable({
    connectWith: 'ul'
  });

  $( 'ul.dropfalse' ).sortable({
    connectWith: 'ul',
    dropOnEmpty: false
  });

  $( '.tab-sortable' ).disableSelection();

  $( '.question-tab-title' )
    .draggable( {disabled:true} )
    .selectable( {disabled:true} )
    .sortable( {disabled:true} )
    .droppable( {disabled:true} );

  $('body').on('hidden.bs.modal', '#myModal', function(){
    console.log("Modal oculto");
    $('#myModal').remove();
    console.log("Modal eliminado");
  });

  $( '.tab-sortable' ).on('click', '.glyphicon-pencil', function(){
//    alert('Edit: "'+$(this).prev().html()+'" !');
      console.log ('Editando: #'+$(this).prev().attr('id'));

/*
      $('body').append(
      '<div class="modal fade" id="myModal" role="dialog"> <div class="modal-dialog"> <!-- Modal content--> <div class="modal-content"> <div class="modal-header"> <span>Cambie el texto del elemento</span> <button type="button" class="close" data-dismiss="modal">&times;</button> </div> <div class="modal-body"> <form role="form"> <div class="form-group"> <input type="text" class="form-control" id="_text" value="'+$(this).prev().html()+'"/></div> <button type="button" class="btn btn-default btn-success" onclick="$(this).prev().html(\''+$('#_text').val()+'\');return false;"><span class="glyphicon glyphicon-ok"> </span> Aceptar</button> <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button> </form> </div> </div> </div> </div>');
*/
      $('body').append(
      '<div class="modal fade" id="myModal" role="dialog"> <div class="modal-dialog"> <!-- Modal content--> <div class="modal-content"> <div class="modal-header"> <span>Cambie el texto del elemento</span> <button type="button" class="close" data-dismiss="modal">&times;</button> </div> <div class="modal-body"> <form role="form"> <div class="form-group"> <input type="text" class="form-control" id="_text" value="'+$(this).prev().html()+'"/></div> <button type="button" class="btn btn-default btn-success" onclick="$(\'#'+$(this).prev().attr('id')+'\').html($(\'#_text\').val());$(\'#myModal\').remove();console.log (\'Modal eliminado\');return false;"><span class="glyphicon glyphicon-ok"> </span> Aceptar</button> <button type="button" class="btn btn-default btn-default pull-left" data-dismiss="modal" onclick="$(\'#myModal\').remove();console.log (\'Modal eliminado\');return false;"><span class="glyphicon glyphicon-remove"></span> Cancel</button> </form> </div> </div> </div> </div>');

      $("#myModal").modal();

      console.log ('Modal ejecutado');
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
  });

  $( '.tab-sortable' ).on('click','.question-item-title .glyphicon-remove',function(){
      console.log ('Eliminando: #'+$(this).prev().prev().attr('id'));
      $(this).parent().remove();
      console.log ('...Eliminado');
  });

  $( '.tab-sortable' ).on('click','.question-tab-title .glyphicon-remove',function(){
      console.log ('Eliminando: #'+$(this).prev().prev().attr('id'));
      $(this).parent().parent().remove();
      console.log ('...Eliminado');
  });

  $( '.tab-sortable' ).on('click','.question-tab-title .glyphicon-plus',function(){
    console.log ('Añadiendo #'+_id+'a #'+$(this).next().attr('id'));
    var _id = _uniqueId('_auto_');
    console.log ('Añadiendo #'+_id+'a #'+$(this).next().attr('id'));
    $(this).parent().after('<li class="ui-state-default question-item-title"> <span class="glyphicon glyphicon-move"></span> <span class="question-item-text" id="'+_id+'">Nueva pregunta</span> <span class="glyphicon glyphicon-pencil"></span> <span class="glyphicon glyphicon-remove"></span> </li>');
  });


});

/*

$('#sortable1 .question-tab-text').each(function( index ) {
  console.log( index + ": " + $( this ).text() );
});
$('#sortable1 .question-item-text').each(function( index ) {
  console.log( index + ": " + $( this ).text() );
});

*/
