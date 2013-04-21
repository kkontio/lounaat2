# encoding: UTF-8
desc "Fetch lunch info from Sello's lunch list"
task :scrape_lunches => :environment do
  require "nokogiri"
  require "open-uri"
  require "date"
  require "unicode"

  # TODO: Year change will screw the date parsing!
  def parse_lunch(restaurant)
    case restaurant
      when 'Retro'
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open('http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch', :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('li').map do |li_tag|
                unless li_tag.content.length < 3
                  s = li_tag.content
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Café Buffo"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('li').map do |li_tag|
                unless li_tag.content.length < 3
                  s = li_tag.content
                  s = Unicode::downcase(s)
                  s[0] = Unicode::capitalize(s[0])
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Chico's"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/chico-s/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = Unicode::downcase(s)
                  s[0] = s[0].capitalize
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Ravintola Fennia"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s[0] = Unicode::capitalize(s[0])
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Base"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "GLO Grill Kitchen"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/glo-grill-kitchen/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content.gsub("\u00a0", ' ').strip
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Lokki"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ilgabbiano/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = Unicode::downcase(s)
                  s = s.gsub(/[[:space:]]/, ' ')
                  s = s.strip
                  s[0] = '' if s[0] == '-'
                  s = s.strip
                  s[0] = Unicode::capitalize(s[0])
                  s = beautify_allergies(s)
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Bar Fennia"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/bar-fennia/showlunch", :read_timeout => 10)
          doc = Nokogiri::HTML(html.read)
          doc.encoding = 'utf-8'

          # Each date is contained in a dt element
          doc.xpath('//dt').each do |dt_tag|
            d = parse_date(dt_tag.content)

            # Each lunch is contained in a dd element
            dd_tags = []

            n = dt_tag.next_element
            while n && n.name == 'dd'
              dd_tags << n
              n = n.next_element
            end

            lunch_items = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = beautify_allergies(s)
                  s[0] = Unicode::capitalize(s[0])
                  lunch_items ||= []
                  lunch_items << LunchItem.new(:description => s)
                end
              end
            end

            save_lunch(r.id, d, lunch_items)
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      else
        puts "*** #{restaurant} not implemented ***"
    end
  end

  def parse_date(date_string)
    Date::strptime(/\d{1,2}\.\d{1,2}\./.match(date_string).to_s + Time.now.year.to_s, '%d.%m.%Y')
  end

  def beautify_allergies(s)
    partitions = s.partition(/\(\s*(vl|[lg])\s*((\/|,)\s*(vl|[lg]))*\s*\)/i)
    unless partitions[1].empty?
      partitions[1] = partitions[1].gsub(/[[:space:]]/, '')
      partitions[1] = Unicode::upcase(partitions[1])
    end
    return partitions.join
  end

  def save_lunch(restaurant_id, date, lunch_items)
    unless lunch_items.empty?
      l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => restaurant_id, :date => date)
      LunchItem.find_all_by_lunch_id(l.id).each do |li|
        li.destroy
      end

      lunch_items.each do |li|
        li.lunch_id = l.id
        li.save
      end
    end
  end

  puts "Scrape started #{Time.now.to_s}"

  Restaurant.all.each do |r|
    parse_lunch r.name
  end
end

