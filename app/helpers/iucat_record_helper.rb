module IucatRecordHelper

  def wrap(data)
    Array.wrap(data).join(', ')
  end

  def local(data)
    (data & ['I-UNIVLIB', 'I-ART']).any? ? true : false
  end

  def bod(data)
    data == '_ULDEMAND'
  end
end
