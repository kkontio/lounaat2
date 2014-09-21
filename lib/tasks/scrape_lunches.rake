# encoding: UTF-8
require 'scraper/restaurant_processor'

desc 'Fetch lunch info from the interwebs.'
task :scrape_lunches => :environment do
  puts "Scrape started #{Time.now.to_s}"

  Restaurant.where('url is not null').each do |r|
    puts "Processing restaurant #{r.name}."
    RestaurantProcessor.process_restaurant r
  end
end
