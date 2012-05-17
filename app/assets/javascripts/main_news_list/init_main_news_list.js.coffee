@init_main_news_list = ->
  main_news_list_manipulate()
  main_news_scroll()

main_news_list_manipulate = ->
  $(".news_container .news_list ul li").removeClass "selected"
  $(".news_container .news_list ul li:first").addClass "selected"
  image_container = $(".news_container .picture")
  $(".news_container .news_list ul li .title a").hover ->
    $this = $(this)
    unless $("img", image_container).attr("src") is $("img", $this.closest("li")).attr("src")
      $("img", image_container).stop(true).animate
        opacity: 0.2
      , 100, ->
        $("img", image_container).attr "src", $("img", $this.closest("li")).attr("src")
        $("img", image_container).attr "width", $("img", $this.closest("li")).attr("width")
        $("img", image_container).attr "height", $("img", $this.closest("li")).attr("height")
        $("img", image_container).stop(true).animate
          opacity: 1
        , 250

      $(".description .text", image_container).html $(".annotation", $(this).closest("li")).html()
      $(".description .date", image_container).html $(".date", $(this).closest("li")).html()
      $("li", $(this).closest("ul")).removeClass "selected"
      $(this).closest("li").addClass "selected"

main_news_scroll = ->
  if $.fn.jScrollPane
    $(".news_section .news_container .news_list").jScrollPane
      showArrows: true
      verticalGutter: 0
