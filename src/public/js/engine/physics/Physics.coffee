class Physics
  constructor: ->
    log "Creating"

  apply: (world) ->
    world.update()

define "luolis.game.physics.Physics", Physics
