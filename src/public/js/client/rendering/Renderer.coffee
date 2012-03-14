class Renderer
  constructor: (width, height) ->
    log "Creating"
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
    ctx.fillStyle = "rgb(255,255,255)"
    ctx.beginPath()
    drawPolygon ship.shape, ship.body.m_body.m_xf.position.x-offsetX, ship.body.m_body.m_xf.position.y-offsetY
    ctx.fill()

  drawPolygon = (polygon, x, y) ->
    ctx.moveTo x+polygon[0][0], y+polygon[0][1]
    ctx.lineTo x+polygon[i][0], y+polygon[i][1] for i in [1..polygon.length-1]
    ctx.closePath()

  world.ships.forEach(drawShip)

  ctx.strokeStyle = "rgb(255,255,255)"
  ctx.beginPath()
  drawPolygon [[6,6],[6,world.height-6],[world.width-6,world.height-6],[world.width-6,6]],-offsetX,-offsetY
  ctx.stroke()


define "luolis.game.rendering.Renderer", Renderer
