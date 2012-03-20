class Renderer
  constructor: (width, height, canvas) ->
    log "Creating"
    if canvas
      @canvas = canvas
    else
      @canvas = document.createElement "canvas"
      document.body.appendChild @canvas
    @resize width, height

  attachShip: (ship) ->
    log "Attaching ship"
    @ship = ship

  resize: (width, height) ->
    @width = @canvas.width = width
    @height = @canvas.height = height

  render: (world, center) ->
    ctx = @canvas.getContext "2d"
    ctx.fillStyle = "rgb(0,0,0)"
    ctx.fillRect 0, 0, @width, @height

    if @width < world.width
      offsetX = center.x - @width/2
      offsetX = Math.min offsetX, world.width-@width
      offsetX = Math.max offsetX, 0
    else
      offsetX = -(@width - world.width) / 2

    if @height < world.height
      offsetY = center.y - @height/2
      offsetY = Math.min offsetY, world.height-@height
      offsetY = Math.max offsetY, 0
    else
      offsetY = -(@height - world.height) / 2

    renderAt ctx, world, offsetX, offsetY


renderAt = (ctx, world, offsetX, offsetY) ->

  drawShip = (ship) ->
    x = ship.position.x-offsetX
    y = ship.position.y-offsetY
    angle = ship.rotation
    r = ship.radius

    ctx.fillStyle = "rgb(255,255,255)"
    ctx.beginPath()
    ctx.arc x, y, r, 0, Math.PI * 2, true
    ctx.moveTo x, y
    ctx.lineTo x+Math.cos(angle)*r, y+Math.sin(angle)*r
    ctx.stroke()

  drawPolygon = (polygon, x, y) ->
    ctx.moveTo x+polygon[0].x, y+polygon[0].y
    ctx.lineTo x+polygon[i].x, y+polygon[i].y for i in [1..polygon.length-1]
    ctx.closePath()

  world.groundBodies.forEach (body) ->
    ctx.fillStyle = "rgb(255,255,255)"
    ctx.beginPath()
    drawPolygon body.shape, body.position.x-offsetX, body.position.y-offsetY
    ctx.stroke()

  world.ships.forEach drawShip

  ctx.strokeStyle = "rgb(255,255,255)"
  ctx.beginPath()
  ctx.stroke()


define "luolis.game.rendering.Renderer", Renderer
