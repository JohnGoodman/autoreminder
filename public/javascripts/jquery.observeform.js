// http://misterdai.wordpress.com/2010/06/04/jquery-form-changed-warning/
// http://jsbin.com/amecu3
// http://jsbin.com/amecu3/edit

// The following will be exluded from being observed and getting the modified warning
var exclusions = '.search, .login, #search-form';

var catcher = function() {
  var changed = false;
  $('form').not(exclusions).each(function() {
    if ($(this).data('initialForm') != $(this).serialize()) {
      changed = true;
      $(this).addClass('changed');
    } else {
      $(this).removeClass('changed');
    }
  });
  if (changed) {
    return 'One or more forms on this page have changed.  Are you sure you want to leave this page?';
  }
};

$(function() {
  $('form').not(exclusions).each(function() {
    $(this).data('initialForm', $(this).serialize());
  }).submit(function(e) {
  var formEl = this;
  var changed = false;
  $('form').not(exclusions).each(function() {
    if (this != formEl && $(this).data('initialForm') != $(this).serialize()) {
      changed = true;
      $(this).addClass('changed');
    } else {
      $(this).removeClass('changed');
    }
  });
  if (changed && !confirm('Another form on this page has been changed. Are you sure you want to continue with this form submission?')) {
    e.preventDefault();
  } else {
    $(window).unbind('beforeunload', catcher);
  }
  });
  $(window).bind('beforeunload', catcher);
});
