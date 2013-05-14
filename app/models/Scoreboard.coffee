class window.Scoreboard extends Backbone.Model

  initialize: ->
    @dealerScore = 0
    @playerScore = 0
    @dealerMoney = 0
    @playerMoney = 0
  dealerWins: ->
    ++@dealerScore
    console.log('dealer',@dealerScore)
  playerWins: ->
    ++@playerScore
    console.log('player',@playerScore)