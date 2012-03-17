class SendWorldBroker
  constructor: (socket) ->
    log "Creating"
    createPubSub this
    @socket = socket

    this.subscribe "world", (world) =>
      # FIXME: Cannot emit world because the JSON cannot be serialized..
      # @socket.emit "world", world

    this.subscribe "worldUpdated", () =>
      this.publish "requestWorld"

define "luolis.broker.SendWorldBroker", SendWorldBroker