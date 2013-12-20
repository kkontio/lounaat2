module RetroScraper
  def scrape_retro
    lambda do |doc|
      parsed_results = {}
      parsed_results[Date.today] = ['jeeboingggg']
      return parsed_results
    end
  end
end
