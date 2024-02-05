idmap = do
  0: "unknown lderror"
  # 100 ~ 599: preserved for http code
  998: "skipped" # action skipped
  999: "canceled" # action canceled.
  1000: "user not login"
  1001: "suspicious user"
  1002: "unknown error" # for suspicious user
  1003: "image process failed"
  1004: "quota exceeded"
  1005: "csrftoken mismatch"
  1006: "timeout"
  1007: "server down"
  1008: "unable to parse user data"
  1009: "bot"
  1010: "captcha error"
  1011: "resource conflict"
  1012: "permission denied"
  1013: "expire"
  1014: "apply for a resource that already exists"
  1015: "bad parameter"
  1016: "feature not yet available"
  1017: "resource corrupted"
  1018: "no consent"
  1019: "wrong domain"
  1020: "not supported"
  1021: "email not verified"
  1022: "missing dependency"
  1023: "lderror testing"
  1024: "limited by throttling"
  1025: "runtime error"
  1026: "not applicable"
  1027: "missing config"
  1028: "resource unavailable"
  1029: "session data corrupted"
  1030: "password mismatched"
  1031: "weak password"
  1032: "credential scheme mismatched"
  1033: "view failed to render"
  1034: "user not found"
  1035: "payment rejected"
  1036: "reused passwords not allowed"
  1037: "offline"
  1038: "file too large"
  1039: "payment rejected" # for suspicious user
  1040: "registration closed"
  # 10000 ~ 29999 preserved for customized error

lderror = (opt="", id = 0) ->
  if !(@ instanceof lderror) => return new lderror(opt, id)
  _id = (if !isNaN(+id) => +id else 0) or opt.id or 0
  if typeof(opt) == \string => @ <<< {message: opt, id: _id}
  else if (opt instanceof Error) => @ <<< opt{stack,message} <<< {id: _id}
  else if typeof(opt) == \object =>
    delete opt.__proto__
    delete opt.constructor
    @ <<< opt <<< {id: _id}
  else if typeof(opt) == \number =>
    @id = opt
    if typeof(id) == \string => @message = id
    else if typeof(id) == \object => @payload = id
    if !(@message) =>
      @message = if idmap[@id or 0] => that
      else if @id >= 100 and @id < 600 => "http code: #{@id}"
      else "#{idmap.0} (id: #{@id or 0})"
  # otherwise stringify wont keep the name
  @name = lderror.prototype.name
  @stack = (e = (new Error!) <<< @).stack
  # this is especially useful to handle unhandledrejection.
  # simply throw it again gives us the full stack to trace in dev console
  @error = e
  @

lderror.prototype = Object.create(Error.prototype) <<< do
  # code: 400 # code member preserved for http status code
  name: \lderror
  toString: (opt = {}) ->
    obj = @toObject!
    if opt.stack? and !opt.stack => delete obj.stack
    JSON.stringify(obj)
  toObject: -> {name: @name} <<< @{id, message, stack, payload}

lderror.id = (opt) ->
  if typeof(opt) == \object and opt.name == \lderror and opt.id => return opt.id
  return 0

lderror.message = (o) ->
  if typeof(o) == \number => return idmap[o] or idmap.0
  else if typeof(o) == \object => return idmap[o.id] or idmap.0
  return idmap.0

lderror.reject = (opt,id) -> Promise.reject new lderror(opt,id)

lderror.handler = (o={}) ->
  # _i: list of id to ignore
  @i = (o.ignore or []) ++ [999]
  @h = o.handler
  @r = o.rule or (->it)
  @s = {}
  h = (e) ~>
    if (i = lderror.id(e)) in @i => return
    @s[i] = 1
    @h(@r(i),e).then ~> @s[i] = 0
    if !i =>
      console.log e
      throw e
  h.is-on = ~> !![v for k,v of @s].filter((v)->v).length
  h

lderror.event-handler =
  error: (e) ->
    if e.error and e.error.name == \lderror and e.error.error and e.error != e.error.error =>
      console.warn "uncaught lderror", e.error
      console.warn "with its internal Error object thrown:"
      e.preventDefault!
      # add a setTimeout so it will be handled again by this handler
      setTimeout (->throw e.error.error), 0
      return true
    return false

  rejection: (e) ->
    if e.reason and e.reason.name == \lderror and e.reason.error =>
      console.warn "Unhandled rejection with lderror:", e.reason
      console.warn "with its internal Error object thrown:"
      # add a setTimeout so it will be handled again by error handler
      setTimeout (-> throw e.reason.error), 0
      e.preventDefault!
      return true
    return false

if module? => module.exports = lderror
else if window? => window.lderror = lderror
