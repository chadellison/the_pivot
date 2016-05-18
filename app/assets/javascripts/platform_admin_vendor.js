$(document).ready(function(){
  $('.side-menu a').on('click', function(){
    var status = this.id
    $(this).addClass("highlight").siblings().removeClass("highlight")
    if(status === "all") {
      $(".pending").removeClass("hidden")
      $(".active").removeClass("hidden")
      $(".inactive").removeClass("hidden")
      $(".vendor-admin-form").addClass("hidden")
    } else if(status === "add-admin"){
      $(".vendor-status").addClass("hidden")
      $(".vendor-admin-form").removeClass("hidden")
    } else {
      $('.vendor-status').addClass("hidden")
      $(".vendor-admin-form").addClass("hidden")
      $("." + status).removeClass("hidden")
    }
  })
})
