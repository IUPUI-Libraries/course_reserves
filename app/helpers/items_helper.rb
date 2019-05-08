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

  def iucat_link(item)
    return nil if item.iucat_id.nil?
    "https://iucat.iu.edu/catalog/#{item.iucat_id}"
  end

  def title_iucat_link(item)
    return item.title if item.iucat_id.nil?
    link_display = "#{item.title} #{fa_icon 'external-link'}"
    link_to iucat_link(item), target: "_blank" do
      link_display
    end
  end
end
