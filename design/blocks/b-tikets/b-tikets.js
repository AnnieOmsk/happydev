$(function() {

    priceObj = $('.js-b-tikets__link');

    priceObj.closeSelected = function() {
        priceObj.filter('.b-tikets__link_state_selected').each(priceObj.unSelected);

        $(document).bind("vclick click", priceObj.unSelected);
    }

    priceObj.unSelected = function() {
        priceObj.removeClass('b-tikets__link_state_selected');
    }

    if(!$(window).hover) {
        priceObj.bind('vclick click', function() {
            if (!$(this).hasClass('b-tikets__link_state_selected')) {
                $(this)
                    .each(priceObj.closeSelected)
                    .addClass('b-tikets__link_state_selected');
                return false;
            }
        });
    }
});