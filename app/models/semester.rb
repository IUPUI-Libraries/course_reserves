class Semester < ApplicationRecord
  has_many :courses
  has_many :semester_references
  has_many :instructor_emails, through: :semester_references

  def self.active
    Semester.select { |sem| sem.active == true }
  end
end
