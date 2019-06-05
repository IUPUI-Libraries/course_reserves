class Item < ApplicationRecord
  belongs_to :course
  belongs_to :item_status
  belongs_to :loan_period
  after_initialize :init

  validates :title, :author, :publication_date, presence: true

  def init
    self.item_status_id ||= pending_id
  end

  def self.pending
    items_with_status('Pending')
  end

  def self.ordering
    items_with_status('Ordering')
  end

  def self.items_with_status(status)
    where(item_status_id: status_id(status))
  end

  def pending_id
    status_id('Pending')
  end

  def status_id(status)
    ItemStatus.find_by(status: status).id
  end
end
