jQuery ->
  # $('#new_payment textbox').change ->
    # alert('click')

  $('#show-payment #payment-button input').click (event) ->
    event.preventDefault()
    data = { }
    url = '/payment/update_amount'
    $.post url, (data) ->
      $('#show-payment #payment-button form').submit()
