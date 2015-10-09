@init_map = ->
  ymaps.ready ->
    $map = $('.map_wrapper .map')
    map = new ymaps.Map $map[0],
      #center: [parseFloat($('.map_wrapper').attr('data-latitude')), parseFloat($('.map_wrapper').attr('data-longitude'))]
      center: [56.457573, 84.954303]
      zoom: 11
      behaviors: ['drag', 'scrollZoom']
      controls: []
    ,
      maxZoom: 23
      minZoom: 5

    map.controls.add 'zoomControl',
      float: 'none'
      position:
        top: 10
        left: 20

    update_address_wrapper = ->
      $('.addresses_wrapper').empty()
      map.geoObjects.each (geoObject) ->
        coords = geoObject.geometry.getCoordinates()
        $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_latitude' name='placemark[address][latitude][]' type='hidden' value='#{coords[0]}'>")
        $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_longitude' name='placemark[address][longitude][]' type='hidden' value='#{coords[1]}'>")

    create_new_placemark = (coords) ->
      placemark = new ymaps.Placemark coords
      map.geoObjects.add placemark
      placemark.events.add 'click', (e) ->
        map.geoObjects.remove e.get('target')
        update_address_wrapper()

    if $('.form_wrapper').length
      $('.coords').each (index, item) ->
        coords = [$(item).find('.latitude').val(), $(item).find('.longitude').val()]
        create_new_placemark(coords)

      map.events.add 'click', (e) ->
        update_address_wrapper()
        $('#placemark_address').parent().parent().parent().find(".help-inline").remove()
        coords = e.get('coords')
        create_new_placemark(coords)
        $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_latitude' name='placemark[address][latitude][]' type='hidden' value='#{coords[0]}'>")
        $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_longitude' name='placemark[address][longitude][]' type='hidden' value='#{coords[1]}'>")

        ymaps.geocode(coords).then (res) ->
          address = res.geoObjects.get(0)
          $('#placemark_address').val(address.properties.get('name'))

      $('.direct_geocode').click ->
        update_address_wrapper()
        ymaps.geocode($('#placemark_address').val(), results: 1).then (res) ->
          result = res.geoObjects.get(0)
          if result
            coords = result.geometry.getCoordinates()
            $('#placemark_address').parent().parent().parent().find(".help-inline").remove()
            create_new_placemark(coords)
            $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_latitude' name='placemark[address][latitude][]' type='hidden' value='#{coords[0]}'>")
            $('.addresses_wrapper').append("<input class='hidden' id='placemark_address_longitude' name='placemark[address][longitude][]' type='hidden' value='#{coords[1]}'>")
          else
            $('#placemark_address').parent().find(".help-inline").remove()
            $('#placemark_address').parent().append('<span class="help-inline">не найден адрес</span>')

    if $('.placemark_list').length
      clusterer = new ymaps.Clusterer
        preset: 'islands#grayClusterIcons'
        clusterDisableClickZoom: true
        showInAlphabeticalOrder: true
        hideIconOnBalloonOpen: false
        clusterBalloonContentLayout: 'cluster#balloonCarousel'
        clusterBalloonPagerType: 'marker'
        clusterBalloonContentLayoutWidth: 210
        clusterBalloonContentLayoutHeight: 240

      $('.placemark_list_item').each (index, item) ->
        coords = [$(item).attr('data-latitude'), $(item).attr('data-longitude')]
        title = [$(item).attr('data-title')]
        contentBody = "<div>
                        <div class='balloon_content_header' style='margin:5px 0;padding-bottom:5px;'>
                          #{title}
                        </div>
                      </div>"

        point = new ymaps.GeoObject
          geometry:
            type: 'Point'
            coordinates: coords
          properties:
            balloonContentBody: contentBody
            hintContent: title
        ,
          iconLayout: 'default#image'
          iconImageHref: $(item).attr('data-icon')
          hideIconOnBalloonOpen: false
          iconImageSize: [42, 56]
          iconImageOffset: [-18, -18]
          hasHint: false

        clusterer.add point
        true

      map.geoObjects.add clusterer

  true
