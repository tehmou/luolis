class Client
  constructor: (server, clientId) ->
    console.log "Client", "Creating"
    @server = server
    @clientId = clientId

    @canvas = document.createElement "canvas"
    document.body.appendChild @canvas

    @renderer = new luolis.game.rendering.Renderer @canvas
    #@renderer.attachShip(ship)

    @input = new luolis.game.input.KeyboardInput
    @inputShipController = new luolis.game.input.InputShipController @input.inputMap

    @resize = @resize.bind this
    @updateFrame = @updateFrame.bind this
    @resize()
    @updateFrame()

    document.body.onresize = @resize

  resize: ->
    @renderer.width = @canvas.width = window.innerWidth
    @renderer.height = @canvas.height = window.innerHeight

  updateFrame: ->
    input = @inputShipController.getInput()
    @server.processInput @clientId, input if input
    @renderer.render @server.getWorld(@clientId), @server.getPlayer(@clientId)
    requestAnimFrame @updateFrame

define "luolis.client.Client", Client