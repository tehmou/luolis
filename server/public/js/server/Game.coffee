class Game
  constructor: () ->
    console.log "Creating game"
    @physics = new luolis.game.physics.Physics

  loadWorld: (world) ->
    @world = world

  updateFrame: ->
    @physics.apply @world

  addPlayer: (clientId) ->
    console.log "Adding player to world"
    ship =
        x: @world.width/2
        y: @world.height/2
        xv: 0
        yv: 0
        angle: 0
        shape: [ [0, -30], [-8, -8], [8, -8] ]
        clientId: clientId

    @world.ships.push ship
    ship

define "luolis.game.Game", Game