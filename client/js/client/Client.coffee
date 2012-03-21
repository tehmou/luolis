class Client
  constructor: (broker, clientId, el) ->
    log "Creating with clientId=" + clientId

    @broker = broker
    @clientId = clientId

    log "Attaching to broker"
    @broker.subscribe "requestInput", @onRequestInput
    @broker.subscribe "worldJSON", @onWorldJSON

    log "Setting up input"
    @input = new luolis.game.input.KeyboardInput
    @inputShipController = new luolis.game.input.InputShipController @input.inputMap

    log "Attach to resize event"
    document.body.onresize = @resize

    log "Creating renderer"
    @renderer = new luolis.game.rendering.Renderer window.innerWidth, window.innerHeight, el

    log "Starting rendering loop"
    @updateFrame()

  resize: =>
    @renderer.resize window.innerWidth, window.innerHeight if @renderer

  onRequestInput: (timestamp) =>
    input = @inputShipController.getInput()
    @broker.publish "input", [@clientId, input, timestamp]

  onWorldJSON: (worldJSON) =>
    if !@worldJSON
      log "First world received"
    @worldJSON = worldJSON

  getShipForPlayer: =>
    (ship for ship in @worldJSON.ships when ship.clientId == @clientId)[0]

  updateFrame: =>
    if @renderer and @worldJSON
      myShip = this.getShipForPlayer()
      @renderer.render @worldJSON, myShip.position if myShip
    requestAnimFrame @updateFrame

define "luolis.client.Client", Client