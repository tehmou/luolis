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
    @loadWorld new luolis.game.model.World width, height

  onJoined: (clientId) =>
    log "Player joining with id=" + clientId
    ship =
      x: @world.width/2
      y: @world.height/2
      xv: 0
      yv: 0
      angle: 0
      shape: [ [0, -30], [-8, -8], [8, -8] ]
      clientId: clientId
    @world.ships.push ship

  onParted: (clientId) =>
    log "Player parting with id=" + clientId

  onCollectiveInput: (collectiveInput) =>
    #log "input " + input + " from " + clientId
    processPlayer = (clientId, input) =>
      ship = @world.getShipForPlayer clientId
      if !ship then return
      if input & luolis.game.input.shipInputTypes.LEFT
        ship.xv -= 1
      if input & luolis.game.input.shipInputTypes.RIGHT
        ship.xv += 1
      if input & luolis.game.input.shipInputTypes.ACCELERATE
        ship.yv -= 1
      if input & luolis.game.input.shipInputTypes.SHOOT
        ship.yv += 1

    processPlayer(clientId, input) for clientId, input of collectiveInput
    @updateFrame()

  updateFrame: =>
    @physics.apply @world
    @broker.publish "worldupdated"

define "luolis.engine.Engine", Engine