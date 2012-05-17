@init_events_list = ->
  $(".calendar .right a, .calendar .left a").live "click", ->
    return false  if $(this).parent().hasClass("disabled")
    change_events_list this
    false

change_events_list = (link) ->
  loader = new Object()
  position = $(link).parent().attr("class")
  $.ajax
    type: "GET"
    url: $(link).attr("href")
    data:
      region: "event_list"

    beforeSend: (jqXHR, settings) ->
      loader = set_event_ajax_loader(position)

    success: (data, textStatus, jqXHR) ->
      $(".calendar_section .calendar").html jqXHR.responseText
      loader.remove()

    error: (jqXHR, textStatus, errorThrown) ->
      show_alert_message jqXHR
      loader.remove()

set_event_ajax_loader = (position) ->
  loader = $("<div />").addClass("run_ajax").css
    top: "115px"
    position: "-8px"
  loader.css "right", "-8px"  if position is "right"
  loader.css "left", "-8px"  if position is "left"
  $(".calendar .timeline").before loader
  loader
