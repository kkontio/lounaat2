module SelloParser
  def parse_sello
    lambda do |doc, url_date|
      previous_monday = url_date

      while (previous_monday.wday != 1)
        previous_monday = previous_monday - 1
      end

      parsed_results = {}

      doc.css('.lunch_list').each_with_index do |lunch_info, i|
        break if i > 4

        lunch_date = previous_monday + i
        lunch_items = []

        lunch_info.css('li').each do |li|
          lunch_items << ParseHelper.cleanse(li.content)
        end

        parsed_results[lunch_date] = lunch_items
      end

      return parsed_results
    end
  end
end
