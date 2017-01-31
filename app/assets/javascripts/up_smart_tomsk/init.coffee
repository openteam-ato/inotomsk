@init_up_smart_tomsk = ->

  ['h1', 'a'].forEach (item, i, arr) ->
    elem = $("#{item}:contains('SMART TechnologiesTomsk')")
    text = elem.text().replace('TechnologiesTomsk»', 'Technologies')
    elem.text(text).append('<sup>Tomsk</sup>»')
    if elem.is('h1')
      elem.addClass 'padding-top-10'
    return

  return
