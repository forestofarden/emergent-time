// utility for expanding annotated links into ajax-loaded components

(function($) {
  $.fn.ajaxLoad = function(func, $$options) {
    // plugin defaults + options
    var $settings = $.extend({}, $.fn.ajaxLoad.defaults, $$options);
    return this.each(function() {
      // element specific options
      var o = $.meta ? $.extend({}, $settings, $form.data()) : $settings;
      // parse out page to load
      var href = $(this).attr('href');
      var $elem = $(this);
      $.ajax({
        type: "GET",
        url:  href,
        dataType: "html",	
        beforeSend: function(xhr) { xhr.setRequestHeader("Accept", "text/html"); },
        success: function(data) { $elem.replaceWith(data); if (func) { func.call(); } }, 
        error: function(e) { alert("error:" + e); }
      });
    });
  };
  
  //
  // option defaults
  //
  $.fn.ajaxLoad.defaults = {
  };
})(jQuery);
  