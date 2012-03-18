class Engine

  constructor: (broker) ->
    log "Creating"
    @broker = broker
    @physics = new luolis.game.physics.Physics

    @broker.subscribe "collectiveInput", @onCollectiveInput
    @broker.subscribe "joined", @onJoined
    @broker.subscribe "parted", @onParted

  sendWorldJSON: =>
    @broker.publish "worldJSON", [@world.toJSON()]

  createWorld: (width, height) ->
    world = new luolis.game.model.World width, height
    world.addGround @physics.createGround width, height
    @world = world

  onJoined: (clientId) =>
    log "Player joining with id=" + clientId

    ship =
      body: @physics.createShipBody Math.random() * @world.width, Math.random() * @world.height
      clientId: clientId
      shape: [ [0, -30], [-8, -8], [8, -8] ]
      rotation: 0

    @world.addShip ship

  onParted: (clientId) =>
    log "Player parting with id=" + clientId

  onCollectiveInput: (collectiveInput) =>
    processPlayer = (clientId, input) =>
      ship = @world.getShipForPlayer clientId
      if !ship then return
      if input & luolis.game.input.shipInputTypes.LEFT
        ship.rotation = (ship.rotation - 0.2) % (Math.PI*2)
      if input & luolis.game.input.shipInputTypes.RIGHT
        ship.rotation = (ship.rotation + 0.2) % (Math.PI*2)
      if input & luolis.game.input.shipInputTypes.ACCELERATE
        direction = new Box2D.Common.Math.b2Vec2(
          Math.cos(ship.rotation) * 10000.0
          Math.sin(ship.rotation) * 10000.0
        )
        center = ship.body.m_body.GetWorldCenter()
        ship.body.m_body.ApplyImpulse direction, center

    processPlayer(clientId, input) for clientId, input of collectiveInput
    @updateFrame()

  updateFrame: =>
    @physics.apply @world
    this.sendWorldJSON()

define "luolis.engine.Engine", Engine