namespace :departments do
  require 'nokogiri'
  require 'open-uri'

  desc 'Create seeds for department table'
  task seed: :environment do
    url = 'https://studentcentral.iupui.edu/register/schedule-of-classes/search/iupui-fall-2019'
    doc = Nokogiri::HTML(open(url))
    puts 'Department.destroy_all'
    puts ''
    doc.css('select#department option').drop(1).each do |option|
      content = option.content.gsub("'", %q(\\\'))
      puts "Department.create(name: '#{content}', active: true)"
    end
  end
end
