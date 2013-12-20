# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'date'
require 'unicode'

class Scraper

  attr_accessor :url, :doc, :parsed_results

  def initialize(url)
    @url = url
  end

  def fetch
    html = open(@url, :read_timeout => 10)
    @doc = Nokogiri::HTML(html.read)
    @doc.encoding = 'utf-8'
  end

  def parse(scrape_proc)
    begin
      @parsed_results = scrape_proc.call(@doc)
    rescue
      raise "Failed to scrape info from #{@url.to_s}: #{$!}"
    end
  end
end
