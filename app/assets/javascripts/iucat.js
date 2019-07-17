// Javascript for retrieving data from IUCAT

$(document).ready(iucatLinks);
$(document).on('turbolinks:load',function(){
  iucatLinks();
});

function iucatLinks(){
  $("div.iucat-data").each(function(){
    iucat_id = $(this).find(".iucat-record-id").val();
    if(iucatRecordId(iucat_id)){
      $(this).find(".iucat-link-bttn").attr("href", iucatLink(iucat_id));
    }
  });
}

function iucatLink(id){
  return "https://iucat.iu.edu/catalog/" + iucatRecordId(id).toString();
}

function preventSubmit(event){
  if(event.keyCode == 13) {
    event.preventDefault();
    return false;
  }
}

function checkIUCAT(x, event = false){
  var key = event.keyCode;
  if(key == '13'){
    fetchMetadata(x);
  }else{
    iucat_field = courseAttr(x, 'iucat_id');
    iucat_val = $(iucat_field).val();
    iucat_button = "#iucat_data_" + x;
    iucat_link = "#iucat_link_" + x;
    if(iucatRecordId(iucat_val)){
      $(iucat_button).attr("disabled", false);
      $(iucat_link).attr("href", iucatLink(iucat_val));
    }else{
      $(iucat_button).attr("disabled", true);
      $(iucat_link).attr("href", "https://iucat.iu.edu");
    }
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
          Modal.open('modal-local', function(){});
          populate = false;
        }else if(key == 'book_on_demand' && val == true){
          // Check if Book on Demand
          Modal.open('modal-bod', function(){
            $('#bod_modal_index').val(x);
          });
          populate = true;
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
  if (iucat_id && iucat_id > 0 && iucat_id < 99999999) {
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

function set_bod(format){
  bod_id = $('#bod_modal_index').val();
  $("#course_items_attributes_" + bod_id + "_bod_format").val(format);
  status_name = "course\\[items_attributes\\]\\[" + bod_id + "\\]\\[item_status_id\\]";
  $('select[name=' + status_name + '] option:contains("Ordering")').prop('selected', true);
  $("#div_bod_format_" + bod_id).show();
}
