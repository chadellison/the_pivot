$(document).ready(function() {
  $(".side-menu").on("click", ".vendor-button", function() {
    var vendor = this.id;
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $("#" + vendor + "-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })

  $(".side-menu").on("click", "#edit-profile", function() {
    $(".vendor-form").addClass("hidden")
    $(".user-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })
});
