// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// Script to prevent leaving form without saving.
// Source: https://blog.driftingruby.com/form-check-modified/

var msg, unsaved;

msg = "Changes you made may not be saved.";

unsaved = false;

$(document).on('change', 'form[role="check-modified"]:not([data-remote]) :input', function() {
  return unsaved = true;
});

// Enable course submit button when at least on title is not empty.
$(document).on('change', 'input.item-title', function(){
  item_title_check();
});

// Disable submit if no item title exists.
function item_title_check(){
  no_title = true;
  $('input.item-title').each(function(){
    if(no_title && $(this).val() != ''){
      disabled_status(false);
      no_title = false;
    }
  });
  if(no_title){
    disabled_status(true);
  }
}

// Autocomplete for course department field.
jQuery(() =>
  $('#course_department_name').autocomplete({
    source: $('#course_department_name').data('autocomplete-source'),
    change: function(event, ui) {
      if (ui.item == null) {
        $("#course_department_name").val("");
        $("#course_department_name").focus();
      }
    }
}));

$(document).ready(function(){
  // Warn of unsaved courses when duplicating.
  if(window.location.href.indexOf("duplicate") > -1) {
    return unsaved = true;
  } else {
    return unsaved = false;
  }
  // Check for item title(s)
  item_title_check();
});

$(document).on('turbolinks:load', function() {
  // Check for item title(s)
  item_title_check();

  // Autocomplete for course department field.
  jQuery(() =>
    $('#course_department_name').autocomplete({
      source: $('#course_department_name').data('autocomplete-source'),
      change: function(event, ui) {
        if (ui.item == null) {
          $("#course_department_name").val("");
          $("#course_department_name").focus();
        }
      }
  }));

  if(window.location.href.indexOf("duplicate") > -1) {
    return unsaved = true;
  } else {
    return unsaved = false;
  }
});

$(document).on('submit', 'form[role="check-modified"]', function() {
  unsaved = false;
});

$(window).bind('beforeunload', function() {
  if (unsaved) {
    return msg;
  }
});

$(document).on('turbolinks:before-visit', function(event) {
  if (unsaved && !confirm(msg)) {
    return event.preventDefault();
  }
});

// Prevent Enter key from submitting form for certain fields
// Found at https://stackoverflow.com/questions/1009808/enter-key-press-behaves-like-a-tab-in-javascript
$(document).on("keydown", "input.enterastab, select.enterastab, textarea.enterastab", function(e) {
 if (e.keyCode==13) {
  var focusable = $('input,a,select,button,textarea').filter(':visible');
  if (e.shiftKey) {
    focusable.eq(focusable.index(this)-1).focus();
  }else{
    focusable.eq(focusable.index(this)+1).focus();
  }
  return false;
 }
});

function disabled_status(status){
  $('input[name=commit]').prop('disabled', status);
}
