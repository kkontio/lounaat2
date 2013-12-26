# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'date'
require 'unicode'

class Scraper

  attr_accessor :url, :doc, :parsed_results, :url_date

  def initialize(url, url_date)
    @url = url
    @url_date = url_date
  end

  def fetch
    html = open(@url, :read_timeout => 10)
    @doc = Nokogiri::HTML(html.read)
    @doc.encoding = 'utf-8'
  end

  def parse(scrape_proc)
    begin
      @parsed_results = scrape_proc.call(@doc, @url_date)
    rescue
      raise "Failed to scrape info from #{@url.to_s}: #{$!}"
    end
  end
end
