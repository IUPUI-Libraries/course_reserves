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
});

$(document).on('turbolinks:load', function() {

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
