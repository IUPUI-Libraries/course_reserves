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
      fields = {};
      populate = true;
      $.each(data, function(key, val){
        if(key == 'location'){
          // Must be Ul or Herron
          if(val != 'I-UNIVLIB' && val != 'I-ART'){
            alert("This is not a IUPUI UL or Herron Item.");
            populate = false;
          }
        }else if(key == 'book_on_demand' && val == true){
          // Check if Book on Demand
            alert("This is a Book on Demand item..... I DON'T KNOW WHAT TO DO!!!!");
            populate = false;
        }else{
          // Add item to display array
          fields[key] = val;
        }
      })
      if(populate){
        populate_form(x, fields);
      }
    }).fail(function() { alert('Could not retrieve data from IUCAT.'); });
  }else{
    alert('Invalid IUCAT ID.')
  }
}

function populate_form(x, fields){
  $.each(fields, function(key, val){
    if($(courseAttr(x,'title')).length){
      $(courseAttr(x,key)).val(val);
    }
  })
}

function courseAttr(x, field_name){
  return '#course_items_attributes_' + x + '_' + field_name;
}

function iucatRecordUrl(input){
  // Remove all non-numbers from input string
  var iucat_id = input.match(/\d+/g);

  // Test: Is this a valid IUCAT ID number, acceptable range: 1-8 digits?
  if (iucat_id.length > 0 && iucat_id.length  < 9) {
    path = get_base_path();
    return path + '/iucat_records/' + iucat_id + '.json';
  }
  return false;
}

function get_base_path(){
  path = '';
  first_path = window.location.pathname.split('/')[1];
  if(first_path != 'courses'){
    path = '/' + first_path;
  }
  return path;
}
