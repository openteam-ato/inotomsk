@show_alert_message = (data) ->
  if $.fn.dialog
    $("<div id='alert-modal-dialog'></div>").appendTo("body").hide().html data.responseText.replace(/<head([\s\S]*)\/head>/im, '')
    $("#alert-modal-dialog").dialog
      title: "Ошибка!",
      width: 1000,
      height: 500,
      modal: true,
      resizable: false,
      close: ->
        $(this).remove()
