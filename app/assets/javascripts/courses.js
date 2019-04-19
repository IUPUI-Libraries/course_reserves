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

// Autocomplete for course department field.
jQuery(() =>
  $('#course_department_name').autocomplete({
    source: $('#course_department_name').data('autocomplete-source')}));

$(document).on('turbolinks:load', function() {
  // Autocomplete for course department field.
  jQuery(() =>
    $('#course_department_name').autocomplete({
      source: $('#course_department_name').data('autocomplete-source')}));

  return unsaved = false;
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
