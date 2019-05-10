class Library < ApplicationRecord
  has_many :courses
  has_many :instructor_emails
end
