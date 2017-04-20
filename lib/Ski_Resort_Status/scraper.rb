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
    @rows = doc.css("tr")
    @rows.pop
    @rows.shift
    @rows.shift
    @rows
  end
  binding.pry

  def create_from_scrape
    @rows.each.do |table_row|
    name = table_row.css(".name").text
    depth = table_row.css(".rMid.c").css("b").text.split(" - ")
    base_depth = depth.first.gsub("\"", " inches")
    upper_depth = depth.last.gsub("\"", " inches")
  end
end
