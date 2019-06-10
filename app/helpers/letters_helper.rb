module LettersHelper
  include Pagy::Frontend

  def show_semesters(let = false)
    letter = let || @letter
    letter.semesters.map { |sem| sem.semester.to_s }.join('<br/>').html_safe
  end

  def recipient_list(let = false)
    letter = let || @letter
    recipients = []
    letter.semesters.each do |semester|
      semester.courses.each do |course|
        recipients |= [course.instructor_email] if library_filter(course, letter)
      end
    end
    recipients.join(', ')
  end

  def from_address(let = false)
    letter = let || @letter
    if Library.exists?(id: letter.library_id)
      library = Library.find(letter.library_id).name
      return CourseReserves.config[:email][:library_from][library] unless CourseReserves.config[:email][:library_from][library].nil?
    end
    CourseReserves.config[:email][:default_from]
  end

  private

  def library_filter(course, letter)
    return true if letter.library.nil? || letter.library == course.library

    false
  end
end
