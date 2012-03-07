class KeyboardInput
  constructor: ->
    @inputMap = {}

    keyCodes =
        37: "LEFT"
        39: "RIGHT"
        38: "UP"
        40: "DOWN"

    document.body.onkeydown = (e) =>
      if keyCodes.hasOwnProperty e.keyCode
        @inputMap[keyCodes[e.keyCode]] = true

    document.body.onkeyup = (e) =>
      if keyCodes.hasOwnProperty e.keyCode
        @inputMap[keyCodes[e.keyCode]] = false

define "luolis.game.input.KeyboardInput", KeyboardInput