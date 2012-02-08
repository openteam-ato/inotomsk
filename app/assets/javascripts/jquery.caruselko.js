(function($){

  var caruselko = {};

  var prepare = function() {
    var width = 0;
    $.each(caruselko.container.children(), function(index, item) {
      width += $(item).width();
    });
    caruselko.container.width(width)
      .css({
        'position': 'absolute',
        'top': 0,
        'left': 0
      });
  };

  var right = function() {
    clearInterval(caruselko.timeout_interval);
    var first = caruselko.container.children().first();
    caruselko.container
      .stop()
      .animate({
        left: '-=' + first.width()
      }, caruselko.speed, function() {
         caruselko.container.css('left', 0);
         caruselko.container.append(first);
      });
    timer();
    return false;
  };

  var left = function() {
    clearInterval(caruselko.timeout_interval);
    var last = caruselko.container.children().last();
    caruselko.container
      .stop()
      .css('left', - last.width())
      .prepend(last)
      .animate({
        left: '+=' + last.width()
      }, caruselko.speed, function() {
      });
    timer();
    return false;
  };

  var timer = function () {
    if (caruselko.auto_change) {
      caruselko.timeout_interval = setTimeout(right, caruselko.timeout);
    };
  };

  var methods = {
    init: function(options) {

      var opts = $.extend({
        auto_change: true,
        container: 'ul',
        left_nav: '.left a',
        right_nav: '.right a',
        speed: 500,
        timeout: 20
      }, options);

      return this.each(function() {

        $.extend(caruselko, opts);
        caruselko.container = $(opts.container, this),
        caruselko.left_nav = $(opts.left_nav, this),
        caruselko.right_nav = $(opts.right_nav, this);
        caruselko.timeout = opts.timeout * 1000;

        prepare();
        caruselko.left_nav.bind('click', left);
        caruselko.right_nav.bind('click', right);
        timer();
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
