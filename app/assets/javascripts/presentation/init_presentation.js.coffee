@init_presentation = ->

  if $.browser.msie and $.browser.version <= 7
    alert "У Вас устаревший браузер!\nПросмотр информации о проекте невозможен."
    return false

  preload_images [
    "/assets/presentation/main_slide_1_bg.jpg",
    "/assets/presentation/main_slide_2_bg.jpg",
    "/assets/presentation/main_slide_3_bg.jpg",
    "/assets/presentation/main_slide_4_bg.jpg"
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

  $(".presentation .inner_wrapper .inner_slide").click ->
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
    show_slide_dialog(slide_klass, main_slide_class)

show_slide_dialog = (slide_klass, header_class) ->
  $("<div />", { "class": "slide_dialog_overlay" }).appendTo("body") unless $("div.slide_dialog_overlay").length
  overlay = $("div.slide_dialog_overlay").hide()
  overlay.css
    "height": $("body").outerHeight()
  .fadeIn 1000
  title = $(".#{slide_klass} h3").text()
  $("<div />", { "class": "slide_dialog_wrapper" }).appendTo("body") unless $("div.slide_dialog_wrapper").length
  dialog_target_top = $(".presentation").position().top + $(".presentation .inner_wrapper .#{slide_klass}").position().top
  dialog_target_left = $(".presentation").position().left + $(".presentation .inner_wrapper .#{slide_klass}").position().left
  dialog_target_width = $(".presentation .inner_wrapper .#{slide_klass}").outerWidth()
  dialog_target_height = $(".presentation .inner_wrapper .#{slide_klass}").outerHeight()
  dialog_wrapper = $("div.slide_dialog_wrapper").css
    "opacity": "0"
    "top": dialog_target_top
    "left": dialog_target_left
    "width": dialog_target_width
    "height": dialog_target_height
  $("<div />", { "class": "slide_dialog_top" }).appendTo(dialog_wrapper)
  $("<a href='' class='close'>close</a>").appendTo($(".slide_dialog_top"))
  $("<div />", { "class": "slide_dialog_header #{header_class}" }).appendTo(dialog_wrapper)
  slide_navigation_prev = $("<a href='' class='prev'>prev</a>").appendTo($(".slide_dialog_header")).hide()
  slide_navigation_next = $("<a href='' class='next'>next</a>").appendTo($(".slide_dialog_header")).hide()
  $("<h1>#{title}</h1>").appendTo($(".slide_dialog_header"))
  $("<div />", { "class": "slide_dialog_content" }).appendTo(dialog_wrapper)
  dialog_wrapper.animate
    "width": "780"
    "height": "570"
    "top": "465"
    "left": $("body").outerWidth() / 2 - 390
    "opacity": "1"
  , 500, ->
    dialog_content_height = dialog_wrapper.outerHeight() - $(".slide_dialog_top", dialog_wrapper).outerHeight() - $(".slide_dialog_header", dialog_wrapper).outerHeight()
    dialog_content = $(".slide_dialog_content").css
      "height": dialog_content_height
    list_width = dialog_content.outerWidth() * $(".view_inner_slide", $(".#{header_class}")).length
    dialog_content_list = $("<ul/>").appendTo(dialog_content).css
      "width": list_width
      "height": dialog_content_height
    ul_position = 0
    $(".#{header_class} .inner_slide:visible").each (index, element) ->
      element_klass = $(element).attr("class").replace(" inner_slide", "").strip()
      element_klass = "view_#{element_klass}"
      return true unless $(".#{header_class} .#{element_klass}").length
      element_header = $(".#{header_class} .#{element_klass.replace("view_", "")} h3").text()
      selected_klass = ""
      if element_klass.replace("view_", "") == slide_klass
        ul_position = index * dialog_content.outerWidth()
        selected_klass = " selected"
      html = ""
      html += "<h3 class='hidden'>#{element_header}</h3>"
      html += $(".#{header_class} .#{element_klass}").html()
      $("<li class='#{element_klass}#{selected_klass}'>#{html}</li>").appendTo(dialog_content_list).css
        "width": dialog_content.outerWidth() - 40
        "height": dialog_content_height - 40

    dialog_content_list.css
      "left": - ul_position

    slide_navigation_prev.addClass("disabled") if dialog_content_list.children("li").first().hasClass("selected")
    slide_navigation_next.addClass("disabled") if dialog_content_list.children("li").last().hasClass("selected")

    slide_navigation_prev.fadeIn(300)
    slide_navigation_next.fadeIn(300)

  $("body").keypress (event) ->

    slide_navigation_prev.click() if event.keyCode == 37
    slide_navigation_next.click() if event.keyCode == 39

    if event.keyCode == 27
      $("body").unbind "keypress"
      remove_slide_dialog()
  $("div.slide_dialog_overlay").click ->
    remove_slide_dialog()
  $(".slide_dialog_top .close").live "click", ->
    remove_slide_dialog()
    false

  $(slide_navigation_prev).click ->
    return false if $(this).hasClass("disabled")
    dialog_content_list = $(".slide_dialog_content").children("ul")
    $("li.selected", dialog_content_list).prev("li").addClass("selected").siblings("li").removeClass("selected")
    title = $("li.selected h3", dialog_content_list).text()
    $(".slide_dialog_header h1").stop(true, true).fadeOut 300, ->
      $(this).text(title).fadeIn()
    slide_navigation_prev.addClass("disabled") if dialog_content_list.children("li").first().hasClass("selected")
    slide_navigation_prev.removeClass("disabled") unless dialog_content_list.children("li").first().hasClass("selected")
    slide_navigation_next.addClass("disabled") if dialog_content_list.children("li").last().hasClass("selected")
    slide_navigation_next.removeClass("disabled") unless dialog_content_list.children("li").last().hasClass("selected")
    dialog_content_list.stop(true, true).animate
      "left": "+=#{$('.slide_dialog_content').outerWidth()}"
    , 500, "easeOutExpo"
    false

  $(slide_navigation_next).click ->
    return false if $(this).hasClass("disabled")
    dialog_content_list = $(".slide_dialog_content").children("ul")
    $("li.selected", dialog_content_list).next("li").addClass("selected").siblings("li").removeClass("selected")
    title = $("li.selected h3", dialog_content_list).text()
    $(".slide_dialog_header h1").stop(true, true).fadeOut 300, ->
      $(this).text(title).fadeIn()
    slide_navigation_prev.addClass("disabled") if dialog_content_list.children("li").first().hasClass("selected")
    slide_navigation_prev.removeClass("disabled") unless dialog_content_list.children("li").first().hasClass("selected")
    slide_navigation_next.addClass("disabled") if dialog_content_list.children("li").last().hasClass("selected")
    slide_navigation_next.removeClass("disabled") unless dialog_content_list.children("li").last().hasClass("selected")
    dialog_content_list.stop(true, true).animate
      "left": "-=#{$('.slide_dialog_content').outerWidth()}"
    , 500, "easeOutExpo"
    false

remove_slide_dialog = ->
  $("div.slide_dialog_wrapper").animate
    "width": "210"
    "left": "+=285"
    "top": "+=120"
    "height": "195"
    "opacity": "0"
  , 500, ->
    $(this).remove()
  $("div.slide_dialog_overlay").fadeOut 1000, ->
    $(this).remove()

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
