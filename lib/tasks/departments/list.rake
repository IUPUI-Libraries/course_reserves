namespace :departments do
  require 'nokogiri'
  require 'open-uri'

  desc 'List IUPUI departments'
  task :list do
    puts 'Generate a list of IUPUI departments...'
    url = 'https://studentcentral.iupui.edu/register/schedule-of-classes/search/iupui-fall-2019'
    doc = Nokogiri::HTML(open(url))
    doc.css('select#department option').drop(1).each do |option|
      puts option.content
    end
  end
end
