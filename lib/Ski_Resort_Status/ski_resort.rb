class SkiResortStatus::SkiResort
  attr_accessor :name, :region, :base_depth, :upper_depth, :lifts_open, :new_snow_24, :new_snow_72, :status

  @@all = []
  def initialize(name)
    @name = name
  end

  def save
    @@all << self
  end

  def self.all
    @@all.dup.freeze
  end

end
