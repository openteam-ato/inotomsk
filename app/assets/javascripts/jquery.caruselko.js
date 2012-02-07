(function($){

  var caruselko = {};

  var prepare_container = function() {
    var container_width = 0;
    $.each(caruselko.target.children(), function(index, item) {
      container_width += $(item).width();
    });
    caruselko.target.width(container_width)
      .css({
        'position': 'absolute',
        'top': 0,
        'left': 0
      });
  },

  to_left = function(e) {
    var last_block = caruselko.target.children().last();
    caruselko.target.prepend(last_block).css('left', - last_block.width());
    caruselko.target.animate({
      left: '+=' + last_block.width()
    }, caruselko.speed);
    return false;
  },

  to_right = function(e) {
    var first_block = caruselko.target.children().first();
    caruselko.target.animate({
      left: '-=' + first_block.width()
    }, caruselko.speed, function() {
      caruselko.target.append(first_block).css('left', '0');
    });
    return false;
  };

  var methods = {
    init: function(options) {

      var opts = $.extend({
        target: 'ul',
        left_nav: '.left a',
        right_nav: '.right a',
        speed: 500
      }, options);

      return this.each(function() {

        caruselko.target = $(opts.target, this),
        caruselko.left_nav = $(opts.left_nav, this),
        caruselko.right_nav = $(opts.right_nav, this);
        caruselko.speed = opts.speed;

        prepare_container();
        caruselko.left_nav.bind('click', to_left);
        caruselko.right_nav.bind('click', to_right);

      });
    },
    destroy: function() {
      return this.each(function() {
        $(window).unbind('.caruselko');
      });
    }
  };

  $.fn.caruselko = function(method) {

    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.caruselko' );
    };

  };

  function debug($obj) {
    if (window.console && window.console.log) {
      window.console.log($obj);
    };
  };

})(jQuery);
