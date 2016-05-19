$(document).ready(function(){


  if ($('.upload').length) {
    $(".upload").dropzone({ url: "/file/post" });

    var dropzone = new Dropzone (".dropzone", {
      maxFilesize: 256,
      paramName: "image[photo]",
      autoProcessQueue: false,
      addRemoveLinks: false,
      clickable: false,
      autoDiscover: false
    });


    dropzone.on("drop", function(file) {
      var elem = new Foundation.Reveal($('#photoForm'));
      elem.open();
    });


    $('#photoInfo').on("click", function(){
      dropzone.processQueue()
    })

    dropzone.on('sending', function(file, xhr, formData){
      var title = $('#title').val();
      var description = $('#description').val();
      var price = $('#price').val();
      var category = $('#photo_category_ids').val();
      var vendor = $('h3').text();
      formData.append("title", title);
      formData.append("description", description);
      formData.append("price", price);
      formData.append("category", category);
      formData.append("vendor", vendor);
    });
 }
});
