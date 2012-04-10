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
        var first_submenu = $('li:first', visible_submenu)
        first_submenu.addClass('selected');
        $('.presentation .content div').hide();
        console.log($('a', first_submenu).attr('href'));
        $('.presentation .content ' + $('a', first_submenu).attr('href')).show();
      } else {
        $('.presentation .content div').hide();
        $('.presentation .content ' + $(this).attr('href')).show();
      };
    };
    return false;
  });
};

$(function() {
  trigger_main_items();
});
