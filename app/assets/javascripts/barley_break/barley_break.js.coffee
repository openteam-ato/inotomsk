@init_caruselko = ->
  $('.barley_break ul li').each (index, element) ->
    $element = $(element)
    klass = $("a", element).attr("class")
    $("a", element).removeClass()
    $index = index + 1
    $element.addClass(klass)
    $("<span class='counter counter_#{$index}'>#{$index}</span>").prependTo($element)
    offset_x = 2
    offset_x = 184 if $index in [2, 6, 10, 14]
    offset_x = 366 if $index in [3, 7, 11, 15]
    offset_x = 548 if $index in [4, 8, 12, 16]
    offset_y = 2
    offset_y = 184 if $index >= 5  and index <= 8
    offset_y = 366 if $index >= 9  and index <= 12
    offset_y = 548 if $index >= 13 and index <= 16
    $element.css
      "left": offset_x
      "top": offset_y
