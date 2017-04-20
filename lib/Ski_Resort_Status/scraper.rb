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

  def create_from_scrape
    @rows.each do |table_row|
      name = table_row.css(".name").text
      depth = table_row.css(".rMid.c").css("b").text.split(" - ")
      base_depth = depth.first
      upper_depth = depth.last
      # new_snow_24 = table_row.css(".rLeft.b").css("b").first.text
      new_snow_72 = table_row.css(".rLeft.b").css("b").last.text
      lifts_open = table_row.css(".rMid")[2].text
      region = table_row.css(".rRegion").css("a").attr("title").value

      if table_row.at_css(".openstate.stateD1") != nil
        status = "open"
      elsif table_row.at_css(".openstate.stateD4") != nil
        status = "weekend"
      elsif table_row.at_css(".openstate.stateD6") != nil
        status = "closed"
      end

      new_resort = SkiResortStatus::SkiResort.find_or_create_by_name(name)
      new_resort.region = SkiResortStatus::Region.find_or_create_by_name(region)
      new_resort.base_depth = base_depth
      new_resort.upper_depth = upper_depth
      new_resort.lifts_open = lifts_open
      # new_resort.new_snow_24 = new_snow_24
      new_resort.new_snow_72 = new_snow_72
    end

  end
end
