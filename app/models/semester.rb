class Semester < ApplicationRecord
  has_many :courses
  has_and_belongs_to_many :letters

  def self.active
    Semester.order(id: :desc).select { |sem| sem.active == true }
  end
end
