$(document).ready(function() {
  $(".side-menu").on("click", ".vendor-button", function() {
    var vendor = this.id;
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".vendor-admin-form").addClass("hidden")
    $("#" + vendor + "-form").toggleClass("hidden")
    $(".create-business-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".analytics").addClass("hidden")
  })

  $(".side-menu").on("click", "#analytics", function() {
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").addClass("hidden")
    $(".create-business-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".analytics").removeClass("hidden")
  })

  $(".side-menu").on("click", "#edit-profile", function() {
    $(".vendor-form").addClass("hidden")
    $(".vendor-admin-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").removeClass("hidden")
    $(".create-business-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
    $(".analytics").addClass("hidden")
  })

  $(".side-menu").on("click", ".add-admin", function() {
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".vendor-admin-form").toggleClass("hidden")
    $(".create-business-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })

  $(".side-menu").on("click", ".create-business", function() {
    $(".user-form").addClass("hidden")
    $(".vendor-form").addClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".new-business").addClass("hidden")
    $(".vendor-admin-form").addClass("hidden")
    $(".create-business-form").toggleClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })
});
