/* This is a manifest file that'll be compiled into application.js, which will include all the files
 * listed below.
 *
 * Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
 * or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
 *
 * It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
 * the compiled file.
 *
 * WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
 * GO AFTER THE REQUIRES BELOW.
 *
 *= require jquery
 *= require jquery-ui
 *= require jquery_ujs
 *= require jquery.caruselko
 *= require jquery.mousewheel
 *= require jquery.jscrollpane
 *= require charts
 */

function preload_images(images) {
  $("<div/>")
    .addClass("images_preload")
    .appendTo("body")
    .css({
      "position": "absolute",
      "bottom": 0,
      "left": 0,
      "visibility": "hidden",
      "z-index": -9999
    });
  $.each(images, function(index, value) {
    $("<img src='" + value + "' />").appendTo($(".images_preload"));
  });
};

function init_caruselko() {
  if ($.fn.caruselko) {
    $('.targets').caruselko();
  };
};

function init_main_news_list() {
  $('.news_container .news_list ul li').removeClass('selected');
  $('.news_container .news_list ul li:first').addClass('selected');
  var image_container = $('.news_container .picture');
  $('.news_container .news_list ul li .title a').hover(function () {
    $('img', image_container).attr('src', $('img', $(this).closest('li')).attr('src'));
    $('.description .text', image_container).html($('.annotation', $(this).closest('li')).html());
    $('.description .date', image_container).html($('.date', $(this).closest('li')).html());
    $('li', $(this).closest('ul')).removeClass('selected');
    $(this).closest('li').addClass('selected');
  });
};

function init_main_news_scroll() {
  if ($.fn.jScrollPane) {
    $('.news_section .news_container .news_list').jScrollPane({
      showArrows: true,
      verticalGutter: 0
    });
  };
};

function poll_results() {
  $('.voting p a').click(function() {
    var link = $(this);
    var result = $('<div/>', { id: 'ajax_result' }).appendTo('body').hide();
    $.ajax({
      url: link.attr('href'),
      beforeSend: function(jqXHR, settings) {
        link.addClass('run_ajax');
      },
      success: function(data, textStatus, jqXHR) {
        result.html($(data).filter('.body').html());
        $('div.top_art', result).remove();
        $('form#formAnswerOneMore', result).remove();
        $('div.statQ', result).remove();
        $('table th div.sortTypes', result).remove();
        $('div.anketaFooter', result).remove();
        $('div.bottom_art', result).remove();
        $('div.anchor, p.anchor', result).remove();
        result.html(result.html().replace(/\t/g, '  ').replace(/(\n)+/g, '$1'));
        $('table td img', result).each(function(index, el) {
          $(el).attr('src', '/assets/stat_bar.png');
        });
        $('table td.resultRow', result).each(function(index, el) {
          $(el).html($(el).html().split('<br>')[0]);
        });
        link.removeClass('run_ajax');
        result.dialog({
          title: link.text(),
          width: 600,
          modal: true,
          resizable: false,
          close: function(event, ui) {
            $(this).parent().remove();
            $(this).remove();
          }
        });
      }
    });
    return false;
  });
};

function show_alert_message(data) {
  $("<div id='alert-modal-dialog'></div>").appendTo("body").hide().html(data.responseText.replace(/<head([\s\S]*)\/head>/im, ''));
  $("#alert-modal-dialog").dialog({
    title: "Ошибка!",
    width: 1000,
    height: 500,
    modal: true,
    resizable: false,
    close: function() {
      $(this).remove();
    }
  });
};

function change_events_list(page) {
  page = typeof page !== 'undefined' ? page : 0;
  $.ajax({
    url: '?parts_params[news_list][events_page]=' + page + '&region=event_list',
    type: 'GET',
    success: function(data, textStatus, jqXHR) {
      $('.calendar .timeline').html(jqXHR.responseText);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      show_alert_message(jqXHR);
    }
  });
};

function events_manipulate() {
  var events_page = 0;
  $('.calendar .right').click(function() {
    events_page += 1;
    change_events_list(events_page);
    return false;
  });
  $('.calendar .left').click(function() {
    events_page -= 1;
    change_events_list(events_page);
    return false;
  });
};

$(function() {
  preload_images([
    "/assets/ajax_loading.gif"
  ]);
  init_caruselko();
  init_main_news_list();
  init_main_news_scroll();
  poll_results();
  events_manipulate();
});
