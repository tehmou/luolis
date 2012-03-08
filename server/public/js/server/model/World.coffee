class World
  constructor: (width, height) ->
    console.log "World", "Creating"
    @width = width
    @height = height
    @reset()

  reset: ->
    @ships = []

define "luolis.game.model.World", World
