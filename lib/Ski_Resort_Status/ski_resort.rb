class SkiResortStatus::SkiResort
  attr_accessor :name, :region, :base_depth, :upper_depth, :lifts_open, :new_snow_24, :new_snow_72, :status

  @@all = []
<<<<<<< HEAD
  @@closed = []
  @@open = []
  @@weekend =[]
  @@open_plus_weekends = []

  def initialize(name)
    @name = name
    #resorts have 1 region
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.find_by_name(name)
    self.all.find { |instance| instance.name == name}
  end

  def self.create_by_name(name)
    self.new(name).tap { |resort| resort.save}
=======
  def initialize(name)
    @name = name
>>>>>>> ee3d92cf2954953953ac021a08be3320f3784988
  end

  def save
    @@all << self
<<<<<<< HEAD
    if self.status == "open"
      @@open << self
      @@open_plus_weekends << self
    elsif self.status == "closed"
      @@closed << self
    elsif self.status == "weekend"
      @@weekend << self
      @@open_plus_weekends << self
    end
=======
>>>>>>> ee3d92cf2954953953ac021a08be3320f3784988
  end

  def self.all
    @@all.dup.freeze
  end

<<<<<<< HEAD
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

  def region=(name)
    @region = name
    name.add_resort(self) unless name.resorts.include?(self)
  end

=======
>>>>>>> ee3d92cf2954953953ac021a08be3320f3784988
end
