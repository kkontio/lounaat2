# encoding: UTF-8
class PerobaPlugin
  parse_peroba = lambda do |url|
    # Result hash where the key is date and value an array of lunch item descriptions as strings.
    parsed_results = {}

    begin
      puts "PerobaPlugin parsing url: #{url}"

      doc = ParserUtils.get_html_doc(url)
      content_arr = doc.css('#menu > *').map {|e| LunchItemCleanser.cleanse(e.text)}

      content_arr.shift while content_arr.first.nil?
      lunch_week_number = content_arr.shift[/\d{1,2}/].to_i

      today = Date.today

      if today.cweek == lunch_week_number
        monday = ParserUtils.find_previous_monday(today)

        for i in 0..4
          content_arr.shift while content_arr.first.nil?  || content_arr.first =~ /(maanantai|tiistai|keskiviikko|torstai|perjantai)/i
          lunch_items = []

          until content_arr.first.nil?  || content_arr.first =~ /(maanantai|tiistai|keskiviikko|torstai|perjantai)/i
            lunch_items << content_arr.shift.gsub(/\s*\|.*$/, '')
          end

          parsed_results[monday + i] = lunch_items
        end

      end
    rescue
      STDERR.puts "PerobaPlugin failed to scrape info from #{url}: #{$!}"
    end

    return parsed_results
  end

  RestaurantProcessor.register_parser(/perobacafe\.fi/, parse_peroba)
end
