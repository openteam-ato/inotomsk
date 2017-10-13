@init_collapse = ->
  for element in $(".collapsed-items-wrapper")
    link = $(element).find(".collapse-link")
    link.attr "data-toggle": "collapse"

  # auto wrapper for collapser div
  collapser = $(".js-simple-collapser")
  collapser.addClass("collapser")
  collapser.wrap("<div class='js-client-collapser'></div>")
  collapser.find("h5").wrap("<div class='list-header'></div>").wrapInner("<a class='js-collapse-link'></a>").append("<span class='collapser-circle'></span>")
  content = collapser.find("div.collapser-content").addClass("collapse js-collapse-content").wrapInner("<div class='well'></div>")

  $(".js-client-collapser .collapser").each (index, element) ->
    link = $(element).find(".js-collapse-link")
    link.attr "data-toggle" : "collapse", "href" : "#collapseContent-#{index}", "aria-expanded" : "false", "aria-controls" : "collapseContent-#{index}"
    content = $(element).find(".js-collapse-content")
    content.attr "id" : "collapseContent-#{index}", "aria-expanded" : "false"


  collapser.each (index, element)->
    $('.collapser-circle', element).on "click", (event) ->
      $('h5 > a', element).click()

  # Set hashes and some replaces for it
  clear_anchor = (str) ->
    str.replace("(","").replace(")","").replace('«',"").replace('»', "").replace("-", "_")

  $('.js-set-url-anchor').each (index, element) ->
    anchor = $(this).attr('id')

    unless anchor
      $(this).append("<span class='js-hidden-element hidden'></span>")
      hidden_element = $('.js-hidden-element')

      linko = $(this).find('> .list-header > h5 > a')
      linko.text(linko.text().compact())
      translit =  linko.liTranslit(
        elAlias: hidden_element
      )

      if hidden_element.text()
        $(this).attr('id', clear_anchor(hidden_element.text()))
        anchor = $(this).attr('id')
        hidden_element.remove()

  collapser.on "show.bs.collapse", (event) ->
    $(event.currentTarget).addClass('collapser-opened')

  collapser.on "hide.bs.collapse", (event) ->
    $(event.currentTarget).removeClass('collapser-opened')

  #auto scroll for collapse
  if window.location.hash.length
    hash_data = "#{window.location.hash.slice(1)}"

    active_collapser = $("##{hash_data}")
    if active_collapser.length
      active_collapser.find('.js-collapse-link').click()
