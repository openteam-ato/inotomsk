$ ->
  init_manage() if $('.manage_wrapper').length
  init_map() if $('.map_wrapper').length
  init_fileupload() if $('.form_wrapper').length
  init_tags() if $('.js-tags').length

  false
