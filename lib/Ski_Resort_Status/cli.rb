class SkiResortStatus::CLI
  def call
    puts "***********************************"
    puts "*    Welcome to the Snow Status    *"
    puts "***********************************"
    puts ""

    regions
  end

  def regions

    # while input != "exit"
      puts "Please Choose Region - by number"
      puts ""
      puts "1. Regions"
      puts "2. All"

      input = gets.chomp

      case input
      when "1"
        specific_region(input)
      when "2"
        specific_region(input)
      when "exit"
        puts "Logging out"
      else
        puts "Please re-enter the region number"
        input = gets.chomp
      end
    # end
  end

  def specific_region(region_number)
    region = region_number.to_i - 1
    region
  end


end
