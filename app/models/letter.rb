class Letter < ApplicationRecord
  belongs_to :library, optional: true
  has_and_belongs_to_many :semesters

  def duplicate
    dup_letter = deep_clone include: :semesters
    dup_letter.sent_date = nil
    dup_letter
  end
end
