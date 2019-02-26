module ItemsHelper

  def item_badge(item)
    return 'rvt-badge--info' unless item.item_status.status == 'Available'
    'rvt-badge--success'
  end
end
