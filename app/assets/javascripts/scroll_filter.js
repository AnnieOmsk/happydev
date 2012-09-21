$(document).ready(function() {

    function getScrollTop() {
        var scrOfY = 0;
        if( typeof( window.pageYOffset ) == "number" ) {
            //Netscape compliant
            scrOfY = window.pageYOffset;
        } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
            //DOM compliant
            scrOfY = document.body.scrollTop;
        } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
            //IE6 Strict
            scrOfY = document.documentElement.scrollTop;
        }

        return scrOfY;
    }

    $(window).scroll(function() {
        fixPaneRefresh();
    });

    function fixPaneRefresh() {
        if ($(".js-b-filter_type_vert").length) {

            var coordTitle = $('.js-title').offset().top;

            var coordFilter = $('.js-b-filter_type_vert').offset().top;

            var coordPos = coordFilter - coordTitle + 50;

            var top  = getScrollTop();

            if (top > coordTitle) {
                $('.js-b-filter_type_vert').css("position", 'fixed', 'top', coordPos);
            }
            else {
                $('.js-b-filter_type_vert').css("position", 'relative', 'top', coordPos);
            }
        }
    }
});
