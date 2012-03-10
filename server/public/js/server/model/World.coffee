class World
  constructor: (width, height) ->
    console.log "World", "Creating"
    @width = width
    @height = height
    @reset()

  reset: ->
    @ships = []

  getShipForPlayer: (clientId) ->
    (ship for ship in @ships when ship.clientId == clientId)[0]

define "luolis.game.model.World", World
