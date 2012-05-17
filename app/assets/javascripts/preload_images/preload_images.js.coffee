@preload_images = (images) ->
  container = $("div.images_preload")

  unless container.length
    $("<div/>").addClass("images_preload").appendTo("body").css
      "position": "absolute"
      "bottom": -100
      "left": -100
      "visibility": "hidden"
      "z-index": -9999
    container = $("div.images_preload")

  $.each images, (index, value) ->
    $("<img src='" + value + "' />").appendTo container
