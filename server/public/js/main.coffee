class Instance
  run: ->
    @canvas = document.createElement "canvas"
    document.body.appendChild @canvas

    @world = new luolis.game.model.World window.innerWidth*1.4, window.innerHeight*1.4
    @physics = new luolis.game.physics.Physics
    @game = new luolis.game.Game @world, @physics
    ship = @game.startSinglePlayerGame @input

    @renderer = new luolis.game.rendering.Renderer @canvas
    @renderer.attachShip(ship)

    @input = new luolis.game.input.KeyboardInput
    @inputShipController = new luolis.game.input.InputShipController ship, @input.inputMap

    @resize = @resize.bind this
    @render = @render.bind this
    @resize()
    @render()

  resize: ->
    @renderer.width = @canvas.width = window.innerWidth
    @renderer.height = @canvas.height = window.innerHeight

  render: ->
    @inputShipController.update()
    @game.updateFrame()
    @renderer.render @world
    requestAnimFrame @render

define "luolis.initialize", ->
  instance = new Instance()
  instance.run()
  document.body.onresize = instance.resize
