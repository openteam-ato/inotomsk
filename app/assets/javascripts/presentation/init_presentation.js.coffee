@init_presentation = ->
  preload_images [
    "/assets/presentation/main_slide_1_bg.png",
    "/assets/presentation/main_slide_2_bg.png",
    "/assets/presentation/main_slide_3_bg.png",
    "/assets/presentation/main_slide_4_bg.png"
  ]

  $.scrollTo ".presentation", 300,
    axis:"y"
    offset: -20

  presentation_title = $(".presentation_title")

  presentation_title.sleep(1000).animate
    "right": "+=500"
  , 500, "easeOutBack"

  for index in [1..4]
    block = $(".main_slide_#{index}")
    block.sleep(1200 + 150 * index).fadeIn("slow")

    block.click (evnt) ->
      klass = $(this).attr("class")
      $this = $(this).addClass("selected")
      $(".presentation .bg_image").animate
        "opacity": 0
      , 500, ->
        $(this).removeClass().addClass("bg_image #{klass}_bg").animate
          "opacity": 1
        , 500
      presentation_title.animate
        "right": "-=500"
      , 500, "easeInBack", ->
        move_main_slides()
      show_inner_slides($(this))

move_main_slides = ->

  for index in [1..4]
    main_slide = $(".main_slide_#{index}")
    selected_offset = if main_slide.hasClass("selected") then 15 else 0
    single_line_offset = if index == 1 or index == 4 then 8 else 0

    main_slide.addClass("minimazed").sleep(100 * (index - 1)).animate
      "top": -171 + selected_offset
      "width": 200
      "right": 0
      "left": 220 * index - 190
    , 500, "easeOutBack", ->
      $(this).hover ->
        $(this).animate
          top: "+=15px"
        , 100 unless $(this).hasClass("selected")
      , ->
        $(this).animate
          top: "-=15px"
        , 100 unless $(this).hasClass("selected")
      $(this).unbind("click").click ->
        change_main_slide($(this))

    $("h1", main_slide).css
      "margin-top": 150
      "padding-top": 30 + single_line_offset
      "height": 40 - single_line_offset
      "line-height": 1.2
      "-webkit-border-bottom-left-radius": 5
      "-moz-border-bottom-left-radius": 5
      "-ms-border-bottom-left-radius": 5
      "-o-border-bottom-left-radius": 5
      "border-bottom-left-radius": 5
      "-webkit-border-bottom-right-radius": 5
      "-moz-border-bottom-right-radius": 5
      "-ms-border-bottom-right-radius": 5
      "-o-border-bottom-right-radius": 5
      "border-bottom-right-radius": 5
    $("p", main_slide).hide()

change_main_slide = (block) ->
  return false if block.hasClass("selected")

  for index in [1..4]
    main_slide = $(".main_slide_#{index}")
    main_slide.removeClass("selected").css
      top: "-171px"
  klass = block.attr("class").replace(" minimazed", "")

  block.addClass("selected").css
    top: "-156px"

  $(".presentation .bg_image").stop(true, true).animate
    "opacity": 0
  , 1000, ->
    $(this).remove()

  $("<div />").prependTo(".presentation .inside_wrapper").css
    "opacity": 0
  .addClass("bg_image #{klass}_bg").stop(true, true).animate
    "opacity": 1
  , 1000
  hide_inner_slides()
  show_inner_slides(block, 500)

hide_inner_slides = ->
  visible_block = $(".presentation .inner_wrapper:visible")
  slide_name = visible_block.attr("class").replace("inner_wrapper ", "").replace(/^\s\s*/, "").replace(/\s\s*$/, "")
  switch slide_name
    when "slide_1" then left_offset = 30
    when "slide_2" then left_offset = 250
    when "slide_3" then left_offset = 470
    when "slide_4" then left_offset = 690
  $(".slide_name", visible_block).animate
    "right": "-=700"
  , 500, "easeInBack"
  $(".inner_slide", visible_block).each (index, element) ->
    $(element).sleep(100 * index).animate
      "opacity": 0
    , 300, ->
      $(this).css
        "top": -210
        "left": left_offset
        "opacity": 1
      visible_block.hide()

show_inner_slides = (block, sleep_interval = 1500) ->
  klass = block.attr("class").replace("main_", "").replace("selected", "").replace("minimazed", "")
  block = $(".inner_wrapper.#{klass}")
  block.show()
  $(".slide_name", block).sleep(sleep_interval).animate
    "right": "+=700"
  , 500, "easeOutBack"
  $(".presentation .inside_wrapper").animate
    "min-height": 1000
  , 500
  $(".inner_slide", block).each (index, element) ->
    switch (index) % 3
      when 0 then left_offset = 100
      when 1 then left_offset = 354
      when 2 then left_offset = 608
    top_offset = 200 if index >= 0 and index <= 2
    top_offset = 440 if index >= 3 and index <= 5
    top_offset = 680 if index >= 6 and index <= 8
    $(element).sleep(sleep_interval + (100 * index)).animate
      "top": top_offset
      "left": left_offset

$.fn.sleep = (time) ->
  obj = $(this)
  obj.queue ->
    setTimeout ->
      obj.dequeue()
    , time
