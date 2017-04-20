class SkiResortStatus::Controller


  def list_locations
    SkiResortStatus::Location.all.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.location}"
    end
  end

  def list_regions(input)
    location = SkiResortStatus::Location.all[input.to_i - 1]
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

  def open_resorts
    SkiResortStatus::SkiResort.open.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def weekend_resorts
    SkiResortStatus::SkiResort.weekend.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def all_open
    SkiResortStatus::SkiResort.all_open.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def all_resorts
    SkiResortStatus::SkiResort.all.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def closed_resorts
    SkiResortStatus::SkiResort.closed.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def resort_details(input,status)
    case status
    when "all"
      resort = SkiResortStatus::SkiResort.all[input.to_i - 1]
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
    when "open"
      resort = SkiResortStatus::SkiResort.open[input.to_i - 1]
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
    when "weekend"
      resort = SkiResortStatus::SkiResort.weekend[input.to_i - 1]
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
    when "all_open"
      resort = SkiResortStatus::SkiResort.all_open[input.to_i - 1]
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
    when "closed"
      resort = SkiResortStatus::SkiResort.closed[input.to_i - 1]
      puts "-----#{resort.name}-----"
      puts "Location: #{resort.region}"
      puts "Status: #{resort.status}"
      puts "Snowfall 24hr/72hr #{resort.new_snow_24}/#{resort.new_snow_72}"
      puts "Base/Upper Depths #{resort.base_depth} / #{resort.upper_depth}"
      puts "Lifts open #{resort.lifts_open}"
    end
  end
end
