$(document).ready(function() {
  $("a[data-metrika='true']").click(function() {
    var targetName = $(this).data('target');
    yaCounter17140027.reachGoal(targetName, window.yaParams || {});
  });

  $("#js-robokassa-form form").submit(function() {
    var input = $(this).find("input[data-metrika='true']");
    var targetName = input.data('target');
    yaCounter17140027.reachGoal(targetName, window.yaParams || {});
  });
});
