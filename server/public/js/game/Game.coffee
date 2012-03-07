class Game
  constructor: (world, physics) ->
    @world = world
    @physics = physics

  updateFrame: ->
    @physics.apply @world

  startSinglePlayerGame: ->
    ship =
        x: @world.width/2
        y: @world.height/2
        xv: 0
        yv: 0
        angle: 0
        shape: [ [0, -30], [-8, -8], [8, -8] ]

    @world.ships.push ship
    ship

define "luolis.game.Game", Game