class Department < ApplicationRecord
  has_many :courses

  def self.active
    Department.select { |dept| dept.active == true }
  end
end
