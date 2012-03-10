lastClientId = 0

class ClientServer

  constructor: ->
    console.log "ClientServer", "Creating"
    @world = new luolis.game.model.World window.innerWidth*1.4, window.innerHeight*1.4
    #@world = new luolis.game.model.World window.innerWidth*1, window.innerHeight*1
    @game = new luolis.game.Game
    @game.loadWorld @world

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
    console.log("input " + input + " from " + clientId);
    ship = @world.getShipForPlayer clientId
    if input & luolis.game.input.shipInputTypes.LEFT
      ship.xv -= 1
    if input & luolis.game.input.shipInputTypes.RIGHT
      ship.xv += 1

  #switch input
    # when "LEFT"

  getWorld: (clientId) ->
    @world

  getPlayer: (clientId) ->
    @world.getShipForPlayer clientId

define "luolis.server.ClientServer", ClientServer