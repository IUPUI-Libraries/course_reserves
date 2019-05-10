class InstructorEmail < ApplicationRecord
  belongs_to :library
  has_many :semester_references, dependent: :destroy
  has_many :semesters, through: :semester_references
end
