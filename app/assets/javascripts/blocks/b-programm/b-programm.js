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

        var elem = $(this);

        setTimeout(function() {
            elem.addClass('selected').find(descObj).slideDown(200).delay(500)
        }, 0);
    }, descLink.unSelected
    )

//    descLink.showing = function() {
//        setTimeout(function() {
//            descLink.addClass('selected').find(descObj).slideDown(50)
//        }, 1000);
//    }
//
//    descLink.mouseenter(function() {
//
//        var timer;
//
//        var elem = $(this);
//
//        if(timer) {
//            clearTimeout(timer);
//            timer = null;
//        }
//
//        timer = setTimeout(function() {
//            elem.addClass('selected').find(descObj).slideDown(50);
//        }, 0)
//    });
//
//    descLink.mouseleave(function() {
//        descLink.unSelected();
//    });

});
