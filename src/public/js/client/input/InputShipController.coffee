defaultShipInputKeyMap =
  ACCELERATE: 38
  LEFT: 37
  RIGHT: 39
  SHOOT: 40

class InputShipController
  constructor: (input) ->
    @input = input
    @keyMap = defaultShipInputKeyMap

  getInput: ->
    input = 0
    input |= value for key, value of luolis.game.input.shipInputTypes when @input[@keyMap[key]]
    input

define "luolis.game.input.InputShipController", InputShipController
