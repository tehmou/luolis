initializeSinglePlayer = ->
  console.log "Initializing single player game"
  server = luolis.server.instance = new luolis.server.ClientServer
  clientId = server.registerClient()
  client = luolis.client.instance = new luolis.client.Client server, clientId
  server.run()

define "luolis.initializeSinglePlayer", initializeSinglePlayer