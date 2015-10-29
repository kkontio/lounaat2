# encoding: UTF-8
class K1Plugin
  parse_k1 = lambda do |url|
    # Result hash where the key is date and value an array of lunch item descriptions as strings.
    parsed_results = {}

    begin
      puts "K1Plugin parsing url: #{url}"

      params = {'ajax' => 'true', 'restaurant_id' => '1'}
      url = URI.parse(url)
      response = Net::HTTP.post_form(url, params)

      doc = Nokogiri::HTML(response.body)
      doc.encoding = 'utf-8'

      lunches_by_day = doc.css('.lunchlist-day')

      today = Date.today
      lunch_week_number = doc.css(".header-container").text.match(/viikko\s+(?<week_number>\d{1,2})/i)[:week_number].to_i

      if today.cweek == lunch_week_number        
        monday = ParserUtils.find_previous_monday(today)

        for i in 0..4
          parsed_results[monday + i] = lunches_by_day[i].css('.description').map {|e| LunchItemCleanser.cleanse(e.text)}
        end
      end

    rescue
      STDERR.puts "K1Plugin failed to scrape info from #{url}: #{$!}"
    end

    return parsed_results
  end

  RestaurantProcessor.register_parser(/kanresta\.fi/, parse_k1)
end
