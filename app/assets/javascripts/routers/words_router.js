Workwiki.Routers.Words = Backbone.Router.extend({
  routes: {
    "": "index"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  index: function() {
    var that = this;

    var indexView = new Workwiki.Views.WordsIndex({
      collection: Workwiki.Words
    });

    that.$rootEl.html(indexView.render().$el);
  }
});
