Workwiki.Views.WordsIndex = Backbone.View.extend({

  events: {
    "click .createWord": "createWord"
  },

  initialize: function () {
    var that = this;
    that.listenTo(that.collection, "add", that.render);
  },

  template: JST['words/index'],

  render: function () {
    var that = this;
    var renderedContent = that.template({
      words: that.collection
    });

    that.$el.html(renderedContent);

    return that;
  },

  createWord: function(event) {
    event.preventDefault();
    var that = this;

    var newWord = $('#word_name').val();
    resp = that.collection.create({name: newWord});
  }
});
