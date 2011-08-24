function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function select_reminder( select_box ){
  if( $(select_box).val() == 1 ){
    $(select_box).closest("fieldset").removeClass('hide_custom');
    $(select_box).closest(".custom").slideDown();
  }else{
    $(select_box).closest("fieldset").addClass('hide_custom');
    $(select_box).closest(".custom").slideDown();
  }
}