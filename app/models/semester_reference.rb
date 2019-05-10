class SemesterReference < ApplicationRecord
  belongs_to :semester
  belongs_to :instuctor_email
end
