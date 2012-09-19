jQuery ->
  showHideNotice()

  $('input.b-register__student').change ->
    showHideNotice()
    
showHideNotice = ->
  if $('input.b-register__student').is(':checked')
    $('.b-register__student_notice').show()
  else
    $('.b-register__student_notice').hide()
