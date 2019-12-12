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
    recipients.join('; ')
  end

  def from_address(let = false)
    letter = let || @letter
    return Library.find(letter.library_id).email if Library.exists?(id: letter.library_id)

    ''
  end

  private

  def library_filter(course, letter)
    return true if letter.library.nil? ||
                   letter.library == course.library ||
                   letter.library == Library.where(name: 'All').first

    false
  end
end
