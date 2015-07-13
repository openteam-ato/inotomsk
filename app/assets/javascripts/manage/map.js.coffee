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

    true
