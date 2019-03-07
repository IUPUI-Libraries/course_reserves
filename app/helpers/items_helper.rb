module ItemsHelper

  def item_badge(item)
    return 'rvt-badge--info' unless item.item_status.status == 'Available'
    'rvt-badge--success'
  end

  def bod_display(item)
    return 'none' unless item.object.bod_format.present?
    'block'
  end
end
