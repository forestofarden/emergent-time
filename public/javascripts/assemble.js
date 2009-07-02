// utility for expanding annotated links into assembled components via ajax,
// either in a dialog or on main page
//

(function($) {
  $.fn.assemble = function($$options) {
    // plugin defaults + options
    var $settings = $.extend({}, $.fn.assemble.defaults, $$options);
    return this.each(function() {
      // element specific options
      var o = $.metadata ? $.extend({}, $settings, $(this).metadata()) : $settings;
      // add dialog to dom
      var html = $.fn.assemble.format();
      if ( $("#detail_wrap").length == 0 ) {
        $('body').append(html);
        $('body').append('<div id="overlay" style="display:none"></div>');
      }
      // add click handlers
      var $this = $(this);
      
      $this.click(function() {
        resizeOverlay();
        resizeDetail(o);
        $('#overlay').show();
        $('#detail_wrap').show();
        setContent($('#detail_content'), $this.attr('href'));
        return false;
      });
      
      $('#detail_close').click(function() {
        $('.detail_content').removeClass($this.attr('id'));
        $('#detail_wrap').hide();
        $('#overlay').hide();
        return false;
      });
    });
  };

  function setContent($elem, href) {
    $.ajax({
      type: "GET",
      url:  href,
      dataType: "html",	
      beforeSend: function(xhr) { xhr.setRequestHeader("Accept", "text/html"); },
      error: function(e) { alert("error:" + e); },
      success: function(data) { 
        $elem.html(data); 
        // modify any internal links to load into the dialog
        $elem.find('a[target!=_blank]').click(function() {
          setContent($elem, $(this).attr('href'));
          return false;
        });
        // scroll to top
        $($elem).animate({scrollTop:0}, 'slow');
      }
    });
  }
  
  //
  // option defaults
  //
  $.fn.assemble.defaults = {
    width: 600,
    height: 400,
    page: null
  };
  
  //
  // html formatting
  //
  $.fn.assemble.format = function() {
    var html = 
    '<div id="detail_wrap" style="display:none">' + 
      '<div id="detail_outer">' + 
        '<div id="detail_inner">' + 
          '<div id="detail_close" style="display: block;"></div>' + 
          '<div id="detail_bg">' + 
            '<div class="detail_bg detail_bg_n"></div>' + 
            '<div class="detail_bg detail_bg_ne"></div>' + 
            '<div class="detail_bg detail_bg_e"></div>' + 
            '<div class="detail_bg detail_bg_se"></div>' + 
            '<div class="detail_bg detail_bg_s"></div>' + 
            '<div class="detail_bg detail_bg_sw"></div>' + 
            '<div class="detail_bg detail_bg_w"></div>' + 
            '<div class="detail_bg detail_bg_nw"></div>' + 
          '</div>' + 
          '<div id="detail_content" style="top: 10px; right: 10px; bottom: 10px; left: 10px; width: auto; height: auto; overflow:auto"></div>' +
        '</div>' +  
      '</div>' +
    '</div>';

    return html;
  };
  
  function resizeOverlay() {
    var $document = $(document);
    var $overlay = $('#overlay');
    $overlay.width($document.width());
    $overlay.height($document.height());
  }
  
  function resizeDetail(opts) {
    var d_width = opts.width;
    var d_height = opts.height;
    $('#detail_outer').css({ marginLeft: '-' + parseInt((d_width / 2),10) + 'px', width: d_width + 'px'});
    $('#detail_outer').css({ marginTop: '-' + parseInt((d_height / 2),10) + 'px', height: d_height + 'px'});
  }
  
})(jQuery);
  