//JavaScript for instuctor emails.

$(document).ready(function() {
  $('input[type=radio]').change(function() {
    semester_instructor_hide_show(this)
  });
});

$(document).on('turbolinks:load', function() {
  $('input[type=radio]').change(function() {
    semester_instructor_hide_show(this)
  });
});

function semester_instructor_hide_show(that){
  if($(that).val() == 'select_semester' ) {
    $('#semester-select').show(500);
    $('#instructor-list').hide(500);
  } else if ($(that).val() == 'instructors' ) {
    $('#semester-select').hide(500);
    $('#instructor-list').show(500);
  } else {
    $('#semester-select').hide(500);
    $('#instructor-list').hide(500);
  }
}
