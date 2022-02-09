
lderror.handler = (o={}) ->
  # _i: list of id to ignore
  @i = (o.ignore or []) ++ [999]
  @h = o.handler
  @r = o.rule or (->it)
  @s = {}
  h = (e) ~>
    if (i = lderror.id(e)) in @i => return
    @s[i] = 1
    @h(@r i).then ~> @s[i] = 0
    if !i => console.log e
  h.is-on = ~> !![v for k,v of @s].filter((v)->v).length
  h

