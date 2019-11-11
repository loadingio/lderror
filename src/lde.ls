(->
  idmap = do
    0: "unknown error"
    # 400 ~ 599: preserved for http code
    999: "canceled" # action canceled.
    1000: "user not login"
    1001: "suspicious user"
    1002: "unknown error" # for suspicious user
    1003: "image process failed"
    1004: "quota exceeded"
    1005: "csrftoken mismatch"
    1006: "timeout"
    1007: "server down"

  ldError = (opt="", id = 0) ->
    if typeof(opt) == \string => @ <<< {message: opt, id}
    else if typeof(opt) == \object => @ <<< {id: 0} <<< opt
    else if typeof(opt) == \number => @id = opt
    if !(@message?) => @message = idmap[@id or 0]
    @stack = (new Error!).stack
    @

  ldError.prototype = Object.create(Error.prototype) <<< do
    # code: 400 # code member preserved for http status code
    name: \ldError
    toString: (opt = {}) ->
      obj = @toObject!
      if opt.stack? and !opt.stack => delete obj.stack
      JSON.stringify(obj)
    toObject: -> {name: @name} <<< @{id, message, stack}
  if module? => module.exports = ldError
  if window? => window.ldError = ldError
)!
