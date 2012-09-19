$(document).ready(function() {

  $(function() {

      var tiketLink = $('.js-b-tikets__link');

      tiketLink.closeSelected = function() {
          tiketLink.parent().filter('.b-tikets__method_state_active').each(tiketLink.unSelected);
      }

      tiketLink.unSelected = function() {
          tiketLink.parent().removeClass('b-tikets__method_state_active');
      }

      if(!$(window).hover) {
          tiketLink.bind('vclick', function() {
              if (!$(this).parent().hasClass('b-tikets__method_state_active')) {
                  $(this)
                      .each(tiketLink.closeSelected)
                      .parent().addClass('b-tikets__method_state_active');
                  return false;
              }
          });
      }

      tiketLink.hover(function() {

          var elem = $(this);

          intervalElem = setTimeout(

              function() {
                  tiketLink.parent().removeClass('b-tikets__method_state_active');
                  elem.parent().addClass('b-tikets__method_state_active');
              }, 50);

          }
      )

  });
});
