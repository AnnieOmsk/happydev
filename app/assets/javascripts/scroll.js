$(window).load(function() {
  
  anchor = window.location.hash;
  
  if(anchor != '') {
    element = $('a[href="' + anchor + '"]');
    scrollWithAnimation(element.attr('href'), 50, 1000);
  }
  
  $('.b-head__nav .b-head__link').bind('click', function(event){
      event.preventDefault();
      scrollWithAnimation($(this).attr('href'), 50, 1000);
  });

  function scrollWithAnimation(anchor, offset, delay) {
    console.log($(anchor).offset().top)
    animatable = $('html, body')
    animatable.animate( { scrollTop: $(anchor).offset().top - offset},
                             { duration: delay,
                               step: function(now, fx){
                                 isAnimating = true;
                               }
                              });
  };

  $(window).scroll(function(e) {
    if(!isAnimating){
       animatable.stop(true, false); 
    }
    isAnimating = false;
  });
});
