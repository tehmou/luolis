class OnlineBroker
  constructor: (socket, signalsIn, signalsOut) ->
    log "Creating"
    createPubSub this
    @socket = socket
    @addSignalIn signal for signal in signalsIn if signalsIn
    @addSignalOut signal for signal in signalsOut if signalsOut

  addSignalIn: (signal) =>
    @socket.on signal, =>
      @publish signal, Array.prototype.slice.call(arguments[0])

  addSignalOut: (signal) =>
    @subscribe signal, =>
      @socket.emit signal, Array.prototype.slice.call(arguments)

define "luolis.broker.OnlineBroker", OnlineBroker