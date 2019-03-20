module ItemsHelper

  include Pagy::Frontend

  def item_badge(item)
    return 'rvt-badge--info' unless item.item_status.status == 'Available'
    'rvt-badge--success'
  end

  def bod_display(item)
    return 'none' unless item.object.bod_format.present?
    'block'
  end

  def status_class(status)
    return 'rvt-button' if status == params[:status]
    'rvt-button rvt-button--secondary'
  end
end
