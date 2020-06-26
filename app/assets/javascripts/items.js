// JS for Items

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

// Show and hide digital option fields
// THIS WILL NOT WORK AS FIELDS ARE INDEXED

$(document).ready(function(){
  var digital_option = $("input[name='course[items_attributes][1][digital_option]']");

  // Show after loading if checked
  if(digital_option.checked){
    $("#digital_option_info").show("slow");
  }

  // Toggle function
})
