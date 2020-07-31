require! <[assert]>
ldError = require '../src/lde'

Promise.resolve!
  .then -> ldError.reject 999
  .catch -> return ldError.id(it)
  .then -> assert(it == 999)
  .then -> console.log "PASS"
  .catch -> console.log "FAIL"
