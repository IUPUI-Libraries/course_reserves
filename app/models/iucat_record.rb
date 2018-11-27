class IucatRecord
  require 'open-uri'

  def initialize(record_string)
    @record = Nokogiri::HTML(open('https://iucat.iu.edu/catalog/12133741/librarian_view')).css('div#marc_view div.field')
  end

  def data
    @record.map { |tag| parse_tag(tag)  }
  end

  private

  def parse_tag(tag)
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    tag_val = tag.css('div.subfields').text.delete("\n").strip
    {tag_id => tag_val}
  end

  def record_attributes

  end
end
