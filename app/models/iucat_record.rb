class IucatRecord
  require 'open-uri'

  def initialize(record_string)
    @record = Nokogiri::HTML(open("https://iucat.iu.edu/catalog/#{record_string}/librarian_view")).css('div#marc_view div.field')
  end

  def data
    data = Hash.new
    @record.each do |tag|
      info = parse_tag(tag);
      data = data.merge(info) if info
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
    data = Hash.new
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    subfields = tag.css('div.subfields')
    subfields_split = subfields.inner_html.split(/\<span class="sub_code">.*\<\/span\>/)
    # puts "--------------"
    # puts subfields_split
    # puts "--------------"
    subfield_codes = subfields.css('span.sub_code')
    i = 1
    subfield_codes.each do |subfield_code|
      sub_code = subfield_code.text.delete("|").strip
      subtag_id = "#{tag_id}#{sub_code}"
      data[subtag_id] = subfields_split[i].delete("\n").strip
      i = i + 1
    end
    return data
  end

  def parse_control(tag)
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    control_field = tag.css('span.control_field_values').text.strip
    return { tag_id => control_field }
  end

  def record_attributes

  end
end
