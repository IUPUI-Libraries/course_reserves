class Course < ApplicationRecord

  has_many :items, dependent: :destroy

end
