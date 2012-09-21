jQuery ->
  $(document).ready ->
    getScrollTop = ->
      scrOfY = 0
      if ( typeof( window.pageYOffset ) == "number" )
        ##  Netscape compliant
        scrOfY = window.pageYOffset
      else if ( document.body && ( document.body.scrollLeft || document.body.scrollTop ) )
        ##  DOM compliant
        scrOfY = document.body.scrollTop
      else if ( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) )
        ##  IE6 Strict
        scrOfY = document.documentElement.scrollTop
      return scrOfY   

    $(window).scroll ->
      fixPaneRefresh()

    fixPaneRefresh = ->
      if $(".js-b-filter_type_vert").length
        top  = getScrollTop()
        coordTitle = $('.js-title').offset().top
        if top > coordTitle
          $('.js-b-filter_type_vert').css('position', 'fixed')
        else
          $('.js-b-filter_type_vert').css("position", 'relative')