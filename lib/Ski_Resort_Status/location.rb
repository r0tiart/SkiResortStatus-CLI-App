class SkiResortStatus::Location
  #location has multiple regions
  attr_accessor :location

  @@all = []

  def initialize(location)
    @location = location
    @regions = []
  end

  def save
    @@all << self
  end

  def self.all
    @@all.dup.freeze
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.find_by_name(name)
    self.all.find { |instance| instance.location == name}
  end

  def self.create_by_name(name)
    self.new(name).tap { |location| location.save}
  end

  def add_region_by_name(region_name)
    region = SkiResortStatus::Region.find_or_create_by_name(region_name)
    region.location = self
    @regions << region unless @regions.include?(region)
  end

  def regions
    @regions.dup.freeze
  end
end
