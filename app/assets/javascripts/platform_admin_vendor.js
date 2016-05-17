$(document).ready(function(){
  $('.side-menu h4').on('click', function(){
    var status = this.id
    if(status === "all") {
      $(".pending").removeClass("hidden")
      $(".active").removeClass("hidden")
      $(".inactive").removeClass("hidden")
      $(".rules").removeClass("hidden")
    } else {
      $('.vendor-status').addClass("hidden")
      $("." + status).removeClass("hidden")
      $(".rules").addClass("hidden")
    }
    console.log(status)
  })
})
