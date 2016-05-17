$(document).ready(function() {
  $('.side-menu').on("click", "#orders", function(){
    $(".recent-orders").toggleClass("hidden")
    $(".new-business").addClass("hidden")
    $(".user-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })

  $('.side-menu').on("click", "#newBusiness", function(){
    $(".new-business").toggleClass("hidden")
    $(".recent-orders").addClass("hidden")
    $(".user-form").addClass("hidden")
    $("h5").addClass("hidden")
    $("h6").addClass("hidden")
  })
});
