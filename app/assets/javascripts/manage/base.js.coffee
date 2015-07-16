@init_manage = ->
  $('.show_children').click ->
    $(this).toggleClass('glyphicon-minus glyphicon-plus')
    $(this).parent().find('.children_list').toggleClass('hidden')
