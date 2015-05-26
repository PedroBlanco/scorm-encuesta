'use strict';

$(function() {
  $( 'ul.droptrue' ).sortable({
    connectWith: 'ul'
  });

  $( 'ul.dropfalse' ).sortable({
    connectWith: 'ul',
    dropOnEmpty: false
  });

  $( '.tab-sortable' ).disableSelection();
});
