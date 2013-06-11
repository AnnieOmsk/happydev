$(function() {
    $('.alert a').live('click', function() {
        $('.alert').slideUp();
    });
    setTimeout(function() {
        $('.alert').slideUp();
    }, 3500);
    $('.b-landing-subscribe__button').click(function() {
        $('.ajax-loader').show()
        $.ajax({
            url: $(this).parents('form').attr('action'),
            data: {'email': $('.b-landing-form__input').val()},
            dataType: "json",
            type: 'POST',
            success: function (json) {
                if (json.success) {

                    //window.location.reload();
                    $('.ajax-loader').hide()
                    //$('.b-landing-form__error').html(json.msg)
                    $('.b-landing-form__success').html(json.msg)
                    $('.b-landing-form__error').html('')
                    $('.b-landing-form__input-wrap').hide()
                } else {
                    $('.ajax-loader').hide()
                    $('.b-landing-form__error').html(json.error)
                    $('.b-landing-form__success').html('')
                }
            }
        });
        return false;
    });

    //$('.three-tweets-block').first().show();
    $('.three-tweets-block').first().css('visibility', 'visible')
    $('.three-tweets-block').first().css('height', 'auto')
    $('.three-tweets-block').first().addClass('current');

    $(document).on('click', '#refresh-tweets a', function() {
        var current = $('.three-tweets-block.current');

        //current.hide();
        current.css('visibility', 'hidden')
        current.css('height', '0px')

        current.removeClass('current');
        var next = current.next();
        if (next.length === 0) {
            next = $('.three-tweets-block').first();
        }

        //next.show();
        next.css('visibility', 'visible')
        next.css('height', 'auto')


        next.addClass('current');
        return false;
    })
});
