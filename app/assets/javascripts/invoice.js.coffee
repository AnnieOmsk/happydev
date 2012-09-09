jQuery ->
  overall = 0;
  $('.invoice_check_boxes .check_boxes input').each ->
    if gon.event_prices
      if $(this).is(':checked')
        overall += gon.event_prices[$(this).val()]
        $('#amount').html(overall)

  $('.invoice_check_boxes .check_boxes input').change ->
    if gon.event_prices
      if $(this).is(':checked')
        $('#amount').html(overall += gon.event_prices[$(this).val()])
      else
        $('#amount').html(overall -= gon.event_prices[$(this).val()])

  $('.payment_type input').click ->
    $('.payment_content').toggle();
