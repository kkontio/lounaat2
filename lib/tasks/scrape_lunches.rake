# encoding: UTF-8
namespace :scraper do
  require 'nokogiri'
  require 'open-uri'
  require 'date'
  require 'unicode'

  desc "Fetch lunch info from Sello's lunch list"
  task :scrape_lunches => :environment do
    puts "Scrape started #{Time.now.to_s}"
    Restaurant.all.each { |r| scrape_restaurant r }
  end

  private

  def scrape_restaurant(restaurant)
    puts "*** Scraping: #{restaurant.name} ***"

    begin
      doc = fetch_html_document(restaurant)
      lunches_by_date = parse_lunches_from_html(doc)

      lunches_by_date.each do |date, lunch_items|
        save_lunch(restaurant.id, date, lunch_items)
      end
    rescue
      STDERR.puts "Failed to scrape info for #{restaurant.name}: #{$!}"
    end
  end

  def parse_lunches_from_html(document)
    lunches_by_date = {}

    # Each date is contained in a dt element
    document.xpath('//dt').each do |dt_tag|
      lunch_date = parse_date(dt_tag.content)

      # Each lunch is contained in a dd element
      dd_tags = []

      element = dt_tag.next_element
      while element && element.name == 'dd'
        dd_tags << element
        element = element.next_element
      end

      lunch_items = nil

      dd_tags.each do |dd_tag|
        dd_tag.element_children.each do |child_element|
          # TODO: fix this ugliest hack ever to get retro working for now.
          if child_element.name == 'ul'
            child_element.children.each do |ul_child|
              unless ul_child.content.length < 3
                raw_lunch_item = ul_child.content
                sanitized_lunch_item = sanitize_lunch_item(raw_lunch_item)
                lunch_items ||= []
                lunch_items << LunchItem.new(:description => sanitized_lunch_item)
              end
            end
            # and else gets every other restaurant
          else
            unless child_element.content.length < 3
              raw_lunch_item = child_element.content
              sanitized_lunch_item = sanitize_lunch_item(raw_lunch_item)
              lunch_items ||= []
              lunch_items << LunchItem.new(:description => sanitized_lunch_item)
            end
          end
        end
      end

      lunches_by_date[lunch_date] = lunch_items
    end

    return lunches_by_date
  end

  def fetch_html_document(restaurant)
    raise 'Scrape URL missing' if restaurant.url.nil?
    html = open(restaurant.url, :read_timeout => 10)
    doc = Nokogiri::HTML(html.read)
    doc.encoding = 'utf-8'
    return doc
  end

  # Unfortunately the date string in the html does not contain year information.
  # So we'll try to do some contextual deducting whether the given date
  # actually refers this year or the previous one.
  def parse_date(date_string)
    d = Date::strptime(/\d{1,2}\.\d{1,2}\./.match(date_string).to_s + Time.now.year.to_s, '%d.%m.%Y')

    # If it's December and the date seems to be in January it's probably referring the next years January
    if d.month == 1 && Time.now.month == 12
      return d.next_year
    # However if it's January and the date is in December it is very likely to refer last year
    elsif d.month == 12 && Time.now.month == 1
      return d.prev_year
    # Otherwise we assume the date actually refers the current calendar year
    else
      return d
    end
  end

  def beautify_allergies(lunch_item)
    partitions = lunch_item.partition(/\(\s*(vl|[lg])\s*((\/|,)\s*(vl|[lg]))*\s*\)/i)
    unless partitions[1].empty?
      partitions[1] = partitions[1].gsub(/[[:space:]]/, '')
      partitions[1] = Unicode::upcase(partitions[1])
    end
    return partitions.join
  end

  def sanitize_lunch_item(lunch_item)
    lunch_item = lunch_item.gsub("\u00a0", ' ').strip
    lunch_item = lunch_item.gsub(/[[:space:]]+/, ' ').strip
    lunch_item = Unicode::downcase(lunch_item)

    while lunch_item[0] == '-'
      lunch_item[0] = ''
    end

    lunch_item[0] = Unicode::capitalize(lunch_item[0])
    lunch_item = beautify_allergies(lunch_item)

    return lunch_item
  end

  def save_lunch(restaurant_id, date, lunch_items)
    unless  lunch_items.nil? || lunch_items.empty?
      l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => restaurant_id, :date => date)

      LunchItem.find_all_by_lunch_id(l.id).each { |lunch_item| lunch_item.destroy }

      lunch_items.each do |lunch_item|
        lunch_item.lunch_id = l.id
        lunch_item.save
      end
    end
  end
end