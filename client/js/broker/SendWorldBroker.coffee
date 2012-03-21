class SendWorldBroker
  constructor: (socket) ->
    log "Creating"
    createPubSub this
    @socket = socket

    this.subscribe "worldJSON", (worldJSON) =>
      @socket.emit "worldJSON", worldJSON

    @socket.on "requestJoin", (clientId) =>
      @publish "requestJoin", [clientId]

    @subscribe "joined", (clientId) =>
      @socket.emit "joined", clientId

    @socket.on "requestPart", (clientId) =>
      @publish "requestPart", [clientId]

    @subscribe "parted", (clientId) =>
      @socket.emit "parted", clientId

define "luolis.broker.SendWorldBroker", SendWorldBroker