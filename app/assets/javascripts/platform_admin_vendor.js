$(document).ready(function(){
  $('.side-menu a').on('click', function(){
    var status = this.id
    $(this).addClass("highlight").siblings().removeClass("highlight")
    if(status === "all") {
      $(".vendor-admin-form").addClass("hidden")
      $(".analytics").addClass("hidden")
      $(".pending").removeClass("hidden")
      $(".active").removeClass("hidden")
      $(".inactive").removeClass("hidden")
    } else if(status === "add-admin"){
      $(".vendor-admin-form").removeClass("hidden")
      $(".analytics").addClass("hidden")
      $(".vendor-status").addClass("hidden")
    } else if(status === "analytics") {
      $(".vendor-admin-form").addClass("hidden")
      $(".analytics").removeClass("hidden")
      $(".vendor-status").addClass("hidden")
    } else {
      $(".vendor-admin-form").addClass("hidden")
      $(".analytics").addClass("hidden")
      $('.vendor-status').addClass("hidden")
      $("." + status).removeClass("hidden")
    }
  })
})
