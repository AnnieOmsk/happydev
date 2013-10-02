$(document).ready(function() {
    $('#btn-go-subscribe').click(function() {
        $('#subscribe').css('display', 'block');
        $('#background-subscribe').css('display', 'block');
        $('#go-subscribe').css('margin-top', '-429px');
        $('#social').css('margin-top', '390px');
        $("#btn-go-subscribe").attr('class', 'btn-pushed');        
        return false;
    });
});