initializeServer = ->
  log "Initializing luolis server"
  server = luolis.server.instance = new luolis.server.Server

define "luolis.initializeServer", initializeServer