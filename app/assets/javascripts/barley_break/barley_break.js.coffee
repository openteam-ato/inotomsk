@init_barley_break = ->

  restore_from_cookie() if $.cookie "barley_break_list"

  $(".barley_break ul li").each (index, element) ->
    $element = $(element)
    unless $.cookie "barley_break_list"
      klass = $("a", element).attr("class")
      $("a", element).removeClass()
      $element.addClass(klass)
      $("<span class='counter'></span>").prependTo($element)
    $element.css
      "left": get_offset(index + 1).offset_x
      "top": get_offset(index + 1).offset_y

  unless $(".barley_break ul li.empty").length
    $("<li class='empty'><p>empty</p></li>").appendTo($(".barley_break ul")).css
      "left": 548
      "top": 548

  $(".barley_break .shuffle a").click ->
    shuffle_list()
    false

restore_from_cookie = ->
  list = $.cookie("barley_break_list").split(",")
  $(list).each (index, element) ->
    console.log element
    unless element == "empty"
      link = $(".barley_break ul .#{element}").removeClass(element)
      li = link.closest("li").addClass(element)
      $("<span class='counter'></span>").prependTo(li)
      li.appendTo($(".barley_break ul"))
    else
      $("<li class='empty'><p>empty</p></li>").appendTo($(".barley_break ul"))

save_to_cookie = ->
  list = new Array
  $(".barley_break ul li").each (index, element) ->
    list.push $(element).attr("class")
  $.cookie "barley_break_list", list, { expires: 365 }

shuffle_list = ->
  $(".barley_break ul").shuffle()
  $(".barley_break ul li").each (index, element) ->
    $element = $(element)
    $element.stop(true,true).sleep(30 * index).animate
      "left": get_offset(index + 1).offset_x
      "top": get_offset(index + 1).offset_y
    , 300, 'easeOutBack', ->
      save_to_cookie()

get_offset = (index) ->
  offset_x = 2
  offset_x = 184 if index in [2, 6, 10, 14]
  offset_x = 366 if index in [3, 7, 11, 15]
  offset_x = 548 if index in [4, 8, 12, 16]
  offset_y = 2
  offset_y = 184 if index >= 5  and index <= 8
  offset_y = 366 if index >= 9  and index <= 12
  offset_y = 548 if index >= 13 and index <= 16
  { "offset_x": offset_x, "offset_y": offset_y }
