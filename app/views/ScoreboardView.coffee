class window.ScoreboardView extends Backbone.View
  className: 'scoreboard'

  #todo: switch to mustache
  template: _.template '<div><p>Wins: <%= playerScore%></p><p>Losses: <%= dealerScore%></p></div>'

  initialize: ->
    @render()
    @.model.on 'change', => @render

  render: ->
    #@$el.children.detach()
    @$el.html @template @model

