$(document).ready(function() {
  if($('.flash-alert').text() === "Incorrect email/password combination."){
    var elem = new Foundation.Reveal($('#login'));
    setTimeout( function(){
      elem.open();
    }, 800)
  }
});
