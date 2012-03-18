class ReceiveWorldBroker
  constructor: (socket) ->
    log "Creating"
    createPubSub this
    @socket = socket

    @socket.on "worldJSON", (worldJSON) =>
      @publish "worldJSON", [worldJSON]

    @subscribe "requestJoin", (clientId) =>
      @socket.emit "requestJoin", clientId

    @socket.on "joined", (clientId) =>
      @publish "joined", [clientId]

    @subscribe "requestPart", (clientId) =>
      @socket.emit "requestPart", clientId

    @socket.on "parted", (clientId) =>
      @publish "parted", [clientId]

define "luolis.broker.ReceiveWorldBroker", ReceiveWorldBroker