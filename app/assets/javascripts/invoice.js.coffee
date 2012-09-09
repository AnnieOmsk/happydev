jQuery ->
  overall = 0;
  $('#new_invoice .check_boxes input').each ->
    if gon.event_prices
      if $(this).is(':checked')
        overall += gon.event_prices[$(this).val()]
        $('#amount').html(overall)

  $('#new_invoice .check_boxes input').change ->
    if gon.event_prices
      if $(this).is(':checked')
        $('#amount').html(overall += gon.event_prices[$(this).val()])
      else
        $('#amount').html(overall -= gon.event_prices[$(this).val()])

  $('.clearing_type input').click (event)->
    $('.payment_content').toggle();
    if $(this).is(':checked')
      state = true
    else
      state = false
    url = '/invoice/clearing?state=' + state
    $.ajax url,
      type: 'PUT'
      dataType: 'html',
      # error: (jqXHR, textStatus, errorThrown) ->
      #   alert 'error'
      success: (data, textStatus, jqXHR) ->
        # alert 'success'
        # $('#show-payment #payment-button form').submit()
