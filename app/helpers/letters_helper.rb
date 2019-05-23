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
        recipients |= [course.instructor_username] if library_filter(course, letter)
      end
    end
    recipients.join(', ')
  end

  private

  def library_filter(course, letter)
    return true if letter.library.nil? || letter.library == course.library

    false
  end
end
