# encoding: UTF-8
desc 'Prevent our sole webdyno from idling'
task :heroku_unidle do
  require 'open-uri'
  begin
    html = open('http://lounaat2.herokuapp.com', :read_timeout => 10)
    html.read
    puts 'Pinged http://lounaat2.herokuapp.com'
  rescue
    puts 'Failed to read from http://lounaat2.herokuapp.com'
  end
end
