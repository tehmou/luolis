# Broker that does not connect to any sockets. Everything happens locally.

class LocalBroker
  constructor: ->
    log "Creating"
    createPubSub this

define "luolis.broker.LocalBroker", LocalBroker