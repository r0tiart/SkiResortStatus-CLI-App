class SkiResortStatus::Region
  attr_accessor  :region, :location

  @@all = []
  #regions have multiple resorts
  #region has 1 location
  def initialize(region)
    @region = region

    @resorts = []
  end

  def add_resort_by_name(resort_name)
    resort = SkiResortStatus::SkiResort.find_or_create_by_name(resort_name)
    resort.region = self
    @resorts << resort unless @resorts.include?(resort)
  end

  def resorts
    @resorts.dup.freeze
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
    self.all.find { |instance| instance.region == name}
  end

  def self.create_by_name(name)
    self.new(name).tap { |region| region.save}
  end

  def add_resort(resort)
    @resorts << resort unless @resorts.include?(resort)
    resort.region = self unless resort.region == self
  end

  def location=(location)
    @location = location
    location.add_region(self) unless location.regions.include?(self)
  end
end
