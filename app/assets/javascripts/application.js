// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require backbone
//= require workwiki
//= require_tree ../templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers
//= require_tree .
//= require jquery.serializeJSON.js

$(document).ready(function(){
  // Adding new words from the words index page
  $('#new-word-form').on('ajax:success', function(event, data, xhr){
    event.preventDefault();
    $form = $(this);
    $('.words').append(data);
    $form[0].reset();
    flashNotice("Word Added");
  })

  // Deleting words from the words index page (admin only)
  $('.words-list').on('click', 'button', function(event){
    event.preventDefault();
    $wordId = $(event.target).attr("data-id")
    $.ajax({
      url: '/words/' + $wordId,
      type: 'DELETE',
      success: function(response){
        $('.words').find('#' + $wordId).remove();
        flashNotice("Word Deleted");
      }
    })
  })

  $('#new-def-form').on('ajax:success', function(event, data, xhr){
    console.log("in here")
    event.preventDefault();
    $form = $(this);
    $('.definitions ol').append(data);
    $form[0].reset();
    flashNotice("Definition Added");
  })

  // Helper function for showing notices/errors

  var flashNotice = function (message) {
    $('div.notices').empty();
    $('div.notices').removeClass('hidden');
    $('div.notices').append(message);
  }
});