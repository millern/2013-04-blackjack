#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @startGame()
    @set 'scoreboard', scoreboard = new Scoreboard()

  startGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'nick', "NICKSTRING"
    @get('dealerHand').on 'tallyScoreTime', =>
      console.log "tallyscoretime"
      @tallyScore()
    @get('playerHand').on 'stood', =>
      console.log("stood triggered")
      @get('dealerHand').dealerPlay()
    @trigger 'startGame'
  tallyScore: ->
    console.log "tallying score"
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