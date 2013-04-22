$(function() {
    $('.alert a').live('click', function() {
        $('.alert').slideUp();
    });
    setTimeout(function() {
        $('.alert').slideUp();
    }, 3500);
});
