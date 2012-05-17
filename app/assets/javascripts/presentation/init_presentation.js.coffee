@init_presentation = ->
  trigger_main_items()

trigger_main_items = ->
  speed_animation = 200
  if window.location.hash
    id = window.location.hash
    window.location.hash = ""
    $(".accordion li").removeClass "selected"
    $("a[href=" + id + "]").parents("li").addClass "selected"
    $(".presentation .content div:visible").hide()
    $(".presentation .content " + id).show()
    offset_y = window.scrollY
    window.location.hash = id
    window.scrollTo 0, offset_y
  $(".presentation .accordion li.important").each ->
    $(this).prepend "<span class='icon' />"
    $(".presentation .content " + $("a", this).attr("href") + " h3 ").addClass("important").prepend "<span class='icon' />"

  $(".presentation .accordion > li > p > a").click (e) ->
    link = $(this)
    clicked_item = link.closest("li")
    selected_item = $(".selected", link.closest(".accordion"))
    unless clicked_item.hasClass("selected")
      visible_submenu = $("ul", clicked_item)
      $("ul", clicked_item).slideDown()
      clicked_item.addClass "selected"
      $("ul", selected_item).slideUp()
      selected_item.removeClass "selected"
      if visible_submenu.length
        first_submenu = $("li:first", visible_submenu)
        first_submenu.addClass "selected"
        if $(".presentation .content " + $("a", first_submenu).attr("href")).length
          $(".presentation .content div:visible").fadeOut speed_animation, ->
            $(".presentation .content " + $("a", first_submenu).attr("href")).fadeIn speed_animation
            set_location $("a", first_submenu)
      else
        $(".presentation .content div:visible").fadeOut speed_animation, ->
          $(".presentation .content " + link.attr("href")).fadeIn speed_animation
          set_location link
    e.preventDefault()
    false

  $(".presentation .accordion > li > ul > li > a").click (e) ->
    link = $(this)
    if not link.parent().hasClass("selected") and $(".presentation .content " + link.attr("href")).length
      link.parent().siblings().removeClass "selected"
      link.parent().addClass "selected"
      $(".presentation .content div:visible").fadeOut speed_animation, ->
        $(".presentation .content " + link.attr("href")).fadeIn speed_animation
        set_location link
    e.preventDefault()
    false

set_location = (elem) ->
  offset_y = window.scrollY
  window.location.hash = elem.attr("href")
  window.scrollTo 0, offset_y
