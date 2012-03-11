# Polyfill for bind function on Safari.
Function.prototype.bind = Function.prototype.bind || (obj) ->
  fnc = this
  ->
    fnc.apply obj, arguments