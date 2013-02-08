# encoding: UTF-8
desc 'Prevent our sole webdyno from idling'
task :heroku_unidle do
  require 'open-uri'
  begin
    html = open('http://lounaat2.herokuapp.com')
    html.read
    puts 'Pinged http://lounaat2.herokuapp.com'
  rescue
    puts 'Failed to read from http://lounaat2.herokuapp.com'
  end
end
