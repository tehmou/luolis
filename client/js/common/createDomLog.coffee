containerEl = null
logEl = null
domLogVisible = true

createDomLog = (el) ->
  oldLog = window.log;
  containerEl = el
  logEl = document.createElement "pre"
  containerEl.appendChild logEl

  window.log = ->
    logEl.innerHTML += Array.prototype.join.apply(arguments    , [" "]) + "\n";
    oldLog.apply(oldLog, arguments);

  if toggleLog = document.getElementById "toggle-log"
    toggleLog.onclick = ->
      toggleDomLog()

toggleDomLog = ->
  domLogVisible = !domLogVisible
  if domLogVisible
    containerEl.style.display = "block"
  else
    containerEl.style.display = "none"

define "luolis.common.toggleDomLog", toggleDomLog
define "luolis.common.createDomLog", createDomLog