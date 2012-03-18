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

  toJSON: ->
    json =
      width: @width
      height: @.height
      ships: []
      groundBodies: []

    serializeBox2DFixture = (fixture) ->
      shape: fixture.m_shape.m_vertices
      radius: fixture.m_shape.m_radius
      position: fixture.m_body.m_xf.position

    serializeShip = (ship) ->
      shipJSON = serializeBox2DFixture ship.body
      shipJSON.rotation = ship.rotation
      shipJSON.clientId = ship.clientId
      shipJSON

    (json.ships.push serializeShip ship) for ship in @ships
    (json.groundBodies.push serializeBox2DFixture groundBody) for groundBody in @groundBodies

    json

define "luolis.game.model.World", World
