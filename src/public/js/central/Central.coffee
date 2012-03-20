class Central
  constructor: (broker) ->
    log "Creating"
    @broker = broker
    @broker.subscribe "requestJoin", @onRequestJoin
    @broker.subscribe "requestPart", @onRequestPart
    @broker.subscribe "input", @onInput
    @frameCounter = 0

  run: ->
    log "Starting main loop"
    setInterval @mainLoop, 1000/24

  mainLoop: =>
    @broker.publish "collectiveInput", [@collectiveInput] if @collectiveInput
    @collectiveInput = {}
    @frameCounter++
    @broker.publish "requestInput", [@frameCounter]

  onInput: (clientId, input, timestamp) =>
    # if (timestamp == @frameCounter)
    @collectiveInput[clientId] = input

  onRequestJoin: (clientId) =>
    log "Joining id=" + clientId
    @broker.publish "joined", [clientId]

  onRequestPart: (clientId) =>
    log "Parting id=" + clientId
    @broker.publish "parted", [clientId]

define "luolis.central.Central", Central