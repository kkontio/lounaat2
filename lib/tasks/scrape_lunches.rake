# encoding: UTF-8
require 'scraper/scraper'
require 'scraper/parse_helper'
require 'scraper/restaurant_modules/retro_scraper'
namespace :scraper do
  include RetroScraper

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
      scraper = Scraper.new(r.url)
      scraper.fetch
      scraper.parse send("scrape_#{r.alias}")

      scraper.parsed_results.each do |date, lunch_items|
        save_lunch(r.id, date, lunch_items)
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
