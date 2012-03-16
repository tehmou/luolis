class Engine

  constructor: (broker) ->
    log "Creating"
    @broker = broker
    @physics = new luolis.game.physics.Physics

    @broker.subscribe "requestWorld", @onRequestWorld
    @broker.subscribe "collectiveInput", @onCollectiveInput
    @broker.subscribe "joined", @onJoined
    @broker.subscribe "parted", @onParted

  onRequestWorld: =>
    @broker.publish "world", [@world]

  loadWorld: (world) ->
    @world = world

  createWorld: (width, height) ->
    world = new luolis.game.model.World width, height
    world.addGround @physics.createGround width, height
    @loadWorld world

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
    #log "input " + input + " from " + clientId
    processPlayer = (clientId, input) =>
      ship = @world.getShipForPlayer clientId
      if !ship then return
      if input & luolis.game.input.shipInputTypes.LEFT
        ship.rotation = (ship.rotation - 0.2) % (Math.PI*2)
      if input & luolis.game.input.shipInputTypes.RIGHT
        ship.rotation = (ship.rotation + 0.2) % (Math.PI*2)
      if input & luolis.game.input.shipInputTypes.ACCELERATE
        ship.body.m_body.m_linearVelocity.x += Math.cos(ship.rotation)* 10.0
        ship.body.m_body.m_linearVelocity.y += Math.sin(ship.rotation)* 10.0
      #if input & luolis.game.input.shipInputTypes.SHOOT
      #  ship.body.m_body.m_linearVelocity.y += 1

    processPlayer(clientId, input) for clientId, input of collectiveInput
    @updateFrame()

  updateFrame: =>
    @physics.apply @world
    @broker.publish "worldupdated"

define "luolis.engine.Engine", Engine