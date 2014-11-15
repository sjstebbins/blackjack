class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    (@$el.html @template @model.attributes).fadeIn(1000)
    @$el.addClass 'covered' unless @model.get 'revealed'

