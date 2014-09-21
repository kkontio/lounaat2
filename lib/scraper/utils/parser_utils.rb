# encoding: UTF-8

# Class with some utility methods for parser plugins.
class ParserUtils
  # Public: Get HTML from the given url.
  #
  # url - URL that we HTTP GET
  #
  # Returns Nokogiri HTML document with UTF-8 encoding.
  def self.get_html_doc(url)
    html = open(url, read_timeout: 10)
    doc = Nokogiri::HTML(html.read)
    doc.encoding = 'utf-8'
    return doc
  end

  # Public: Utility function to deduce the last monday from the given date.
  #
  # date - Date to start the search from. Note that if the date given is monday we return it as is.
  #
  # Returns date that is the last monday from the date given as the parameter.
  # If the parameter date is monday, it will be returned as is.
  def self.find_previous_monday(date)
    previous_monday = date

    while (previous_monday.wday != 1)
      previous_monday = previous_monday - 1
    end

    return previous_monday
  end
end
