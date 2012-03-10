lastClientId = 0

class Server

  constructor: ->
    log "Creating"
    @world = new luolis.game.model.World window.innerWidth*1.4, window.innerHeight*1.4
    #@world = new luolis.game.model.World window.innerWidth*1, window.innerHeight*1
    @game = new luolis.game.Game
    @game.loadWorld @world
    @connect "http://localhost:9876"

  connect: (url) ->
    log "Connecting to " + url
    @socket = io.connect url;
    @socket.on "connect", () =>
      @socket.emit "join", "", (data) =>
        log data

  run: ->
    console.log NAME, "Running"
    setInterval @updateFrame, 1000/60

  updateFrame: =>
    @game.updateFrame()

  registerClient: ->
    console.log NAME, "Registring client"
    clientId = lastClientId
    @game.addPlayer clientId
    console.log NAME, "Registered client with id=" + clientId
    lastClientId++
    clientId

  processInput: (clientId, input) ->
    console.log("input " + input + " from " + clientId);
    ship = @world.getShipForPlayer clientId
    if input & luolis.game.input.shipInputTypes.LEFT
      ship.xv -= 1
    if input & luolis.game.input.shipInputTypes.RIGHT
      ship.xv += 1
    if input & luolis.game.input.shipInputTypes.ACCELERATE
      ship.yv -= 1
    if input & luolis.game.input.shipInputTypes.SHOOT
      ship.yv += 1

  getWorld: (clientId) ->
    @world

  getPlayer: (clientId) ->
    @world.getShipForPlayer clientId

define "luolis.server.Server", Server