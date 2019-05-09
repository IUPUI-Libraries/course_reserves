//JavaScript for instuctor emails.

$(document).ready(function() {

  $('input[type=radio][name=send_option]').change(function() {
    if($(this).val() == 'select_semester' ) {
      $('#semester-select').show(500);
      $('#instructor-list').hide(500);
    } else if ($(this).val() == 'instructors' ) {
      $('#semester-select').hide(500);
      $('#instructor-list').show(500);
    } else {
      $('#semester-select').hide(500);
      $('#instructor-list').hide(500);
    }
  });
});
