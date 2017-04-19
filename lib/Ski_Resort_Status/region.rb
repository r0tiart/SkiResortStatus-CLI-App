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
    region = self.all.find { |instance| instance.name == name}
    if region == nil
      new_region = self.new(name)
      new_region.save
      new_region
    else
      region
    end
  end


end
