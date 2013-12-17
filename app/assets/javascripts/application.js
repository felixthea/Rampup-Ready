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
  // Adding new words from the words#index page
  $('#new-word-form').on('ajax:success', function(event, data, xhr){
    event.preventDefault();
    $form = $(this);
    $('.words').append(data);
    $form[0].reset();
    flashNotice("Word Added");
  })

  // Deleting words from the words#index page (admin only)
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

  // Adding definitions from words#show
  $('#new-def-form').on('ajax:success', function(event, data, xhr){
    event.preventDefault();
    $form = $(this);
    $('.definitions ol').append(data);
    $form[0].reset();
    flashNotice("Definition Added");
  })

  // Deleting definitions from words#show
  $('.definitions').on('click', '.delete-definition', function(event){
    event.preventDefault();
    var definitionId = $(event.target).attr("data-id");
    $.ajax({
      url: '/definitions/' + definitionId,
      type: 'DELETE',
      success: function(response){
        $('.definitions #' + definitionId).remove();
        flashNotice("Definition Deleted")
      },
      error: function() {
        console.log("Error")
      }
    })
  })

  // Favoriting a definition in words#show
  $('.definitions').on('click', '.mark-favorite', function(event){
    event.preventDefault();
    var definitionId = $(event.target).attr("data-id");

    $.ajax({
      url: '/definitions/' + definitionId + '/favorite',
      type: 'POST',
      success: function(response) {
        flashNotice("Definition Favorited");
        swapFavorite();
      },
      error: function(response) {
        flashNotice(response.responseText)
      }
    })
  })

  // Unfavoriting a definition in words#show
  $('.definitions').on('click', '.mark-unfavorite', function(event) {
    event.preventDefault();
    var definitionId = $(event.target).attr("data-id");

    $.ajax({
      url: '/definitions/' + definitionId + '/unfavorite',
      type: 'DELETE',
      success: function(response) {
        flashNotice("Definition Unfavorited");
        swapFavorite();
      },
      error: function(response) {
        flashNotice(response.responseText);
      }
    })
  });

  // Upvoting a definition in words#show
  $('.definitions').on('click', '.upvote', function(event) {
    event.preventDefault();
    var definitionId = $(event.target).attr("data-id")

    $.ajax({
      url: '/definitions/' + definitionId + '/upvote',
      type: 'POST',
      success: function(response){
        flashNotice("Upvoted!");
        total = response.total;
        upvotes = response.upvotes;
        downvotes = response.downvotes;
        updateVoteCount(definitionId, total, upvotes, downvotes);
      },
      error: function(response){
        flashNotice(response.responseText);
      }
    })
  });

  // Downvoting definition in words#show
  $('.definitions').on('click', '.downvote', function(event){
    var definitionId = $(event.target).attr("data-id");

    $.ajax({
      url: '/definitions/' + definitionId + '/downvote',
      type: 'POST',
      success: function(response){
        flashNotice("Downvoted!");
        total = response.total;
        upvotes = response.upvotes;
        downvotes = response.downvotes;
        updateVoteCount(definitionId, total, upvotes, downvotes);
      },
      error: function(response){
        flashNotice(response.responseText);
      }
    })
  });

  // Helper function for showing notices/errors
  var flashNotice = function (message) {
    $('div.notices').empty();
    $('div.notices').removeClass('hidden');
    $('div.notices').append(message);
  }

  // Helper function for hiding/unhiding the favorite/unfavorite definition button
  var swapFavorite = function () {
    $('.mark-unfavorite').toggleClass('hidden');
    $('.mark-favorite').toggleClass('hidden');
  }

  var updateVoteCount = function (definitionId, total, upvotes, downvotes) {
    $('li#' + definitionId).find('li#total-score').html("Total: " + total);
    $('li#' + definitionId).find('li#sum-upvotes').html("Up: " + upvotes);
    $('li#' + definitionId).find('li#sum-downvotes').html("Down: " + downvotes);
  }
});