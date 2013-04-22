$(document).ready(function() {
  $('.js-b-head__link').bind('click', function(event){
      event.preventDefault();
      scrollWithAnimation($(this).attr('href'), 50, 1000);
      changeUrlAnchor($(this).attr('href'));
  });

//   $('#tweets').carousel({interval: 5000})
});

function scrollWithAnimation(anchor, offset, delay) {
  $('html, body').animate({scrollTop: $(anchor).offset().top - offset}, delay);
};

function changeUrlAnchor(anchor) {
  var currentState = document.body.scrollTop;
  window.location.hash = anchor;
  document.body.scrollTop = currentState;
};
