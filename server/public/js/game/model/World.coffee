class World
  constructor: (width, height) ->
    @width = width
    @height = height
    @reset()

  reset: ->
    @ships = []

define "luolis.game.model.World", World
