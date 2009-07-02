/*
* Repertoire listener for form input suggestions
* 
* Copyright (c) 2009 MIT Hyperstudio
* Christopher York, 05/2009
*/

(function($) {
  $.fn.input_listen = function($$options) {
    // plugin defaults + options
    var $settings = $.extend({}, $.fn.input_listen.defaults, $$options);
    return this.each(function() {
      var timeout = false;
  		var prevLength = 0;
      var $input = $(this).attr("autocomplete", "off");
      // element specific options
      var o = $.meta ? $.extend({}, $settings, $input.data()) : $settings;

      function processKey(evt) { 
        if ($input.val().length != prevLength) {
    	    if (timeout) 
    		    clearTimeout(timeout);
    	    timeout = setTimeout(changed, o.delay);
    	    prevLength = $input.val().length;
        }
      }
      
      function changed() {
        var q = $.trim($input.val());
        if (q.length >= o.min_chars) {
          o.changed(q);
        }
      }
      
      // initialize event listeners
			if ($.browser.mozilla)
				$input.keypress(processKey);	// onkeypress repeats arrow keys in Mozilla/Opera
			else
				$input.keydown(processKey);		// onkeydown repeats arrow keys in IE/Safari
    });
  };
  

  //
  // option defaults
  //
  $.fn.input_listen.defaults = {
		delay:     100,
		min_chars: 3
  };

})(jQuery);
