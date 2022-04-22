require! <[assert]>
lderror = require '../src/lde'

Promise.resolve!
  .then -> lderror.reject 999
  .catch -> return lderror.id(it)
  .then -> assert(it == 999)
  .then -> assert(lderror.message({id: 1000}) == 'user not login')
  .then -> assert(lderror.message('no such error') == 'unknown lderror')
  .then -> console.log "PASS"
  .catch -> console.log "FAIL"
