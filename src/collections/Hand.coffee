class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->



  hit: ->
    x = @deck.last()
    @add(@deck.pop())
    if @scores()[0] > 21 and not @isDealer
      @.trigger("bust")
      @bust = true
      @.trigger("playerLose")
    x

  stand: (playerhand) ->
    @.at(0).flip()
    @hit() while @scores()[0] <= 17
    if @scores()[0] > 21
      @.trigger("bust")
      @bust = true
      @.trigger("playerWin")
    #needs logic for dealer hand > player hand
    #passed in playAerhand fromAppView.coffee line 10
    else if @scores()[0] > playerhand.scores()[0]
      @.trigger("playerLose")
    else if @scores()[0] < playerhand.scores()[0]
      @.trigger("playerWin")
    else
      @.trigger("tie")

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]



