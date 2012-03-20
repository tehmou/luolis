class Central
  constructor: (broker) ->
    log "Creating"
    @broker = broker
    @broker.subscribe "joined", @onJoined
    @broker.subscribe "parted", @onParted
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

  onJoined: (clientId) =>
    log "Joining id=" + clientId

  onParted: (clientId) =>
    log "Parting id=" + clientId

define "luolis.central.Central", Central