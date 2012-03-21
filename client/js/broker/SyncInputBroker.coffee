class SyncInputBroker
  constructor: (socket) ->
    log "Creating"
    @socket = socket
    createPubSub this

define "luolis.broker.SyncInputBroker", SyncInputBroker