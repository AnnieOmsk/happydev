$(document).ready(function() {
  $('.b-head__nav .b-head__link').bind('click', function(event){
      event.preventDefault();
      scrollWithAnimation($(this).attr('href'), 50, 1000);
  });
});

function scrollWithAnimation(anchor, offset, delay) {
  $('html, body').animate({scrollTop: $(anchor).offset().top - offset}, delay);
};
