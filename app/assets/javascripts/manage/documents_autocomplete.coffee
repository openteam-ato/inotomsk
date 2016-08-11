@init_documents_autocomplete = ->

  init = ->
    $('.js-document-autocomplete').each ->
      field = $(this)
      current = field.data('current')

      $('.js-document-autocomplete').autocomplete
        source: "/workplace/documents/related_documents?current=#{current}"
        appendTo: $('.js-autocomplete-append')
        select: (event, ui) ->
          $('.js-document-id', event.target.closest('.fields')).val(ui.item.id)
          return

      return

    return

  $(document).on 'nested:fieldAdded', (event) ->
    init()

    return

  init()

  return
