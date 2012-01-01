// lean modal triggers
  // login
  $(function() {
    $("#login-trigger").leanModal({ top : 200, overlay : 0.4 });		
  });

// close button
  function close_modal(modal_id){
    $("#lean_overlay").fadeOut(200);
    $(modal_id).css({ 'display' : 'none' });
  }
  $(function() {
    $("#login-box .close").click(function(){
      close_modal("#login-box");
      return;
    });
  });


// avatar_cropping
  $(function() {
    $('#cropbox').Jcrop({
      onChange: update_crop,
      onSelect: update_crop,
      setSelect: [0, 0, 120, 120],
      aspectRatio: 1
    });
  });

  function update_crop(coords) {
    var ratio = 1 ;
    $("#crop_x").val(Math.round(coords.x * ratio));
    $("#crop_y").val(Math.round(coords.y * ratio));
    $("#crop_w").val(Math.round(coords.w * ratio));
    $("#crop_h").val(Math.round(coords.h * ratio));
  }
