class Semester < ApplicationRecord
  has_many :courses

  def self.active
    Semester.select { |sem| sem.active == true }
  end
end
