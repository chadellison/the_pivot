$(document).ready(function() {
  $(".side-menu").on("click", "a", function() {
    var vendor = this.id;
    $(".vendor-form").addClass("hidden")
    $("#" + vendor + "-form").toggleClass("hidden")
    if ($("#" + vendor + "-form").hasClass("hidden")){
      $("h5").removeClass("hidden")
      $("h6").removeClass("hidden")
    }
    else {
      $("h5").addClass("hidden")
      $("h6").addClass("hidden")
    }
  })
});
