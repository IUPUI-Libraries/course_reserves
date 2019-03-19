class Item < ApplicationRecord
  belongs_to :course
  belongs_to :item_status
  after_initialize :init

  def init
    self.item_status_id ||= 1
  end

  def self.pending
    items_with_status('Pending')
  end

  def self.ordering
    items_with_status('Ordering')
  end

  def self.items_with_status(status)
    pending_id = ItemStatus.find_by(status: status).id
    where(item_status_id: pending_id)
  end
end
