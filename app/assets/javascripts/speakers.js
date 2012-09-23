$(document).ready(function(){
  function get_like_status(type) {
    var url = '/likes/' + window.location.pathname.split('/')[2];
    $.ajax({
      url: url,
      type: type,
      dataType: 'json',
      success: function(data, textStatus, jqXHR) {
        var star;
        if (data.status && data.status == true) {
          star = "★";
        } else {
          star = "☆";
        }
        $('#hd-like-star').html(star);
      }
    });
  }

  get_like_status("GET");

  $('#hd-like-star').click(function(){
    get_like_status("PUT");
  });
});