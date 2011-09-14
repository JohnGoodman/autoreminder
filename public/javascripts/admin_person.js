$(function(){

  role = $("#person_role_id").val();
  if( role == 2){
    // GM - use multile stores
    $("#person_stores_input").show();
    $("#person_store_input").hide();
    $("#person_store_id").val("");
  }else if( role == 1){
    // Admin - hide and set to nil
    $("#person_store_id, #person_store_ids").val("");
    $("#person_store_input, #person_stores_input").hide();
    $("#person_store_id, #person_stores_id").val("");
  }else{
    // Any other - use single store
    $("#person_stores_input").hide();
    $("#person_store_input").show();
    $("#person_store_ids").val("");
  }


  $("#person_role_id").change(function(){
    value = $(this).val();
    if( value == 2){
      // GM - use multile stores
      $("#person_stores_input").show();
      $("#person_store_input").hide();
      $("#person_store_id").val("");
    }else if( value == 1){
      // Admin - hide and set to nil
      $("#person_store_id, #person_store_ids").val("");
      $("#person_store_input, #person_stores_input").hide();
      $("#person_store_id, #person_stores_id").val("");
    }else{
      // Any other - use single store
      $("#person_stores_input").hide();
      $("#person_store_input").show();
      $("#person_store_ids").val("");
    }
  });

});