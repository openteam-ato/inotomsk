@init_tags = ->

  console.log '1'
  $('.js-tags').tagsInput
    autocomplete_url: '/workplace/documents/tags_list'
    autocomplete:
      selectFirst: true,
      width: '100px',
      autoFill: true
    #typeahead:
      #source: (query) ->
    #freeInput: true

  return
