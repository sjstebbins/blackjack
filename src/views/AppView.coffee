class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand(@model.get('playerHand'))
    'playerWin': -> @win()
    'playerLose': -> @lose()
    'tie': -> @tie()


  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  win: ->
    console.log("won")
    node = $('<span></span>').text("PLAYER WINS")
    @$el.prepend(node)
  lose: ->
    console.log("lost")
    node = $('<span></span>').text("PLAYER LOSES")
    @$el.prepend(node)
  tie: ->
    console.log("tie")
    node = $('<span></span>').text("TIE GAME")
    @$el.prepend(node)
