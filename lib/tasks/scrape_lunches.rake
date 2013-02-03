# encoding: UTF-8
desc "Fetch lunch info from Sello's lunch list"
task :scrape_lunches => :environment do
  require "nokogiri"
  require "open-uri"

  def parse_lunch(restaurant)
    case restaurant
      when "retro"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-retro/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('li').map do |li_tag|
              puts "  * #{li_tag.content}"
            end
          end
        end
      when "buffo"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/caf-buffo/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('li').map do |li_tag|
              puts "  * #{li_tag.content}"
            end
          end
        end
      when "chicos"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/chico-s/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('p').map do |p_tag|
              puts "  * #{p_tag.content}"
            end
          end
        end
      when "fennia"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-fennia/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('p').map do |p_tag|
              puts "  * #{p_tag.content}"
            end
          end
        end
      when "base"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ravintola-base/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('p').map do |p_tag|
              puts "  * #{p_tag.content}"
            end
          end
        end
      when "carlitos"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/carlito-s/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('p').map do |p_tag|
              puts "  * #{p_tag.content}" unless p_tag.content.length < 3
            end
          end
        end
      when "lokki"
        html = open("http://sello.fi/fi/liikkeet/ravintolat-ja-kahvilat/ilgabbiano/showlunch")
        doc = Nokogiri::HTML(html.read)
        doc.encoding = 'utf-8'
        title = doc.at_css('.lounasfooter b').content

        puts "*** #{title} ***"

        # Each day is an dt element
        doc.xpath('//dt').each do |dt_tag|
          puts dt_tag.content

          # Each lunch is contained in a dd element
          dd_tags = []
          n = dt_tag.next_element

          while n && n.name == 'dd'
            dd_tags << n
            n = n.next_element
          end

          dd_tags.each do |dd_tag|
            dd_tag.css('p').map do |p_tag|
              puts "  * #{p_tag.content}" unless p_tag.content.length < 3
            end
          end
        end
      else
        puts "*** #{restaurant} not implemented ***"
    end
  end


  restaurants = []
  restaurants << "retro"
  restaurants << "buffo"
  restaurants << "chicos"
  restaurants << "fennia"
  restaurants << "base"
  restaurants << "carlitos"
  restaurants << "lokki"
  restaurants << "test"

  restaurants.each do |r|
    parse_lunch r
  end
end

