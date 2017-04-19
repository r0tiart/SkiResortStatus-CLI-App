class SkiResortStatus::Region
  attr_accessor :country, :region, :resorts

  #regions have multiple resorts
  def initialize(country)
    @country = country

    @resorts = []
  end

  def add_resort_by_name(resort_name)
    resort = SkiResortStatus::SkiResort.find_or_create_by_name(resort_name)
    resort.region = self
    @resorts << resort unless @resorts.include?(resort)
  end


end
