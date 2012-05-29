@init_presentation = ->

  if $.browser.msie and $.browser.version <= 7
    alert "У Вас устаревший браузер!\nПросмотр информации о проекте невозможен."
    return false

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
      fade_speed = if $.browser.msie and $.browser.version == '8.0' then 0 else 500
      $(".presentation .bg_image").fadeOut fade_speed, ->
        $(this).removeClass().addClass("bg_image #{klass}_bg").fadeIn fade_speed
      presentation_title.animate
        "right": "-=500"
      , 500, "easeInBack", ->
        move_main_slides()
      show_inner_slides($(this))

  $('.presentation .inner_wrapper .inner_slide').click ->
    $this = $(this)
    main_slide = $this.closest(".inner_wrapper")
    main_slide_class = main_slide.attr("class")
      .replace("inner_wrapper", "")
      .strip()
    visible_siblings = $(this).siblings(".inner_slide:visible")
    slide_klass = $this.attr("class")
      .replace(" inner_slide", "")
      .strip()
    view_block = $(".view_#{slide_klass}", main_slide)
    return false unless view_block.length
    show_slide_dialog($("h3", $this).text(), view_block, main_slide_class)

show_slide_dialog = (title, block, header_class) ->
  $("<div />", { "class": "slide_dialog_overlay" }).appendTo("body") unless $("div.slide_dialog_overlay").length
  overlay = $("div.slide_dialog_overlay")
  overlay.css
    "height": $("body").outerHeight()
  $("<div />", { "class": "slide_dialog_wrapper" }).appendTo("body") unless $("div.slide_dialog_wrapper").length
  dialog_wrapper = $("div.slide_dialog_wrapper")
  dialog_wrapper
    .css
      "left": $("body").outerWidth() / 2 - dialog_wrapper.outerWidth() / 2
  $("<div />", { "class": "slide_dialog_top" }).appendTo(dialog_wrapper)
  $("<a href='' class='close'>close</a>").appendTo($(".slide_dialog_top"))
  $("<div />", { "class": "slide_dialog_header #{header_class}" }).appendTo(dialog_wrapper)
  $("<a href='' class='prev'>prev</a>").appendTo($(".slide_dialog_header"))
  $("<a href='' class='next'>next</a>").appendTo($(".slide_dialog_header"))
  $("<h1>#{title}</h1>").appendTo($(".slide_dialog_header"))
  $("<div />", { "class": "slide_dialog_content" }).appendTo(dialog_wrapper)
  dialog_content = $(".slide_dialog_content")
  console.log block.attr("class")
  dialog_content.html(block.html())
  $("body").keypress (event) ->
    if event.keyCode == 27
      $("body").unbind "keypress"
      remove_slide_dialog()
  $("div.slide_dialog_overlay").click ->
    remove_slide_dialog()
  $(".slide_dialog_top .close").click ->
    remove_slide_dialog()
    false

remove_slide_dialog = ->
  $("div.slide_dialog_overlay").remove()
  $("div.slide_dialog_wrapper").remove()

move_main_slides = ->

  for index in [1..4]
    main_slide = $(".main_slide_#{index}")
    selected_offset = if main_slide.hasClass("selected") then 15 else 0
    single_line_offset = if index == 1 or index == 3 then 8 else 0

    main_slide.addClass("minimazed").sleep(100 * (index - 1)).css
      "z-index": 1
    .animate
      "top": -171 + selected_offset
      "width": 200
      "right": 0
      "left": 220 * index - 190
    , 500, "easeOutBack", ->
      $(this).hover ->
        $(this).stop(true, true).animate
          top: "+=15px"
        , 100 unless $(this).hasClass("selected")
      , ->
        $(this).stop(true, true).animate
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
  klass = block.attr("class")
    .replace("minimazed", "")
    .strip()

  fade_speed = if $.browser.msie and $.browser.version == '8.0' then 0 else 1000

  block.addClass("selected").css
    top: "-156px"

  $(".presentation .bg_image").stop(true, true).fadeOut fade_speed, ->
    $(this).remove()

  $("<div />").prependTo(".presentation .inside_wrapper").hide()
  .addClass("bg_image #{klass}_bg").stop(true, true).fadeIn fade_speed
  hide_inner_slides()
  show_inner_slides(block, 500)

