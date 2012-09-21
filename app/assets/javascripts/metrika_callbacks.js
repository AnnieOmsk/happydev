$(document).ready(function() {
  $("a[data-metrika='true']").click(function() {
    var targetName = $(this).data('target');
    yaCounter17140027.reachGoal(targetName);
    console.log('reach goal' + ' ' + targetName);
  });

  $("#js-robokassa-form form").submit(function() {
    var input = $(this).find("input[data-metrika='true']");
    var targetName = input.data('target');
    yaCounter17140027.reachGoal(targetName);
    console.log('reach goal' + ' ' + targetName);
});
