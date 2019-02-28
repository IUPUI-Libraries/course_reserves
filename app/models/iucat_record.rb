class IucatRecord
  require 'open-uri'

  def initialize(record_string)
    unless record_string.include? "http"
      record_string = "https://iucat.iu.edu/catalog/#{record_string}/librarian_view"
    else
      record_string += '/librarian_view'
    end
    @record = Nokogiri::HTML(open(record_string)).css('div#marc_view div.field')
  end

  # Returns Hash or arrays
  def data
    data = {}
    @record.each do |tag|
      info = parse_tag(tag)
      info.each { |key, val| data.key?(key) ? data[key] << val : data[key] = [val] } if info
    end
    data
  end

  private

  def parse_tag(tag)
    return parse_control(tag) unless tag.css('span.control_field_values').text.empty?
    return parse_subfields(tag) unless tag.css('div.subfields').text.empty?
    false
  end

  def parse_subfields(tag)
    data = {}
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    subfields = tag.css('div.subfields')
    subfields_split = subfields.inner_html.split(/\<span class="sub_code">.*\<\/span\>/)
    subfield_codes = subfields.css('span.sub_code')
    i = 1
    subfield_codes.each do |subfield_code|
      sub_code = subfield_code.text.delete("|").strip
      subtag_id = "#{tag_id}#{sub_code}"
      sub_val = subfields_split[i].delete("\n").strip
      sub_val.chop!.strip! if sub_val.end_with?('/')
      data[subtag_id] = sub_val
      i += 1
    end
    data
  end

  def parse_control(tag)
    tag_id = tag.css('div.tag_ind span.tag').text.delete(" \n")
    control_field = tag.css('span.control_field_values').text.strip
    { tag_id => control_field }
  end
end
