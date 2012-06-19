$ ->
  preload_images [
    '/assets/ajax_loading.gif'
  ]

  init_charts() if $(".chart").length
  init_presentation() if $('.about_project .presentation').length
  init_caruselko() if $('.targets').length
  init_events_list() if $(".calendar").length
  init_poll_results() if $(".voting").length
  init_main_news_list() if $('.news_container .news_list').length
  init_photo_album() if $('.photo_album_show').length
  init_barley_break() if $('.barley_break').length
  init_barley_break_inner_nav() if $('.barley_break_nav .navigation').length

  false
