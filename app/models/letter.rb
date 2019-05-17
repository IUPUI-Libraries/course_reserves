class Letter < ApplicationRecord
  belongs_to :library
  has_and_belongs_to_many :semesters

  def duplicate
    dup_letter = deep_clone include: :semesters
    dup_letter.sent_date = nil
    dup_letter
  end

  def recipient_list
    recipients = []
    semesters.each do |semester|
      semester.courses.each do |course|
        recipients |= [course.instructor_username]
      end
    end
    recipients
  end
end
