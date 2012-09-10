$('.b-programm__column:last-child').addClass('b-programm__column-last');

$(function() {

    descLink = $('.js-b-programm__content');
    descObj = $('.js-b-programm__desc');

    descLink.closeSelected = function() {
        descObj.parent().filter('.selected').each(descLink.unSelected);

        $(this).find(descObj).slideUp(100);

        $(document).bind("vclick", descLink.unSelected);
    }

    descLink.unSelected = function() {
        descLink.removeClass('selected').find(descObj).slideUp(100);
    }

    if(!$(window).hover) {
        descLink.bind('vclick', function() {
            if (!$(this).hasClass('selected')) {
                $(this)
                    .each(descLink.closeSelected)
                    .addClass('selected').find(descObj).slideDown(200);
                return false;
            }
        });
    }


    descLink.hover(function() {
        $(this).addClass('selected').find(descObj).slideDown(200);
    }, descLink.unSelected)
});