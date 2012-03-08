# Polyfill for bind function on Safari.
Function.prototype.bind = Function.prototype.bind || (obj) ->
  fnc = this
  ->
    fnc.apply obj, arguments

# Provides requestAnimationFrame in a cross browser way.
window.requestAnimFrame = window.requestAnimationFrame ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame ||
  window.oRequestAnimationFrame ||
  window.msRequestAnimationFrame ||
  (callback, element) ->
    window.setTimeout callback, 1000/60

window.define = (path, obj) ->
  defineWithRoot window, path, obj

window.defineWithRoot = (root, path, obj) ->
  parts = path.split "."
  while part = parts.shift()
    if parts.length
      if !root.hasOwnProperty part
        root[part] = {}
    else
      if root.hasOwnProperty part
          _.extend root[part], obj
      else
          root[part] = obj
    root = root[part]
