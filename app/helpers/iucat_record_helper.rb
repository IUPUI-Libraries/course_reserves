module IucatRecordHelper

  def wrap(data)
    Array.wrap(data).join(', ')
  end
end
