window.Workwiki = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var wordsPojos = JSON.parse($('#bootstrapped-words').html())

    Workwiki.$rootEl = $('.container')
    Workwiki.Words = new Workwiki.Collections.Words(wordsPojos, {parse: true});
    new Workwiki.Routers.Words({
       $rootEl: $('.container')
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  // Workwiki.initialize();
});
