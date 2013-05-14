class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @stood = false
    @gameEnded= false
    @double = false
  dealerPlay: ->
    @.at(0).flip() if !@.at(0).get 'revealed'
    if @smartScore() < 16 then @hit() and @dealerPlay() else @trigger 'tallyScoreTime'
  hit: ->
    @add(@deck.pop()).last()
    @trigger "tallyScoreTime" if @smartScore() > 21 and !@double and !@isDealer
    return true
  stand: ->
    @trigger 'stood' if !@stood
    @stood = true
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1 and card.get('revealed')
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
  smartScore: ->
    if _.max(@scores()) <= 21
     _.max(@scores())
    else
     _.min(@scores())
  doubleDown: ->
    @double = true
    @hit()
    @trigger 'doubleDown'
    @trigger 'stood'