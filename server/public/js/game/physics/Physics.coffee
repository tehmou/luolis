class Physics
  constructor: ->
    @gravity = 0.1

  apply: (world) ->
    gravity = @gravity

    applyGravity  = (ship) ->
      ship.yv += gravity

    processShip = (ship) ->
      ship.x += ship.xv
      ship.y += ship.yv

      if ship.x < 0
        ship.xv = 0
        ship.x = 0

      if ship.x > world.width
        ship.xv = 0
        ship.x = world.width

      if ship.y < 0
        ship.yv = 0
        ship.y = 0

      if ship.y > world.height
        ship.yv = 0
        ship.y = world.height

    applyGravity ship for ship in world.ships
    processShip ship for ship in world.ships


define "luolis.game.physics.Physics", Physics
