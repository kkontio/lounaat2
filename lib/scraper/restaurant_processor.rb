# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'date'
require 'unicode'
require 'scraper/utils/parser_utils'
require 'scraper/utils/lunch_item_cleanser'

# This class processes lunches for restaurants.
#
# More specifically, parsing plugins register a url pattern (regexp) and lambda
# to handle parsing lunches from urls that match the pattern.
#
class RestaurantProcessor

  # Public: Register parser for url.
  #
  # url_pattern - Regexp to match the urls this block will handle.
  # l           - Lambda which parses lunches from the url that
  #               is given as a parameter to the lambda.
  #
  # The lambda should return a hash where the keys are dates and the values are arrays
  # containing lunch item descriptions (strings) for that day.
  #
  # Returns nothing.
  def self.register_parser(url_pattern, l)
    @patterns ||= {}
    @patterns[url_pattern] = l
  end

  # Public: Process lunch info for the restaurant given as a parameter.
  #
  # r - Restaurant to process.
  #
  # This method will save the latest lunch info for this restaurant to the database.
  #
  # Returns nothing.
  def self.process_restaurant(r)
    _, parser = @patterns.find{|p, _| r.url =~ p}

    if parser
      begin
        lunches = parser.call(r.url)
        save_parsed_lunches(r, lunches)
      rescue
        STDERR.puts "Plugin failed while parsing: #{r.url}"
      end
    end
  end

  private

  # Private: Save parsed lunches to the db.
  #
  # r                   - Restaurant to which the lunches belong to.
  # lunch_items_by_date - Hash where keys are dates and values are arrays of
  #                       lunch descriptions (strings).
  #
  # Returns nothing.
  def self.save_parsed_lunches(r, lunch_items_by_date)
    lunch_items_by_date.each do |date, lunch_items|
      save_lunch(r, date, lunch_items)
    end
  end

  # Private: Helper method that saves lunches for single restaurant and date to the db.
  #
  # r           - Restaurant to which the lunches belong to.
  # date        - Lunch date.
  # lunch_items - Array of strings that represent the lunch items.
  #
  # Returns nothing.
  def self.save_lunch(r, date, lunch_items)
    # Update the lunch info but do not override old info if the new info is non-existent.
    unless lunch_items.nil? || lunch_items.empty?
      l = Lunch.find_or_create_by_restaurant_id_and_date(restaurant_id: r.id, date: date)

      LunchItem.destroy_all(lunch_id: l.id)

      lunch_items.each do |lunch_item|
        LunchItem.create(lunch_id: l.id, description: lunch_item)
      end
    end
  end

  # Load all the plugins.
  Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each {|file| require file }
end
