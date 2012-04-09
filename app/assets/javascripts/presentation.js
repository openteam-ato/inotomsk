function trigger_main_items() {
  $('.accordion > li > p > a').click(function() {
    var link = $(this),
        clicked_item = link.closest('li'),
        selected_item = $('.selected', link.closest('.accordion'));
    if (!clicked_item.hasClass('selected')) {
      $('ul', clicked_item).slideDown();
      clicked_item.addClass('selected');
      $('ul', selected_item).slideUp();
      selected_item.removeClass('selected');
    };
    return false;
  });
};

$(function() {
  trigger_main_items();
});
