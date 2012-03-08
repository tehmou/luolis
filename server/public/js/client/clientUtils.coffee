# Provides requestAnimationFrame in a cross browser way.
window.requestAnimFrame = window.requestAnimationFrame ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame ||
  window.oRequestAnimationFrame ||
  window.msRequestAnimationFrame ||
  (callback, element) ->
    window.setTimeout callback, 1000/60

