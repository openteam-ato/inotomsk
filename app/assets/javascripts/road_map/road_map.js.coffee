@init_road_map_nav = ->
  $('.js-road-map-nav').change ->
    ids =[]
    $('.js-road-map-nav').each (index, element) ->
      ids.push($(element).attr('id')) if $(element).is(':checked')

    $('.js-table tbody').find('tr').removeClass("hidden")

    return if ids.length == 0

    $('.js-table tbody').find('tr').addClass("hidden")

    $(ids).each (index,id) ->
      console.log id
      $('.js-table tbody').find(".js-#{id}").removeClass("hidden")
