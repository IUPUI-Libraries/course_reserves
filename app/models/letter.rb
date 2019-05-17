class Letter < ApplicationRecord
  belongs_to :library
  has_and_belongs_to_many :semesters

  def duplicate
    dup_letter = deep_clone include: :semesters
    dup_letter.sent_date = nil
    return dup_letter
  end
end
