function trigger_main_items() {
  $('.presentation .accordion > li > p > a').click(function() {
    var link = $(this),
        clicked_item = link.closest('li'),
        selected_item = $('.selected', link.closest('.accordion'));
    if (!clicked_item.hasClass('selected')) {
      var visible_submenu = $('ul', clicked_item);
      $('ul', clicked_item).slideDown();
      clicked_item.addClass('selected');
      $('ul', selected_item).slideUp();
      selected_item.removeClass('selected');
      if (visible_submenu.length) {
        var first_submenu = $('li:first', visible_submenu);
        first_submenu.addClass('selected');
        if ($('.presentation .content ' + $('a', first_submenu).attr('href')).length) {
          $('.presentation .content div:visible').fadeOut(300, function() {
            $('.presentation .content ' + $('a', first_submenu).attr('href')).fadeIn(300);
          });
        };
      } else {
        $('.presentation .content div:visible').fadeOut(300, function() {
          $('.presentation .content ' + link.attr('href')).fadeIn(300);
        });
      };
    };
    return false;
  });
  $('.presentation .accordion > li > ul > li > a').click(function() {
    var link = $(this);
    if (!link.parent().hasClass('selected') && $('.presentation .content ' + link.attr('href')).length) {
      link.parent().siblings().removeClass('selected');
      link.parent().addClass('selected');
      $('.presentation .content div:visible').fadeOut(300, function() {
        $('.presentation .content ' + link.attr('href')).fadeIn(300);
      });
    };
    return false;
  });
};

$(function() {
  trigger_main_items();
});
