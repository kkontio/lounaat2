# encoding: UTF-8
class TommisPlugin
  parse_tommis = lambda do |url|
    # Result hash where the key is date and value an array of lunch item descriptions as strings.
    parsed_results = {}

    begin
      puts "TommisPlugin parsing url: #{url}"

      doc = ParserUtils.get_html_doc(url)
      content_arr = doc.css('#lounaslista ul > li').map {|e| LunchItemCleanser.cleanse(e.text)}

      today = Date.today
      monday = ParserUtils.find_previous_monday(today)

      for i in 0..4
        content_arr.shift while content_arr.first =~ /(maanantai|tiistai|keskiviikko|torstai|perjantai)/i
        lunch_items = []

        until content_arr.first =~ /(maanantai|tiistai|keskiviikko|torstai|perjantai|soppa & salde)/i
          lunch_items << content_arr.shift
        end

        parsed_results[monday + i] = lunch_items
      end

    rescue
      STDERR.puts "TommisPlugin failed to scrape info from #{url}: #{$!}"
    end

    return parsed_results
  end

  RestaurantProcessor.register_parser(/tommiskitchen\.fi/, parse_tommis)
end
