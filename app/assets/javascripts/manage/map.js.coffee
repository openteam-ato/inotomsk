@init_map = ->
  ymaps.ready ->
    $map = $('.map_wrapper .map')
    map = new ymaps.Map $map[0],
      center: [parseFloat($('.map_wrapper').attr('data-latitude')), parseFloat($('.map_wrapper').attr('data-longitude'))]
      zoom: 12
      behaviors: ['drag', 'scrollZoom']
      controls: []
    ,
      maxZoom: 23
      minZoom: 11

    map.controls.add 'zoomControl',
      float: 'none'
      position:
        top: 10
        left: 20

    if $('.form_wrapper').length
      map.geoObjects.add new ymaps.Placemark [$('#placemark_latitude').val(), $('#placemark_longitude').val()]

      map.events.add 'click', (e) ->
        map.geoObjects.removeAll()
        $('#placemark_address').parent().parent().parent().find(".help-inline").remove()
        coords = e.get('coords')
        map.geoObjects.add new ymaps.Placemark coords
        $('#placemark_latitude').val(coords[0])
        $('#placemark_longitude').val(coords[1])

        ymaps.geocode(coords).then (res) ->
          address = res.geoObjects.get(0)
          $('#placemark_address').val(address.properties.get('name'))

      $('.direct_geocode').click ->
        map.geoObjects.removeAll()
        ymaps.geocode('Томск'+$('#placemark_address').val(), results: 1).then (res) ->
          result = res.geoObjects.get(0)
          if result
            coords = result.geometry.getCoordinates()
            $('#placemark_address').parent().parent().parent().find(".help-inline").remove()
            map.geoObjects.add new ymaps.Placemark coords
            $('#placemark_latitude').val(coords[0])
            $('#placemark_longitude').val(coords[1])
          else
            $('#placemark_address').parent().parent().parent().find(".help-inline").remove()
            $('#placemark_address').parent().parent().parent().append('<span class="help-inline">не найден адрес</span>')

  true
