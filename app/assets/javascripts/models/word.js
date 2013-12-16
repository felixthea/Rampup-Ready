Workwiki.Models.Word = Backbone.Model.extend({

  urlRoot: '/words',

  parse: function (word) {
    var definitions = new Workwiki.Collections.Definitions(word.definitions);
    word.definitions = definitions
    return word;
  }
});
