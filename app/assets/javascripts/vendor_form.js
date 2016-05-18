$(document).ready(function() {
  $(".side-menu").on("click", ".vendor-button", function() {
    var vendor = this.id;
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $("#" + vendor + "-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".analytics").addClass("hidden")
  })

  $(".side-menu").on("click", "#analytics", function() {
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".analytics").removeClass("hidden")
  })

  $(".side-menu").on("click", "#edit-profile", function() {
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").removeClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".analytics").addClass("hidden")
  })
});
