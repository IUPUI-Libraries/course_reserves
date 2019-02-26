class Item < ApplicationRecord
  belongs_to :course
  belongs_to :item_status
  after_initialize :init

  def init
    self.item_status_id ||= 1
  end
end
