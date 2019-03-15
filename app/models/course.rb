class Course < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :semester
  accepts_nested_attributes_for :items,
    allow_destroy: true,
    reject_if: :reject_item

  def reject_item(attributes)
    attributes['title'].blank? &&
    attributes['author'].blank? &&
    attributes['publication_date'].blank?
  end
end
