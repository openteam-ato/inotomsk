@init_layers = ->
  $('.js-toggle-layers').click ->
    $(this).toggleClass('glyphicon-chevron-down glyphicon-chevron-up')
    $(this).parent().toggleClass('show_children')

    false
