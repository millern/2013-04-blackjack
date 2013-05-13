class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @stood = false
    @gameEnded= false
  dealerPlay: ->
    @.at(0).flip() if !@.at(0).get 'revealed'
    @hit() & @dealerPlay() if @dealerScore() < 16
  hit: -> @add(@deck.pop()).last() if !@stood
  stand: ->
    @trigger 'stood'
    console.log(@stood);
    @stood = true
  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1 & card.get('revealed')
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
  dealerScore: ->
    if _.max(@scores()) <= 21
     _.max(@scores())
    else
     _.min(@scores())
