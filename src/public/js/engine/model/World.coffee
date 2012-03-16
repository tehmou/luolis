class World
  constructor: (width, height) ->
    log "Creating"
    @width = width
    @height = height
    @reset()

  reset: ->
    @ships = []

  addShip: (ship) ->
    log "Adding a ship to the world"
    @ships.push ship

  addGround: (groundBodies) ->
    @groundBodies = groundBodies

  getShipForPlayer: (clientId) ->
    (ship for ship in @ships when ship.clientId == clientId)[0]

define "luolis.game.model.World", World
