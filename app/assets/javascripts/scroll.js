$(document).ready(function() {
  $('.b-head__nav .b-head__link').bind('click', function(event){
      event.preventDefault();
      scrollWithAnimation($(this).attr('href'), 50, 1000);
      changeUrlAnchor($(this).attr('href'));
  });
});

function scrollWithAnimation(anchor, offset, delay) {
  $('html, body').animate({scrollTop: $(anchor).offset().top - offset}, delay);
};

function changeUrlAnchor(anchor) {
  var currentState = document.body.scrollTop;
  window.location.hash = anchor;
  document.body.scrollTop = currentState;
};
