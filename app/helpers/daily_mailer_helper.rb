module DailyMailerHelper

  def pending_items
    Item.pending
  end

  def ordering_items
    Item.ordering
  end

  def courses_today
    Course.last_24
  end

  def items_expired_today
    items = []
    Item.last_24.each do |item|
      items << item if item.expired?
    end
    items
  end
end
