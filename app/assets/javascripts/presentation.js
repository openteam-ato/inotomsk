function trigger_main_items() {
  $('.presentation .accordion > li > p > a').click(function() {
    var link = $(this),
        clicked_item = link.closest('li'),
        selected_item = $('.selected', link.closest('.accordion'));
    if (!clicked_item.hasClass('selected')) {
      $('ul', selected_item).slideUp('fast');
      selected_item.removeClass('selected');
      $('ul', clicked_item).slideDown('fast');
      clicked_item.addClass('selected');
    };
    return false;
  });
};

$(function() {
  trigger_main_items();
});
