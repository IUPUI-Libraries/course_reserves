// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// Script to prevent leaving form without saving.
// Source: https://blog.driftingruby.com/form-check-modified/

var msg, unsaved;

msg = "Changes you made may not be saved.";

unsaved = false;

$(document).ready(function(){
  // Warn of unsaved courses when duplicating.
  if(window.location.href.indexOf("duplicate") > -1) {
    return unsaved = true;
  } else {
    return unsaved = false;
  }
  // Check for item title(s) on course form
  if( $('#course_submit').length ){
    item_title_check();
  }
});

$(document).on('turbolinks:load', function() {
  // Check for item title(s) on course forlm
  if( $('#course_submit').length ){
    item_title_check();
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

  if(window.location.href.indexOf("duplicate") > -1) {
    return unsaved = true;
  } else {
    return unsaved = false;
  }
});

$(document).on('change', 'form[role="check-modified"]:not([data-remote]) :input', function() {
  return unsaved = true;
});

// Enable course submit button when at least on title is not empty.
$(document).on('change', 'input.item-title', function(){
  item_title_check();
});

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

// Enable course submit button if an item title exists,
// else disable submit button.
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

// Enable or disable course submit button
function disabled_status(status){
  $('input[name=commit][id=course_submit]').prop('disabled', status);
}

// Hide | Show digital options info
function digital_options_toggle(obj){
  idx = obj.attr('id').split("_")[3];
  div_id = 'digital_option_info_' + idx;
  if(obj.is(':checked')){
    $('#' + div_id).show("slow");
  }else{
    $('#' + div_id).hide("slow");
    $('input[name="course[items_attributes][' + idx + '][digital_title]"]').val('');
    $('input[name="course[items_attributes][' + idx + '][digital_url]"]').val('');
  }
}
