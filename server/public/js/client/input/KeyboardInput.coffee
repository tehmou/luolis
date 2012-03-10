class KeyboardInput
  constructor: ->
    @inputMap = {}

    document.body.onkeydown = (e) =>
      @inputMap[e.keyCode] = true

    document.body.onkeyup = (e) =>
      @inputMap[e.keyCode] = false

define "luolis.game.input.KeyboardInput", KeyboardInput