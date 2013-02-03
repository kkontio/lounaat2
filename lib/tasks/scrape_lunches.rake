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
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
              desc.nil? ? desc = li_tag.content : desc = desc + "\n#{li_tag.content}"
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Café Buffo"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
              desc.nil? ? desc = li_tag.content : desc = desc + "\n#{li_tag.content}"
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Chico's"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/chico-s/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
              s = p_tag.content
              s = Unicode::downcase(s)
              s[0] = s[0].capitalize
              desc.nil? ? desc = s : desc = desc + "\n#{s}"
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Fennia"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
              s = p_tag.content
              s[0] = s[0].capitalize
              desc.nil? ? desc = s : desc = desc + "\n#{s}"
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Base"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
              desc.nil? ? desc = p_tag.content : desc = desc + "\n#{p_tag.content}"
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Carlito's"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/carlito-s/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
                desc.nil? ? desc = p_tag.content : desc = desc + "\n#{p_tag.content}"
              end
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
        end
      when "Lokki"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ilgabbiano/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'

        r = Restaurant.find_by_name(restaurant)
        puts "*** Scraping: #{r.name} ***"

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
                desc.nil? ? desc = p_tag.content : desc = desc + "\n#{p_tag.content}"
              end
            end
          end

          unless desc.nil?
            l = Lunch.find_or_create_by_restaurant_id_and_date(:restaurant_id => r.id, :date => d)
            l.description = desc
            l.save
          end
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

