class SkiResortStatus::SkiResort
  attr_accessor :name, :region, :base_depth, :upper_depth, :lifts_open, :new_snow_24, :new_snow_72, :status

  @@all = []
  @@closed = []
  @@open = []
  @@weekend =[]
  @@open_plus_weekends = []

  def initialize(name)
    @name = name
    #resorts have 1 region
  end

  def self.find_or_create_by_name(name)
    resort = self.all.find { |instance| instance.name == name}
    if resort == nil
      new_resort = self.new(name)
      new_resort.save
      new_resort
    else
      resort
    end
  end

  def save
    @@all << self
    if self.status == "open"
      @@open << self
      @@open_plus_weekends << self
    elsif self.status == "closed"
      @@closed << self
    elsif self.status == "weekend"
      @@weekend << self
      @@open_plus_weekends << self
    end
  end

  def self.all
    @@all.dup.freeze
  end

  def self.closed
    @@closed.dup.freeze
  end

  def self.open
    @@open.dup.freeze
  end

  def self.weekend
    @@weekend.dup.freeze
  end

  def self.all_open
    @@open_plus_weekends.dup.freeze
  end

end
