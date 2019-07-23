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
