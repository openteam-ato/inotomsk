@init_barley_break_filter = ->
  $(".organizations_search_form .search_sphere_wrapper ul li label").addClass("hyphenate")
  $(".organizations_search_form .search_status_wrapper ul li label").addClass("hyphenate")
  Hyphenator.run()

  $(".organizations_search_form .pseudo_submit").click ->
    $(this).closest("form").submit()
    return false

  $(".organizations_search_form .search_field_wrapper label").click ->
    $(this).prev(".search_field").focus()
    return false
