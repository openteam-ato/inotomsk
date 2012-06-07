@barley_break_list_solution = []

@init_barley_break = ->

  save_solution()

  if $.cookie "barley_break_list"
    check_valid_cookie()
    restore_from_cookie()

  $(".barley_break ul li").each (index, element) ->
    $element = $(element)
    unless $.cookie "barley_break_list"
      klass = $("a", element).attr("class")
      $("a", element).removeClass()
      $element.addClass(klass)
      $("<span class='counter'></span>").prependTo($element)
    $element.show().css
      "left": get_offset(index + 1).offset_x
      "top": get_offset(index + 1).offset_y

  unless $(".barley_break ul li.empty").length
    $("<li class='empty'><p>empty</p></li>").hide().appendTo($(".barley_break ul")).css
      "left": 548
      "top": 548
  else
    $(".barley_break ul li.empty").hide()

  $(".barley_break .shuffle a").click ->
    shuffle_list()
    false

  render_navigation() if $.cookie "barley_break_list"

  handle_navigation()

check_valid_cookie = ->
  size = $.cookie("barley_break_list").split(",").length
  if size != 16
    alert("Ошибка сохранения расположения!\nКоличество ячеек должно быть равно 16\nСохранено #{size}")
    $.cookie("barley_break_list", @barley_break_list_solution)
    shuffle_list()
    restore_from_cookie()

save_solution = ->
  list = new Array
  $(".barley_break ul li").each (index, element) ->
    list.push $("a", element).attr("class")
  list.push "empty"
  @barley_break_list_solution = list.join(",")

save_to_cookie = ->
  list = new Array
  $(".barley_break ul li").each (index, element) ->
    list.push $(element).attr("class")
  $.cookie("barley_break_list", list, { expires: 365 })
  steps = $.cookie("barley_break_steps")
  if steps
    $.cookie("barley_break_steps", parseInt(steps) + 1, { expires: 365 })
  else
    $.cookie("barley_break_steps", 0, { expires: 365 })
  if $.cookie("barley_break_list") == @barley_break_list_solution
    $(".barley_break ul li .move").remove()
    $.cookie("barley_break_list", null)
    steps = $.cookie("barley_break_steps")
    $.cookie("barley_break_steps", null)
    alert("Поздравляем!\nВы успешно собрали инопятнашки за #{pluralize(steps, { nom: 'шаг', gen: 'шага', plu: 'шагов' })}")

restore_from_cookie = ->
  list = $.cookie("barley_break_list").split(",")
  $(list).each (index, element) ->
    unless element == "empty"
      link = $(".barley_break ul .#{element}").removeClass(element)
      li = link.closest("li").addClass(element)
      $("<span class='counter'></span>").prependTo(li)
      li.appendTo($(".barley_break ul"))
    else
      $("<li class='empty'><p>empty</p></li>").hide().appendTo($(".barley_break ul"))

shuffle_list = ->
  $.cookie("barley_break_test", "success", { expires: 365 })
  if $.cookie("barley_break_test") !=  "success"
    alert("Для возможности играть в наши инопятнашки необходимо включить поддержку cookie!")
    return false
  else
    $.cookie("barley_break_test", null)

  $(".barley_break ul").shuffle()
  save_to_cookie()
  $.cookie("barley_break_steps", 0, { expires: 365 })
  $(".barley_break ul li").each (index, element) ->
    $element = $(element)
    $element.stop(true,true).sleep(100 * index).animate
      "left": get_offset(index + 1).offset_x
      "top": get_offset(index + 1).offset_y
    , 500, 'easeInOutBack', ->
  render_navigation()

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

render_navigation = ->
  empty = $(".barley_break ul li.empty")
  empty_is_left = empty.index() % 4 == 0
  empty_is_right = empty.index() % 4 == 3
  empty_is_top = empty.index() in [0..3]
  empty_is_bottom = empty.index() in [12..15]

  $(".barley_break ul li .move").remove()

  $("<a href='#' class='move to_right'>move to right</a>").appendTo(empty.prev()) unless empty_is_left
  $("<a href='#' class='move to_left'>move to left</a>").appendTo(empty.next()) unless empty_is_right
  $("<a href='#' class='move to_bottom'>move to bottom</a>").appendTo(empty.prev().prev().prev().prev()) unless empty_is_top
  $("<a href='#' class='move to_top'>move to top</a>").appendTo(empty.next().next().next().next()) unless empty_is_bottom

handle_navigation = ->
  $(".barley_break ul li .move").live "click", ->
    empty = $(".barley_break ul li.empty")
    block = $(this).closest("li")
    switch $(this).attr("class").replace("move", "").strip()
      when "to_left"
        block.insertBefore(empty)
        empty.css
          "left": "+=182"
        block.animate
          "left": "-=182"
        , 100, "easeOutCubic", ->
          save_to_cookie()
      when "to_right"
        empty.insertBefore(block)
        empty.css
          "left": "-=182"
        block.animate
          "left": "+=182"
        , 100, "easeOutCubic", ->
          save_to_cookie()
      when "to_top"
        for index in [1..3]
          block.insertBefore(block.prev())
          empty.insertAfter(empty.next())
        empty.insertAfter(empty.next())
        empty.css
          "top": "+=182"
        block.animate
          "top": "-=182"
        , 100, "easeOutCubic", ->
          save_to_cookie()
      when "to_bottom"
        for index in [1..3]
          empty.insertBefore(empty.prev())
          block.insertAfter(block.next())
        block.insertAfter(block.next())
        empty.css
          "top": "-=182"
        block.animate
          "top": "+=182"
        , 100, "easeOutCubic", ->
          save_to_cookie()
    render_navigation()
    return false

pluralize = (num, cases) ->
  num = Math.abs(num)
  word = ""
  if num.toString().indexOf(".") > -1
    word = cases.gen
  else
    word = (if num % 10 is 1 and num % 100 isnt 11 then cases.nom else (if num % 10 >= 2 and num % 10 <= 4 and (num % 100 < 10 or num % 100 >= 20) then cases.gen else cases.plu))
  "#{num} #{word}"
