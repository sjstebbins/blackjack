class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'bust', => @renderBust()
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.addClass("titleBars")
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]


  renderBust: ->
    @$el.append $('<div id="busted"></div>')
