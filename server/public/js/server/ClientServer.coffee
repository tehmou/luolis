lastClientId = 0

class ClientServer

  constructor: ->
    console.log "ClientServer", "Creating"
    #@world = new luolis.game.model.World window.innerWidth*1.4, window.innerHeight*1.4
    @world = new luolis.game.model.World window.innerWidth*1, window.innerHeight*1
    @physics = new luolis.game.physics.Physics
    @game = new luolis.game.Game @world, @physics

  run: ->
    console.log "ClientServer", "Running"
    setInterval @updateFrame, 1000/60

  updateFrame: =>
    @game.updateFrame()

  registerClient: ->
    console.log "ClientServer", "Registring client"
    clientId = lastClientId
    @game.addPlayer clientId
    console.log "ClientServer", "Registered client with id=" + clientId
    lastClientId++
    clientId

  processInput: (clientId, input) ->

    #switch input
    # when "LEFT"

  getWorld: (clientId) ->
    @world

  getPlayer: (clientId) ->
    (ship for ship in @world.ships when ship.clientId == clientId)[0]

define "luolis.server.ClientServer", ClientServer