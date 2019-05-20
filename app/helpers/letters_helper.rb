module LettersHelper
  def show_semesters(let = false)
    letter = let || @letter
    letter.semesters.map { |sem| sem.semester.to_s }.join('<br/>').html_safe
  end

  def recipient_list(let = false)
    letter = let || @letter
    recipients = []
    letter.semesters.each do |semester|
      semester.courses.each do |course|
        recipients |= [course.instructor_username]
      end
    end
    recipients.join(', ')
  end
end
