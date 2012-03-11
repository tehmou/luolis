class Central
  constructor: (broker) ->
    log "Creating"
    @broker = broker
    @broker.subscribe "requestJoin", @onRequestJoin
    @broker.subscribe "requestPart", @onRequestPart
    @broker.subscribe "input", @onInput
    @frameCounter = 0

  run: ->
    setInterval @mainLoop, 1000/24

  mainLoop: =>
    @broker.publish "collectiveInput", [@collectiveInput] if @collectiveInput
    @collectiveInput = {}
    @frameCounter++
    @broker.publish "inputRequest", [@frameCounter]

  onInput: (clientId, input, timestamp) =>
    #log "Input from id=" + clientId
    if (timestamp == @frameCounter)
        @collectiveInput[clientId] = input

  onRequestJoin: (clientId) =>
    log "Joining id=" + clientId
    @broker.publish "joined", [clientId]

  onRequestPart: (clientId) =>
    log "Parting id=" + clientId
    @broker.publish "parted", [clientId]

define "luolis.central.Central", Central