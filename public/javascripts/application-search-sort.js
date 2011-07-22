$(function() {
  // Prevent form from being submitted when enter is pressed, instead use Ajax
  $('#search-form').submit(function(e) {
    e.preventDefault();
    ajaxSearch();
  });
  
  // Search as you type into any input fields
  $('#search-form input[type=text]').livesearch( {searchCallback: ajaxSearch, innerText: null} );
  
  // Search when you use a select field
  $('#search-form select').change(ajaxSearch);
  
  function ajaxSearch() {
    $(".clear-search").addClass("searching"); // show the spinner
    var form = $("#search-form");
    var action = $(form).attr('action');
    $.get(action, $(form).serialize(), function(){
      $(".clear-search").removeClass("searching"); // hide the spinner
    }, "script");
  }

  // Clears the form then runs a search
  $('.clear-search').click(function() {
    $('#search-form').clearForm();
    ajaxSearch();
  });
  
  // Runs ajax sort and disables the link
  $("#search-results th a, #search-results .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
});


/**
 * Clears the form data.  Takes the following actions on the form's input fields:
 *  - input text fields will have their 'value' property set to the empty string
 *  - select elements will have their 'selectedIndex' property set to 0
 *  - checkbox and radio inputs will have their 'checked' property set to false
 *  - inputs of type submit, button, reset, and hidden will *not* be effected
 *  - button elements will *not* be effected
 */
$.fn.clearForm = function() {
	return this.each(function() {
		$('input,select,textarea', this).clearFields();
		
		// If uniform is intalled, run update
		if(jQuery().uniform) { $.uniform.update(); }
	});
};

/**
 * Clears the selected form elements.
 */
$.fn.clearFields = $.fn.clearInputs = function() {
	var re = /^(?:color|date|datetime|email|month|number|password|range|search|tel|text|time|url|week)$/i; // 'hidden' is not in this list
	return this.each(function() {
		var t = this.type, tag = this.tagName.toLowerCase();
		if (re.test(t) || tag == 'textarea') {
			this.value = '';
		}
		else if (t == 'checkbox' || t == 'radio') {
			this.checked = false;
		}
		else if (tag == 'select') {
			this.selectedIndex = 0;
		}
	});
};