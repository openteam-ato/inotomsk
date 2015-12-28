@init_manage = ->
  toggle_term_period = (button) ->
    switch button.val()
      when 'quarter'
        $('.term_period').find('#event_start_year').css('display', 'none')
        $('.term_period').find('#event_quarter').css('display', 'inline-block')
      when 'period'
        $('.term_period').find('#event_start_year').css('display','inline-block')
        $('.term_period').find('#event_quarter').css('display','none')

  $('.show_children').click ->
    $(this).toggleClass('glyphicon-minus glyphicon-plus')
    $(this).parent().find('.children_list').toggleClass('hidden')

  $('#event_term_type').change ->
    toggle_term_period($(this))
    true

  toggle_term_period($('#event_term_type'))
