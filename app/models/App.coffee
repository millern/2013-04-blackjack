#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @startGame()
    @set 'scoreboard', scoreboard = new Scoreboard()

  startGame: ->
    @set 'gameInProgress', true
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @setTimeouts()
    @get('playerHand').on 'stood', =>
      @get('dealerHand').dealerPlay()
      @set 'gameInProgress', false
    @get('playerHand').on 'doubleDown', =>
      console.log "doubledown"
    @get('dealerHand').on 'tallyScoreTime', =>
      console.log "tallyscoretime"
      @tallyScore()
    @get('playerHand').on 'tallyScoreTime', =>
      console.log "tallyscoretime"
      @tallyScore()
      @set 'gameInProgress', false
    @trigger 'renderNewGame'
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
  setTimeouts: ->
    setTimeout((=>
      @get('playerHand').at(0).flip()),
    300)
    setTimeout((=>
      @get('playerHand').at(1).flip()),
    600)
    setTimeout((=>
      @get('dealerHand').at(1).flip()),
    900)