hide_inner_slides = ->
  visible_block = $(".presentation .inner_wrapper:visible")
  slide_name = visible_block.attr("class")
    .replace("inner_wrapper ", "")
    .strip()
  switch slide_name
    when "slide_1" then left_offset = 30
    when "slide_2" then left_offset = 250
    when "slide_3" then left_offset = 470
    when "slide_4"
      $(".slide_4 .slide_submenu").fadeOut(500)
      $(".slide_4 .slide_submenu li").removeClass("selected")
      $(".slide_4 .slide_submenu li:first").addClass("selected")
      left_offset = 690
  $(".slide_name", visible_block).stop(true, true).animate
    "right": "-=700"
  , 500, "easeInBack"
  $(".inner_slide", visible_block).each (index, element) ->
    $(element).sleep(100 * index).fadeOut 300, ->
      $(this).css
        "top": -210
        "left": left_offset
      .show()
      visible_block.hide()

show_inner_slides = (block, sleep_interval = 1500) ->
  klass = block.attr("class")
    .replace("main_", "")
    .replace("selected", "")
    .replace("minimazed", "")
    .strip()
  block = $(".inner_wrapper.#{klass}")
  block.show()
  $(".slide_name", block).stop(true, true).sleep(1000 + sleep_interval).animate
    "right": "+=700"
  , 500, "easeOutBack"
  $(".presentation .inside_wrapper").animate
    "min-height": 1000
  , 500
  slides = $(".inner_slide", block).hide()
  slide_with_submenu_offset = 0
  if klass == "slide_4"
    slide_with_submenu_offset = 60
    $(".slide_submenu", block).sleep(1000 + sleep_interval).fadeIn(500)
    handle_slide_submenu(block, sleep_interval)
    slide_number = $(".slide_submenu .selected", block).attr("class")
      .replace("selected", "")
      .replace("submenu_", "")
      .strip()
    matches = []
    $(".inner_slide", block).each (index, element) ->
      matches.push $(element)[0] if $(element).attr("class").match(new RegExp("\^inner_slide_#{slide_number}\\d+", "g"))
    slides = $(matches)

  slides.each (index, element) ->
    switch (index) % 3
      when 0 then left_offset = 100
      when 1 then left_offset = 354
      when 2 then left_offset = 608
    top_offset = 200 if index >= 0 and index <= 2
    top_offset = 440 if index >= 3 and index <= 5
    top_offset = 680 if index >= 6 and index <= 8
    $(element).sleep(sleep_interval + (100 * index)).show().animate
      "top": top_offset + slide_with_submenu_offset
      "left": left_offset

handle_slide_submenu = (block, sleep_interval) ->
  $(".slide_submenu a", block).click ->
    unless $(this).closest("li").hasClass("selected")
      $(this).closest("li").addClass("selected")
      $(this).closest("li").siblings("li").removeClass("selected")
      $(".inner_slide:visible", block).each (index, element) ->
        $(element).sleep(100 * index).fadeOut 300, ->
          $(this).show().hide().css
            "top": -210
            "left": 470
      slide_with_submenu_offset = 60
      slide_number = $(".slide_submenu .selected", block).attr("class")
        .replace("selected", "")
        .replace("submenu_", "")
        .strip()
      matches = []
      $(".inner_slide", block).each (index, element) ->
        matches.push $(element)[0] if $(element).attr("class").match(new RegExp("\^inner_slide_#{slide_number}\\d+", "g"))
      slides = $(matches)

      slides.each (index, element) ->
        switch (index) % 3
          when 0 then left_offset = 100
          when 1 then left_offset = 354
          when 2 then left_offset = 608
        top_offset = 200 if index >= 0 and index <= 2
        top_offset = 440 if index >= 3 and index <= 5
        top_offset = 680 if index >= 6 and index <= 8
        $(element).sleep(500 + 100 * index).show().animate
          "top": top_offset + slide_with_submenu_offset
          "left": left_offset
    false

$.fn.sleep = (time) ->
  obj = $(this)
  obj.queue ->
    setTimeout ->
      obj.dequeue()
    , time

if typeof(String.prototype.strip) == "undefined"
  String.prototype.strip = ->
    String(this).replace(/^\s\s*/, "").replace(/\s\s*$/, "")
