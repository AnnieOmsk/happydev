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

                    //TODO:: reload to new page
                    window.location.reload();
                } else {
                    $('.b-landing-form__error').html(json.error)
                }
            }
        });
        return false;
    });

});
