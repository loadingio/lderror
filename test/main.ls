require! <[assert]>
lderror = require '../src/lde'

Promise.resolve!
  .then -> lderror.reject 999
  .catch -> return lderror.id(it)
  .then -> assert(it == 999)
  .then -> console.log "PASS"
  .catch -> console.log "FAIL"
