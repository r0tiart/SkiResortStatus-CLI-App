class SkiResortStatus::Controller

  attr_reader :resorts, :open, :weekend, :closed, :every_open

  def resorts
    @resorts.dup.freeze
  end

  def open
    @open.dup.freeze
  end

  def weekend
    @weekend.dup.freeze
  end

  def closed
    @closed.dup.freeze
  end

  def every_open
    @every_open.dup.freeze
  end

  def scrape_website
    usa = SkiResortStatus::Scraper.new("https://www.onthesnow.com/united-states/skireport.html")
    usa.scrape
    usa.create_from_scrape

    canada = SkiResortStatus::Scraper.new("https://www.onthesnow.com/canada/skireport.html")
    canada.scrape
    canada.create_from_scrape
  end

  def list_locations
    SkiResortStatus::Location.all.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.location}"
    end
  end

  def list_regions(location)
    location.regions.each.with_index(1) do |instance, index|
      puts "#{index}. #{instance.region}"
    end
  end

  def current_region(location, number)
    region = location.regions[number.to_i - 1 ]
    region
  end

  def current_location(location_number)
    location = SkiResortStatus::Location.all[location_number.to_i - 1]
    location
  end

  def list_resorts(current_region)
    @resorts = current_region.resorts
    @resorts
  end

  def open_resorts(current_region)
    @open = self.list_resorts(current_region).select {|resort| resort.status == "open"}

    if @open.length == 0
      puts ""
      puts "No resorts are open in the sepcified region"
      puts " "
      puts "Enter 'exit' - to log out, 'main' - to go back to the main menu or 'back' to return to the region selector"
    else
      @open.each.with_index(1) do |attribute, index|
        puts "#{index}. #{attribute.name} - #{attribute.region.region}, #{attribute.status}"
      end

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""
    end
  end

  def weekend_resorts(current_region)
    @weekend = self.list_resorts(current_region).select {|resort| resort.status == "weekend"}

    if @weekend.length == 0
      puts ""
      puts "No resorts are only opened on weekends in the sepcified region"
      puts " "
      puts "Enter 'exit' - to log out, 'main' - to go back to the main menu or 'back' to return to the region selector"
    else
      @weekend.each.with_index(1) do |attribute, index|
        puts "#{index}. #{attribute.name} - #{attribute.region.region}, #{attribute.status}"
      end

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""
    end
  end

  def all_open(current_region)
    @every_open = self.list_resorts(current_region).select {|resort| resort.status != "closed"}

    if @every_open.length == 0
      puts ""
      puts "No resorts are open in the sepcified region"
      puts " "
      puts "Enter 'exit' - to log out, 'main' - to go back to the main menu or 'back' to return to the region selector"
    else
      @every_open.each.with_index(1) do |attribute, index|
        puts "#{index}. #{attribute.name} - #{attribute.region.region}, #{attribute.status}"
      end

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""
    end
  end

  def all_resorts(current_region)

    self.list_resorts(current_region).each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region.region}, #{attribute.status}"
    end

    puts ""
    puts "Please select resort you want to learn more about"
    puts ""

  end

  def closed_resorts(current_region)
    @closed = self.list_resorts(current_region).select {|resort| resort.status == "closed"}

    if @closed.length == 0
      puts ""
      puts "No resorts are closed in the sepcified region"
      puts " "
      puts "Enter 'exit' - to log out, 'main' - to go back to the main menu or 'back' to return to the region selector"
    else
      @closed.each.with_index(1) do |attribute, index|
        puts "#{index}. #{attribute.name} - #{attribute.region.region}, #{attribute.status}"
      end

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""
    end
  end

  def resort_details(input,status)
    case status
    when "all"
      resort = self.resorts[input.to_i - 1]
      puts ""
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
      puts ""
    when "open"
      resort = self.open[input.to_i - 1]
      puts ""
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
      puts ""
    when "weekend"
      resort = self.weekend[input.to_i - 1]
      puts ""
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
      puts ""
    when "all_open"
      resort = self.every_open[input.to_i - 1]
      puts ""
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
      puts ""
    when "closed"
      resort = self.closed[input.to_i - 1]
      puts ""
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
      puts ""
    end
  end
end
