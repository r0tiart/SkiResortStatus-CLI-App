class SkiResortStatus::Location
  #location has multiple regions
  attr_accessor :location

  @@all = []

  def initialize(location)
    @location = location
    @region = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all.dup.freeze
  end

  def self.find_or_create_by_name(name)
    location = self.all.find { |instance| instance.name == name}
    if location == nil
      new_location = self.new(name)
      new_location.save
      new_location
    else
      location
    end
  end

  def add_location_by_name(region_name)
    region = SkiResortStatus::Region.find_or_create_by_name(region_name)
    region.location = self
    @region << region unless @region.include?(region)
  end

  def regions
    @region.dup.freeze
  end
end
