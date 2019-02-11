class Course < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :semester
  accepts_nested_attributes_for :items, allow_destroy: true
end
