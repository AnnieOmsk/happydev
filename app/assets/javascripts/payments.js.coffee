jQuery ->
  $('#show-payment #payment-button input').click (event) ->
    event.preventDefault()
    data = { }
    url = '/invoice/move_to_robokassa'
    $.ajax url,
      type: 'PUT'
      dataType: 'html',
      # error: (jqXHR, textStatus, errorThrown) ->
      #   alert 'error'
      success: (data, textStatus, jqXHR) ->
        # alert 'success'
        $('#show-payment #payment-button form').submit()

