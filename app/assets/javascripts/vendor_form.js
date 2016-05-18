$(document).ready(function() {
  $(".side-menu").on("click", ".vendor-button", function() {
    var vendor = this.id;
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".vendor-admin-form").addClass("hidden")
    $("#" + vendor + "-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })

  $(".side-menu").on("click", "#edit-profile", function() {
    $(".vendor-form").addClass("hidden")
    $(".vendor-admin-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })

  $(".side-menu").on("click", ".add-admin", function() {
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".vendor-admin-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })
});
