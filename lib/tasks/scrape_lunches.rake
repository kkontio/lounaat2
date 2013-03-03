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
      when "Retro"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch", :read_timeout => 10)
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('li').map do |li_tag|
                unless li_tag.content.length < 3
                  desc ||= ""
                  desc << "<li>#{li_tag.content}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('li').map do |li_tag|
                unless li_tag.content.length < 3
                  s = li_tag.content
                  s = Unicode::downcase(s)
                  s[0] = Unicode::capitalize(s[0])
                  desc ||= ""
                  desc << "<li>#{s}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = Unicode::downcase(s)
                  s[0] = s[0].capitalize
                  desc ||= ""
                  desc << "<li>#{s}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Fennia"
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s[0] = Unicode::capitalize(s[0])
                  desc ||= ""
                  desc << "<li>#{s}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  desc ||= ""
                  desc << "<li>#{p_tag.content}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
          end
        rescue
          STDERR.puts "Failed to scrape info for #{r.name}: #{$!}"
        end
      when "Carlito's"
        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

        begin
          html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/carlito-s/showlunch", :read_timeout => 10)
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  desc ||= ""
                  desc << "<li>#{p_tag.content.gsub("\u00a0", ' ').strip}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
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

            desc = nil

            dd_tags.each do |dd_tag|
              dd_tag.css('p').map do |p_tag|
                unless p_tag.content.length < 3
                  s = p_tag.content
                  s = Unicode::downcase(s)
                  s[0] = '' if s[0] == '-'
                  s[0] = Unicode::capitalize(s[0])
                  desc ||= ""
                  desc << "<li>#{s}</li>"
                end
              end
            end

            unless desc.nil?
              l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
              l.description = desc
              l.save
            end
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

  restaurants = []
  restaurants << "Retro"
  restaurants << "Café Buffo"
  restaurants << "Chico's"
  restaurants << "Fennia"
  restaurants << "Base"
  restaurants << "Carlito's"
  restaurants << "Lokki"

  restaurants.each do |r|
    parse_lunch r
  end
end

