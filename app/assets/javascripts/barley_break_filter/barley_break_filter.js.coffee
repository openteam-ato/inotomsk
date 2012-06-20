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

  if $(".organizations_search_form .search_field_wrapper .search_field").val() != ""
    $(".organizations_search_form .search_field_wrapper label").hide()

  $(".organizations_search_form .search_field_wrapper .search_field")
  .focusin ->
    $(this).next("label").hide() if $(this).val() == ""
  .focusout ->
    $(this).next("label").show() if $(this).val() == ""

  $(".organizations_search_form .reset a").click ->
    $("input", $(this).parent(".reset").next("ul")).each (index, element) ->
      $(element).removeAttr("checked")
    return false
