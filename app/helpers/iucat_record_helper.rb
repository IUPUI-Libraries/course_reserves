module IucatRecordHelper
  def wrap(data)
    Array.wrap(data).join(', ')
  end

  def local(data)
    # Return true if UL or Heron item, else false.
    return false unless data

    (data & ['I-UNIVLIB', 'I-ART']).any? ? true : false
  end

  def bod(data)
    # Return true if book on demand, else false.
    return false unless data

    (data & ['_ULDEMAND']).any? ? true : false
  end

  def ebook(data)
    # Return true if ebook, else false.
    return false unless data

    online = '1 online resource'
    online_period = online + '.'
    libs = %w[seasebook wellsebook ulebook kokoebook sbenebook coebook]
    return true if (data & libs.push([online_period])).any?

    data.each do |datum|
      return true if datum.to_s.include?(online)
    end
    false
  end

  def online(data)
    # Return true if online resource, else false.
    return false unless data

    (data & ['ONLINE']).any? ? true : false
  end
end
