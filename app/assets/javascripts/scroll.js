$('.b-head__link').live('click',function(event) {
    event.preventDefault();
    $('html, body').animate({scrollTop: $($(this).attr('href')).offset().top-50}, 1000);
});