@init_road_map_nav = ->
  $('.js-road-map-nav').change ->
    $(this).parent().parent().submit()

    true
  true
