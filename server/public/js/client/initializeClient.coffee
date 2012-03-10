initializeClient = ->
  console.log "Initializing luolis client"
  client = luolis.client.instance = new luolis.client.Client

define "luolis.initializeClient", initializeClient