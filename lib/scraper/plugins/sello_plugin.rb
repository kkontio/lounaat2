# encoding: UTF-8
class SelloPlugin
  parse_sello = lambda do |url|
    # Result hash where the key is date and value an array of lunch item descriptions as strings.
    parsed_results = {}

    # Check both the current and next week. Replace <cweek> in url with an actual week number.
    urls = []
    today = Date.today
    urls << {:url => url.gsub('<cweek>', format('%02d', today.cweek)), :url_date => today}
    urls << {:url => url.gsub('<cweek>', format('%02d', (today + 7).cweek)), :url_date => today + 7}

    urls.each do |h|
      begin
        puts "SelloPlugin parsing url: #{h[:url]}"

        doc = ParserUtils.get_html_doc(h[:url])

        doc.css('.lunch_list').each_with_index do |lunch_info, i|
          break if i > 4

          lunch_items = []

          lunch_info.css('li').each do |li|
            lunch_items << LunchItemCleanser.cleanse(li.content)
          end

          lunch_date = ParserUtils.find_previous_monday(h[:url_date]) + i
          parsed_results[lunch_date] = lunch_items
        end
      rescue
        STDERR.puts "SelloPlugin failed to scrape info from #{h[:url]}: #{$!}"
      end
    end

    return parsed_results
  end

  RestaurantProcessor.register_parser(/sello\.fi/, parse_sello)
end
