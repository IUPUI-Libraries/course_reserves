class Course < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :semester
  belongs_to :department
  belongs_to :library

  validates :name, :course_number, :department_name, presence: true
  validates :instructor, :instructor_username, presence: true
  validates :semester_id, presence: true

  accepts_nested_attributes_for :items,
    allow_destroy: true,
    reject_if: :reject_item

  def reject_item(attributes)
    attributes['title'].blank? &&
    attributes['author'].blank? &&
    attributes['publication_date'].blank?
  end

  def duplicate
    dup_course = self.deep_clone include: :items
    dup_course.semester = Semester.active.first
    dup_course.items.each do |item|
      pending = ItemStatus.find_by(status: 'Pending')
      item.item_status_id = pending.id
      item.save
    end
    dup_course
  end

  def self.today
    where('created_at >= ?', Time.zone.now.beginning_of_day)
  end

  def title
    name
  end

  def department_name
    department.try(:name)
  end

  def department_name=(name)
    self.department = Department.find_by_name(name) if name.present?
  end
end
