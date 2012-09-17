jQuery ->
  $('.field_with_errors').parents('.b-register__label, .b-register__fields').addClass('b-register__inputs-inner_state_errors')
  $('.b-register__inputs-inner_state_errors').find('.b-register__error').show()
