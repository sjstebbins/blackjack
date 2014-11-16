class window.AppView extends Backbone.View
  template: _.template '
    <div id="chart"></div>
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="reset-button">New Deal</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  events:
    'click .hit-button': -> @hit();
    'click .stand-button': -> @stand();
    'click .reset-button': -> @reset();

  initialize: ->
    @model.get('playerHand').on 'playerLose', => @lose()
    @model.get('dealerHand').on 'playerWin', => @win()
    @model.get('dealerHand').on 'playerLose', => @lose()
    @model.get('dealerHand').on 'tie', => @tie()
    @render()
    @buttonclicks = true

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    # @$('.chart').html new GraphView(model: @model.get 'graph').el

  stand: ->
    if(@buttonclicks)
      @model.get('dealerHand').stand(@model.get('playerHand'))

  hit: ->
    if(@buttonclicks)
      @model.get('playerHand').hit()

  win: ->
    node = $('<span></span>').text("PLAYER WINS").addClass("outcome")
    @$el.append(node)
    @buttonclicks = false;
    @model.get('graph').updateWin()

  lose: ->
    node = $('<span></span>').text("PLAYER LOSES").addClass("outcome")
    @$el.append(node)
    @buttonclicks = false;

  tie: ->
    node = $('<span></span>').text("TIE GAME").addClass("outcome")
    @$el.append(node)
    @buttonclicks = false;

  reset: ->
    $('body').find('.blackjack').html('');
    new AppView(model: new App()).$el.appendTo '.blackjack'
