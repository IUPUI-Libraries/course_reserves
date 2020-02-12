class Item < ApplicationRecord
  belongs_to :course
  belongs_to :item_status
  belongs_to :loan_period
  after_initialize :init

  validates :title, :author, :publication_date, presence: true

  validates_length_of :title, :author, :publication_date, :edition, :call_number,  maximum: 255

  def init
    self.item_status_id ||= pending_id
  end

  def self.pending
    items_with_status('Pending')
  end

  def self.ordering
    items_with_status('Ordering')
  end

  def self.processing
    items_with_status('Processing')
  end

  def self.items_with_status(status)
    where(item_status_id: status_id(status))
  end

  def self.pending_id
    status_id('Pending')
  end

  def self.status_id(status)
    ItemStatus.find_by(status: status).id
  end

  def self.last_24
    last_24 = Time.zone.now - 24 * 60 * 60
    where('created_at >= ? or updated_at >= ?', last_24, last_24)
  end

  def pending_id
    status_id('Pending')
  end

  def status_id(status)
    ItemStatus.find_by(status: status).id
  end

  def expired?
    return true if status_id('Expired') == self.item_status_id

    false
  end
end
