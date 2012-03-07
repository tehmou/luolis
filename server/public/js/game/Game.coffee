define "luolis.game.Game", (world, physics) ->
  @world = world
  @physics = physics
  return this

luolis.game.Game.prototype.updateFrame = () ->
  @physics.apply @world

luolis.game.Game.prototype.startSinglePlayerGame = () ->
  ship =
      x: @world.width/2
      y: @world.height/2
      xv: 0
      yv: 0
      angle: 0
      shape: [ [0, -30], [-8, -8], [8, -8] ]

  @world.ships.push ship

  return ship
