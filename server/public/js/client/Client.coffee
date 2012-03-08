class Client
  constructor: (server, clientId) ->
    console.log "Client", "Creating"
    @server = server
    @clientId = clientId

    @canvas = document.createElement "canvas"
    document.body.appendChild @canvas

    @renderer = new luolis.game.rendering.Renderer @canvas
    #@renderer.attachShip(ship)

    #@input = new luolis.game.input.KeyboardInput
    #@inputShipController = new luolis.game.input.InputShipController ship, @input.inputMap

    @resize = @resize.bind this
    @render = @render.bind this
    @resize()
    @render()

    document.body.onresize = @resize

  resize: ->
    @renderer.width = @canvas.width = window.innerWidth
    @renderer.height = @canvas.height = window.innerHeight

  render: ->
    #@inputShipController.update()
    @renderer.render @server.getWorld(@clientId), @server.getPlayer(@clientId)
    requestAnimFrame @render

define "luolis.client.Client", Client