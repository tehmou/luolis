# Main namespace

window.define = (path, obj) ->
  defineWithRoot (window ? window : global), path, obj

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
