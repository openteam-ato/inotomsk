@init_poll_results = ->
  $(".voting p a").click ->
    link = $(this)
    result = $("<div/>",
      id: "ajax_result"
    ).appendTo("body").hide()
    $.ajax
      url: link.attr("href")
      beforeSend: (jqXHR, settings) ->
        link.addClass "run_ajax"

      success: (data, textStatus, jqXHR) ->
        result.html $(data).filter(".body").html()
        $("div.top_art", result).remove()
        $("form#formAnswerOneMore", result).remove()
        $("div.statQ", result).remove()
        $("table th div.sortTypes", result).remove()
        $("div.anketaFooter", result).remove()
        $("div.bottom_art", result).remove()
        $("div.anchor, p.anchor", result).remove()
        result.html result.html().replace(/\t/g, "  ").replace(/(\n)+/g, "$1")
        $("table td img", result).each (index, el) ->
          $(el).attr "src", "/assets/stat_bar.png"

        $("table td.resultRow", result).each (index, el) ->
          $(el).html $(el).html().split("<br>")[0]

        link.removeClass "run_ajax"
        result.dialog
          title: link.text()
          width: 600
          modal: true
          resizable: false
          close: (event, ui) ->
            $(this).parent().remove()
            $(this).remove()

    false
