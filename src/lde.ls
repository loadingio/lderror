(->
  ldError = (opt="", id = 0) ->
    if typeof(opt) == \string => @ <<< {message: opt, id}
    else if typeof(opt) == \object => @ <<< {id: 0} <<< opt
    else if typeof(opt) == \number => @id = opt
    @stack = (new Error!).stack
    @

  ldError.prototype = Object.create(Error.prototype) <<< do
    name: \ldError
  if module? => module.exports = ldError
  if window => window.ldError = ldError
)!
