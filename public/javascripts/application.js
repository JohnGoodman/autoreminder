$(function() {
  // Setup jQuery watermark on all .search_box inputs
  $.watermarker.setDefaults({color: '#7B7B7B', left: -3});
  $('input.search_box, #search_cusomters').watermark();

  // jQuery uniform controls (http://pixelmatrixdesign.com/uniform)
  // $("select:not(.ignore_uniform),input:checkbox, input:radio, input:file").uniform();


  $('img,a,span,td,th').each(function() {
    if ($(this).get(0).title != '') {
      $(this).tipTip({delay: 0, fadeIn: 100, fadeOut: 100});
    }
  });

  // Collapse the fieldset elements
  $("fieldset.collapsible").collapse();
  $("fieldset.collapsibleClosed").collapse( { closed : true } );

  // Open fieldset if it has an error
  $(".field_with_errors").closest('fieldset').removeClass('collapsibleClosed').removeClass('collapsed').addClass('collapsible');

  // Datepicker
  $('input.ui-date-picker').datepicker({
    changeMonth: true,
    changeYear: true,
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: 'yy-mm-dd'
  });

  $('.datepicker_birthday').datepicker({
    changeMonth: true,
    changeYear: true,
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: 'yy-mm-dd',
    yearRange: "-90:+0",
    maxDate: 'today'
  });

  $('.datetimepicker').datetimepicker({
    changeMonth: true,
    changeYear: true,
    showOtherMonths: true,
    selectOtherMonths: true,
    dateFormat: 'yy-mm-dd',
    minDate: new Date(y, m, d, 8, 30)
  });

  // Select all
  $('#select_all_checkboxes').click(function(){
    if( $(this).is(':checked') ){
        $('.checkbox input').attr('checked','checked')
      }else{
        $('.checkbox input').removeAttr('checked')
      }
    // $.uniform.update();
  });
});

// Date time picker
var date = new Date();
var y = date.getFullYear();
var m = date.getMonth();
var d = date.getDate();

function randomString() {
  var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
  var randomstring = '';
  for (var i=0; i<5; i++) {
    var rnum = Math.floor(Math.random() * chars.length);
    randomstring += chars.substring(rnum,rnum+1);
  }
  return randomstring;
}

function confirm_javascript_function(message){
  alert = confirm(message);
  if( !alert ){
    return false;
  }
}