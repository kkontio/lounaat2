# encoding: UTF-8
require 'scraper/scraper'
require 'scraper/parse_helper'
require 'scraper/restaurant_modules/sello_parser'

namespace :scraper do
  include SelloParser

  desc 'Fetch lunch info from the interwebs'
  task :scrape_lunches => :environment do
    puts "Scrape started #{Time.now.to_s}"

    Restaurant.where('url is not null').each do |r|
      scrape_restaurant r
    end
  end

  def scrape_restaurant(r)
    puts "*** Scraping: #{r.name} ***"

    begin
      today = Date.today
      for i in 0..1
        if i == 0
          puts "This week."
        else
          puts "Next week."
        end

        url_date = today + i * 7
        url = r.url.gsub('<cweek>', format('%02d', url_date.cweek))
        scraper = Scraper.new(url, url_date)
        scraper.fetch
        scraper.parse parse_sello

        scraper.parsed_results.each do |date, lunch_items|
          save_lunch(r.id, date, lunch_items)
        end
      end
    rescue
      STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
    end
  end

  def save_lunch(restaurant_id, date, lunch_items)
    unless lunch_items.nil? || lunch_items.empty?
      l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => restaurant_id, :date => date)

      LunchItem.delete_all(:lunch_id => l.id)

      lunch_items.each do |lunch_item|
        LunchItem.create(:lunch_id => l.id, :description => lunch_item)
      end
    end
  end
end
