class Client
  constructor: (broker, clientId) ->
    log "Creating with clientId=" + clientId

    @clientId = clientId
    @broker = broker

    log "Attaching to broker"
    @broker.subscribe "joined", @onJoined
    @broker.subscribe "inputRequest", @onInputRequest
    @broker.subscribe "world", @onWorld
    @broker.publish "requestWorld"

    log "Setting up input"
    @input = new luolis.game.input.KeyboardInput
    @inputShipController = new luolis.game.input.InputShipController @input.inputMap

    log "Attach to resize event"
    document.body.onresize = @resize

    log "Requesting to join the game"
    @broker.publish "requestJoin", [clientId]

    log "Starting rendering loop"
    @updateFrame()

  resize: =>
    @renderer.resize window.innerWidth, window.innerHeight

  onJoined: (clientId) =>
    if clientId == @clientId
      if !@renderer
        @renderer = new luolis.game.rendering.Renderer window.innerWidth, window.innerHeight

  onInputRequest: (timestamp) =>
    #log "onInputRequest"
    input = @inputShipController.getInput()
    @broker.publish "input", [@clientId, input, timestamp]

  onWorld: (world) =>
    log "onWorld", world
    @world = world

  updateFrame: =>
    @renderer.render @world, @world.getShipForPlayer(@clientId) if @renderer and @world
    requestAnimFrame @updateFrame

define "luolis.client.Client", Client