@init_fileupload = ->
  readURL = (input,image) ->
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        $(input).parent().parent().next('.preview_image').attr 'src', e.target.result
        return

      reader.readAsDataURL input.files[0]
    return

  $('#map_layer_icon, #map_layer_hover_icon, #placemark_logotype').change ->
    readURL this
    return
