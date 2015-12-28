@init_tags = ->

  $('.js-tags').tagsInput
    'autocomplete_url': '/workplace/documents/tags_list'
    'autocomplete':
      'selectFirst': true,
      'width': '100px',
      'autoFill': true
    'defaultText': 'добавить'
    'width':'100%'

  return
