class Client
  constructor: (broker, clientId) ->
    log "Creating with clientId=" + clientId

    @clientId = clientId
    @broker = broker

    log "Attaching to broker"
    @broker.subscribe "joined", @onJoined
    @broker.subscribe "requestInput", @onRequestInput
    @broker.subscribe "worldJSON", @onWorldJSON

    log "Setting up input"
    @input = new luolis.game.input.KeyboardInput
    @inputShipController = new luolis.game.input.InputShipController @input.inputMap

    log "Attach to resize event"
    document.body.onresize = @resize

    log "Requesting to join the game"
    @broker.publish "requestJoin", [@clientId]

    log "Starting rendering loop without renderer"
    @updateFrame()

  resize: =>
    @renderer.resize window.innerWidth, window.innerHeight if @renderer

  onJoined: (clientId) =>
    log "Joined, create renderer."
    if clientId == @clientId
      if !@renderer
        @renderer = new luolis.game.rendering.Renderer window.innerWidth, window.innerHeight

  onRequestInput: (timestamp) =>
    input = @inputShipController.getInput()
    @broker.publish "input", [@clientId, input, timestamp]

  onWorldJSON: (worldJSON) =>
    @worldJSON = worldJSON

  getShipForPlayer: =>
    (ship for ship in @worldJSON.ships when ship.clientId == @clientId)[0]

  updateFrame: =>
    if @renderer and @worldJSON
      myShip = this.getShipForPlayer()
      @renderer.render @worldJSON, myShip.position if myShip
    requestAnimFrame @updateFrame

define "luolis.client.Client", Client