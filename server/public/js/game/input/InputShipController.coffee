class InputShipController
  constructor: (ship, input) ->
    @ship = ship
    @input = input

  update: ->
    if @input.LEFT
        @ship.xv -= 1

    if @input.RIGHT
        @ship.xv += 1

    if @input.UP
        @ship.yv -= 1

    if @input.DOWN
        @ship.yv += 1

define "luolis.game.input.InputShipController", InputShipController
