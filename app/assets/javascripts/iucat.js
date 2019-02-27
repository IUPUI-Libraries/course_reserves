// Javascript for retrieving data from IUCAT

function checkIUCAT(x){
  iucat_field = courseAttr(x, 'iucat_id');
  iucat_val = $(iucat_field).val();
  iucat_button = "#iucat_data_" + x;
  if(iucatRecordId(iucat_val)){
    $(iucat_button).attr("disabled", false);
  }else{
    $(iucat_button).attr("disabled", true);
  }
}

function fetchMetadata(x){
  iucat_field = courseAttr(x, 'iucat_id');
  iucat_input = $(iucat_field).val();
  iucat_id = iucatRecordId(iucat_input);
  iucat_json = iucatRecordUrl(iucat_input);
  iucat_button = "#iucat_data_" + x;
  if(iucat_json){
    $.getJSON(iucat_json, function(data){
      fields = {};
      populate = true;
      $.each(data, function(key, val){
        if(key == 'local_location' && !val){
          // Must be Ul or Herron
          alert("This is not a IUPUI UL or Herron Item.");
          populate = false;
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
        $(iucat_field).val(iucat_id);
        $(iucat_button).attr("disabled", true);
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
  iucat_id = iucatRecordId(input);
  if(iucat_id){
    path = get_base_path();
    return path + '/iucat_records/' + iucat_id + '.json';
  }
  return false;
}

function iucatRecordId(input){
  // Remove all non-numbers from input string
  var iucat_id = input.match(/\d+/g);
  // Test: Is this a valid IUCAT ID number, acceptable range: 1-8 digits?
  if (iucat_id && iucat_id.length > 0 && iucat_id.length  < 9) {
    return iucat_id;
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
