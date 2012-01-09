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

// check all
$(function () {
	$('.checkall').click(function () {
	  var fieldset = $(this).parents('fieldset:eq(0)');
		fieldset.find(':checkbox').attr('checked', this.checked);
		fieldset.find('tr:gt(0)').toggleClass('checked');
	});
});

// private messages
$(function(){
  $('table.private-messages tr:gt(0) input[type=checkbox]').click(function(){
    $(this).parents('tr').toggleClass('checked');
  });

  $('table.private-messages tr:gt(0)')
     .filter(':has(:checkbox:checked)')
         .addClass('selected')
         .end()/*
       .click(function(event) {
         if (event.target.type !== 'checkbox') {
           $(':checkbox', this).trigger('click');
         }
       })*/
         .find(':checkbox')
         .click(function(event) {
           $(this).parents('tr:first').toggleClass('selected');
         });
         
  $('#action_select').change(function(){
  
    if($(this).find(':selected').val() == 'remove_selected'){
    
      $(this).parents('form').attr('action', '/private_messages/destroy_multiple').submit();
    }
    if($(this).find(':selected').val() == 'mark_as_read'){
  
      $(this).parents('form').attr('action', '/private_messages/mark_as_read_multiple').submit();
    }
  
  });
  

});
