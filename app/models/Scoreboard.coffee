class window.Scoreboard extends Backbone.Model

  initialize: ->
    @set 'dealerScore', 0
    @set 'playerScore', 0
    @set 'playerMoney', 1000
    @set 'currentBet', 10
  dealerWins: ->
    @set 'dealerScore', (@get 'dealerScore') + 1
    @set 'playerMoney', (@get 'playerMoney') - (@get 'currentBet')
    @trigger "changeevent"
  playerWins: ->
    @set 'playerScore', (@get 'playerScore') + 1
    @set 'playerMoney', (@get 'playerMoney') + (@get 'currentBet')
    @trigger "changeevent"

  changeBet: (value) ->
    @set 'currentBet', +value
    console.log @get 'currentBet'