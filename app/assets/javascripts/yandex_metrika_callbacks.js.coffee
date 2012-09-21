jQuery ->
  $("a[data-metrika='true']").click ->
    targetName = $(this).data('target')
    yaCounter17140027.reachGoal(targetName)
    console.log('reach goal' + ' ' + targetName)

  $("#js-robokassa-form form").submit ->
    input = $(this).find("input[data-metrika='true']")
    targetName = input.data('target')
    yaCounter17140027.reachGoal(targetName)
    console.log('reach goal' + ' ' + targetName)
