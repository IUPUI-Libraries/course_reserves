// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require nested_form_fields

function fetchMetadata(x){
  iucat_field = courseAttr(x, 'iucat_id');
  iucat_input = $(iucat_field).val();
  iucat_json = iucatRecordUrl(iucat_input);
  if(iucat_json){
    $.getJSON(iucat_json, function(data){
      $.each(data, function(key, val){
        if($(courseAttr(x,'title')).length){
          $(courseAttr(x,key)).val(val);
        }
      })
    }).fail(function() { alert('Could not retrieve data from IUCAT.'); });
  }else{
    alert('Invalid IUCAT ID.')
  }
}

function courseAttr(x, field_name){
  return '#course_items_attributes_' + x + '_' + field_name;
}

function iucatRecordUrl(input){
  // Your Mission should you choose to accept...
  //
  // IF input is in the form of an iucat url
  // such as https://iucat.iu.edu/catalog/4293173,
  // AND final parameter is a number within the acceptable range,
  // THEN return a system iucat record json url using funal paramter.
  //
  // IF input is already a number
  // AND within acceptable range,
  // THEN return a system iucat record json url using nunmber.
  //
  // OTHERWISE, return false.
  //
  // System iucat record json url: /iucat_records/{number}.json
  //
  // Acceptable range: 5-8 digits, though this could change.
  // Waiting on further info from iucat people.
  //
  // This code will self-destruct in 10 seconds.
  // 9 -- 8  -- 7 -- ...
  return '/iucat_records/' + input + '.json';
}
