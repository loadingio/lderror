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
    if !(@message) =>
      @message = if idmap[@id or 0] => that
      else if @id >= 100 and @id < 600 => "http code: #{@id}"
      else "#{idmap.0} (id: #{@id or 0})"
  @stack = (new Error!).stack
  # otherwise stringify wont keep the name
  @name = lderror.prototype.name
  @

lderror.prototype = Object.create(Error.prototype) <<< do
  # code: 400 # code member preserved for http status code
  name: \lderror
  toString: (opt = {}) ->
    obj = @toObject!
    if opt.stack? and !opt.stack => delete obj.stack
    JSON.stringify(obj)
  toObject: -> {name: @name} <<< @{id, message, stack}

lderror.id = (opt) ->
  if typeof(opt) == \object and opt.name == \lderror and opt.id => return opt.id
  return 0

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
    if !i => console.log e
  h.is-on = ~> !![v for k,v of @s].filter((v)->v).length
  h

if module? => module.exports = lderror
else if window? => window.lderror = lderror
