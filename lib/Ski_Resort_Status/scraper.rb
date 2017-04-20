require "pry"
require "nokogiri"
require "open-uri"
class SkiResortStatus::Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape
    doc = Nokogiri::HTML(open(self.url))
    rows = doc.css("tr")
    rows.pop
    rows.shift
    rows.shift
    rows
  end
end
