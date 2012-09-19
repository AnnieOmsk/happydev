$(document).ready(function() {

  $(function() {

      descLink = $('.js-b-tikets__link');

      descLink.closeSelected = function() {
          descLink.parent().filter('.b-tikets__method_state_active').each(descLink.unSelected);
      }

      descLink.unSelected = function() {
          descLink.parent().removeClass('b-tikets__method_state_active');
      }

      if(!$(window).hover) {
          descLink.bind('vclick', function() {
              if (!$(this).parent().hasClass('b-tikets__method_state_active')) {
                  $(this)
                      .each(descLink.closeSelected)
                      .parent().addClass('b-tikets__method_state_active');
                  return false;
              }
          });
      }

      descLink.hover(function() {

          var elem = $(this);

          intervalElem = setTimeout(

              function() {
                  descLink.parent().removeClass('b-tikets__method_state_active');
                  elem.parent().addClass('b-tikets__method_state_active');
              }, 50);

          }
      )

  });
});
