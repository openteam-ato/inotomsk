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
  var container = $('div.images_preload');
  if (!container.length) {
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
  };
  $.each(images, function(index, value) {
    $("<img src='" + value + "' />").appendTo(container);
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
    var $this = $(this);
    if ($('img', image_container).attr('src') != $('img', $this.closest('li')).attr('src')) {
      $('img', image_container).stop(true).animate({ opacity: 0.2 }, 100, function() {
        $('img', image_container).attr('src', $('img', $this.closest('li')).attr('src'));
        $('img', image_container).attr('width', $('img', $this.closest('li')).attr('width'));
        $('img', image_container).attr('height', $('img', $this.closest('li')).attr('height'));
        $('img', image_container).stop(true).animate({ opacity: 1 }, 250);
      });
      $('.description .text', image_container).html($('.annotation', $(this).closest('li')).html());
      $('.description .date', image_container).html($('.date', $(this).closest('li')).html());
      $('li', $(this).closest('ul')).removeClass('selected');
      $(this).closest('li').addClass('selected');
    };
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

function set_event_ajax_loader(position) {
  var loader = $('<div />').addClass('run_ajax').css({'top': '115px', position: '-8px'});
  if (position == 'right') loader.css('right', '-8px');
  if (position == 'left') loader.css('left', '-8px');
  $('.calendar .timeline').before(loader);
  return loader;
};

function change_events_list(page, position) {
  page = typeof page !== 'undefined' ? page : 0;
  var loader = new Object();
  $.ajax({
    url: '?parts_params[news_list][events_page]=' + page + '&region=event_list',
    type: 'GET',
    beforeSend: function(jqXHR, settings) {
      loader = set_event_ajax_loader(position);
    },
    success: function(data, textStatus, jqXHR) {
      $('.calendar_section .calendar').html(jqXHR.responseText);
      loader.remove();
    },
    error: function(jqXHR, textStatus, errorThrown) {
      show_alert_message(jqXHR);
      loader.remove();
    }
  });
};

function events_manipulate() {
  var events_page = 0;
  $('.calendar .right a').live('click', function() {
    if ($(this).parent().hasClass('disabled')) return false;
    events_page += 1;
    change_events_list(events_page, $(this).parent().attr('class'));
    return false;
  });
  $('.calendar .left a').live('click', function() {
    if ($(this).parent().hasClass('disabled')) return false;
    events_page -= 1;
    change_events_list(events_page, $(this).parent().attr('class'));
    return false;
  });
};

function photo_album_manipulate() {
  var container = $('.photo_album_show');
  if (container.length) {
    var links_to_images = $('.thumbnails a', container),
        links_array = new Array();
    $.each(links_to_images, function() {
      links_array.push($(this).attr('href'));
    });
    preload_images(links_array);
    $('.thumbnails a', container).click(function() {
      var link = $(this),
          li = link.closest('li'),
          target_src = link.attr('href'),
          target_size = target_src.match(new RegExp(/\d+-\d+/))[0].split('-'),
          target_width = target_size[0],
          target_height = target_size[1],
          target_description = $('img', link).attr('alt'),
          source_img = $('.image img', container),
          source_description = $('.description', container);
      li.siblings().removeClass('selected');
      li.addClass('selected');
      source_img.stop(true, true).animate({
        'opacity': '0'
      }, 300, function() {
        $(this).animate({
          'width': target_width,
          'height': target_height
        }, 200, function() {
          $(this).attr({
            'src': target_src,
            'width': target_width,
            'height': target_height,
            'alt': target_description
          }).animate({
            'opacity': '1'
          }, 300, function() {
            if (target_description) {
              source_description.html(target_description);
            } else {
              source_description.html('&nbsp;');
            };
          });
        });
      });
      return false;
    });
  };
};

$(function() {
  preload_images([
    '/assets/ajax_loading.gif'
  ]);
  init_caruselko();
  init_main_news_list();
  init_main_news_scroll();
  poll_results();
  events_manipulate();
  photo_album_manipulate();
});
