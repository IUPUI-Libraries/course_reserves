module DailyMailerHelper

  def pending_items
    Item.pending
  end

  def ordering_items
    Item.ordering
  end

  def courses_today
    Course.today
  end
end
