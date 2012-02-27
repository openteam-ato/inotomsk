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
 *= require jquery_ujs
 *= require jquery.caruselko
 *= require jquery.mousewheel
 *= require jquery.jscrollpane
 *= require charts
 */

function init_caruselko() {
  if ($.fn.caruselko) {
    $('.targets').caruselko();
  };
};

function init_main_news_list() {
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
      horizontalGutter: 10
    });
  };
};

$(function() {
  init_caruselko();
  init_main_news_list();
  init_main_news_scroll();
});
