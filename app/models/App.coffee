#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @startGame()
    @set 'scoreboard', scoreboard = new Scoreboard()
    @get('dealerHand').on 'tallyScoreTime', =>
      @tallyScore()
  startGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stood', =>
      console.log("stood triggered")
      @get('dealerHand').dealerPlay()
    @trigger 'startGame'
  tallyScore: ->
    playerScore = @get('playerHand').dealerScore()
    dealerScore = @get('dealerHand').dealerScore()
    if playerScore > 21
      @get('scoreboard').dealerWins()
    else if dealerScore > 21
      @get('scoreboard').playerWins()
    else if playerScore > dealerScore
      @get('scoreboard').playerWins()
    else if dealerScore > playerScore
      @get('scoreboard').dealerWins()
    else
      console.log("Ties are for losers")