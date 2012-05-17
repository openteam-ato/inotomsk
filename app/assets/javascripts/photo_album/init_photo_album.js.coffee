@init_photo_album = ->
  container = $(".photo_album_show")
  if container.length
    links_to_images = $(".thumbnails a", container)
    links_array = new Array()
    $.each links_to_images, ->
      links_array.push $(this).attr("href")

    preload_images links_array
    $(".thumbnails a", container).click ->
      link = $(this)
      li = link.closest("li")
      target_src = link.attr("href")
      target_size = target_src.match(new RegExp(/\d+-\d+/))[0].split("-")
      target_width = target_size[0]
      target_height = target_size[1]
      target_description = $("img", link).attr("alt")
      source_img = $(".image img", container)
      source_description = $(".description", container)
      li.siblings().removeClass "selected"
      li.addClass "selected"
      source_img.stop(true, true).animate
        opacity: "0"
      , 300, ->
        $(this).animate
          width: target_width
          height: target_height
        , 200, ->
          $(this).attr(
            src: target_src
            width: target_width
            height: target_height
            alt: target_description
          ).animate
            opacity: "1"
          , 300, ->
            if target_description
              source_description.html target_description
            else
              source_description.html "&nbsp;"

      false
