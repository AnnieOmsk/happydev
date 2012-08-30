jQuery ->
  overall = 0;
  $('#new_invoice .check_boxes input').each ->
    if gon.event_prices
      if $(this).is(':checked')
        overall += gon.event_prices[$(this).val()]

  $('#new_invoice .check_boxes input').change ->
    if gon.event_prices
      if $(this).is(':checked')
        $('#amount').html(overall += gon.event_prices[$(this).val()])
      else
        $('#amount').html(overall -= gon.event_prices[$(this).val()])
