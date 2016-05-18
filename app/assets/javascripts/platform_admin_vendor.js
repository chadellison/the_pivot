$(document).ready(function(){
  $('.side-menu a').on('click', function(){
    var status = this.id
    $(this).addClass("highlight").siblings().removeClass("highlight")
    if(status === "all") {
      $(".pending").removeClass("hidden")
      $(".active").removeClass("hidden")
      $(".inactive").removeClass("hidden")
      $(".analytics").addClass("hidden")
    } else if(status === "analytics") {
      $(".vendor-status").addClass("hidden")
      $(".analytics").removeClass("hidden")
    } else {
      $('.vendor-status').addClass("hidden")
      $("." + status).removeClass("hidden")
      $(".analytics").addClass("hidden")
    }
  })
})
