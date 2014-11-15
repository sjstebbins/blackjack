class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img class="show-<%= revealed %>" src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    (@$el.html @template @model.attributes).fadeIn(1000)
    @$el.addClass 'covered' unless @model.get 'revealed'

