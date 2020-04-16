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
    1008: "unable to parse user data"
    1009: "bot"
    1010: "recaptcha error"
    1011: "resouce conflict"
    1012: "permission denied"
  ldError = (opt="", id = 0) ->
    if typeof(opt) == \string => @ <<< {message: opt, id}
    else if (opt instanceof Error) => @ <<< opt{stack,message} <<< {id:id or 0}
    else if typeof(opt) == \object => @ <<< opt <<< {id: opt.id or id or 0}
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
