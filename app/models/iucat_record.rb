class IucatRecord
  require 'open-uri'

  def initialize(record_string)
    #@record = Nokogiri::HTML(open('https://iucat.iu.edu/catalog/12133741/librarian_view')).css('div#marc_view div.field')
    @record = Nokogiri::HTML(open("https://iucat.iu.edu/catalog/#{record_string}/librarian_view")).css('div#marc_view div.field')
  end

  def data
    data = {}
    @record.each do |tag|
      info = parse_tag(tag);
      if info
        info.each do |point|
          data[point[0]] = point[1];
        end
     end
    end
    return data
  end

  private

  def parse_tag(tag)
    return parse_control(tag) unless tag.css('span.control_field_values').text.empty?
    return parse_subfields(tag) unless tag.css('div.subfields').text.empty?
    false
  end

  def parse_subfields(tag)
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    subfields = tag.css('div.subfields').text.delete("\n").strip
    [[tag_id, subfields]]
  end

  def parse_control(tag)
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    control_field = tag.css('span.control_field_values').text.strip
    [[tag_id, control_field]]
  end

  def record_attributes

  end
end
