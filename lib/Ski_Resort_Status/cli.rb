class SkiResortStatus::CLI
  attr_accessor :current_location, :current_region, :controller


  def initialize
    @controller = SkiResortStatus::Controller.new
  end

  def call # welcome screen
    puts "***********************************"
    puts "*    Welcome to the Snow Status    *"
    puts "***********************************"
    puts ""

    main
  end

  def main #main menu - list locations and choose location
    puts ""
    self.controller.list_locations
    puts ""

    input = nil
    # location_number = input

    while input != "exit"
      puts "Please Choose Location - by number"
      puts ""

      input = gets.strip

      if input.to_i.between?(1,SkiResortStatus::Location.all.length)
        self.current_location = controller.current_location(input)

        self.regions_menu(current_location) #calls to list the regions by selected location
        break
      else
        puts "Please re-enter the location number"
        input = gets.strip
        # location_number = input #location in the @@all array for location class
      end
    end
    self.exit
  end

  def regions_menu(region) #lists regions - and ask to choose specific region

    puts ""
    self.controller.list_regions(region)
    puts ""

    input = nil

    while input != "exit"
      puts "Please Choose Region - by number"
      puts ""

      input = gets.strip

      if input.to_i.between?(1,current_location.regions.length)

        self.current_region = controller.current_region(current_location, input) #pulls the instance of the region

        self.resort_menu(current_region)
        break
      elsif input == "main"
        self.main
        break
      else
        puts "Please re-enter the location number"
        input = gets.strip
      end
    end
    puts input

    self.exit
  end

  def resort_menu(region)

    puts "--------#{region.region}--------"
    puts ""
    puts "What would you like to see for the #{region.region} region"
    puts "  1) List all open resorts"
    puts "  2) List all resorts only open on weekends"
    puts "  3) List all resorts that are open or open on weekends only"
    puts "  4) List all resorts including closed resorts"
    puts "  5) List all closed resorts"
    puts ""

    input = gets.strip
    case input
    when "1"
      @controller.open_resorts

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""

      input = gets.strip
      status = "open"

      until input.to_i.between?(1,current_region.resorts.length)
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.strip
      end

      self.controller.resort_details(input,status)

      restart?
    when "2"
      self.controller.weekend_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.strip
      status = "weekend"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.strip
      end

      self.controller.resort_details(input,status)

      restart?
    when "3"
      self.controller.all_open

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.strip
      status = "all_open"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.strip
      end

      self.controller.resort_details(input,status)

      restart?
    when "4"
      self.controller.all_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.strip
      status = "all"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.strip
      end

      self.controller.resort_details(input,status)

      restart?
    when "5"
      self.controller.closed_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.strip
      status = "closed"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.strip
      end

      self.controller.resort_details(input,status)

      self.restart?

    when "main"
      self.main
    when "regions"
      self.regions_menu(current_location)
    when "back"
      self.resort_menu(current_region)
    when "exit"
      self.exit
    else
      "Please re-enter input"

      input = gets.strip
    end
  end

  def restart?
    puts ""
    puts "Would you like to go back to the current region menu?"
    puts""
    puts "If not please type exit or main to return to the main menu"

    input = gets.strip

    case input
    when "yes"
      self.regions_menu(current_region)
    when "exit"
      puts "Logging out"
    when "main"
      self.main
    else
      puts "Please type yes to return the specified region"
      puts "Type exit to log out or main to continue to the main menu"
      input = gets.strip
    end
  end

  def exit
    puts ""
    puts "logging out"
  end

end
