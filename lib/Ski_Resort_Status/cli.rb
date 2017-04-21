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

    puts ""
    puts "Loading resort details"
    @controller.scrape_website
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
        input = "exit"
      elsif input == "exit"
        input = "exit"
      else
        puts "Please re-enter the location number"
        input = gets.strip
        # location_number = input #location in the @@all array for location class
      end
    end
    puts ""
    puts "logging out"
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
        input = "exit"
      elsif input == "main"
        self.main
        input = "exit"
      elsif input == "exit"
        input = "exit"
      else
        puts "Please re-enter the location number"
        input = gets.strip
      end
    end
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
    puts "You can enter 'exit' - to log out, 'main' - to go back to the main menu or 'back' to return to the region selector"
    puts ""

    input = gets.strip
    while input != "exit"
      case input
      when "1"
        @controller.open_resorts(region)

        input = gets.strip
        status = "open"

        until input.to_i.between?(1,current_region.resorts.length)
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          input = gets.strip
        end

        self.controller.resort_details(input,status)
        input = "exit"
        restart?
      when "2"
        self.controller.weekend_resorts(region)

        input = gets.strip
        status = "weekend"

        until input.to_i > 0
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          input = gets.strip
        end

        self.controller.resort_details(input,status)
        input = "exit"
        restart?
      when "3"
        self.controller.all_open(region)

        input = gets.strip
        status = "all_open"

        until input.to_i > 0
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          input = gets.strip
        end

        self.controller.resort_details(input,status)
        input = "exit"
        restart?
      when "4"
        self.controller.all_resorts(region)

        input = gets.strip
        status = "all"

        until input.to_i > 0
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          input = gets.strip
        end

        self.controller.resort_details(input,status)
        input = "exit"
        restart?
      when "5"
        self.controller.closed_resorts(region)

        input = gets.strip
        status = "closed"

        until input.to_i > 0
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          input = gets.strip
        end

        self.controller.resort_details(input,status)
        input = "exit"
        self.restart?
      when "main"
        input = "exit"
        self.main
      when "back"
        input = "exit"
        self.regions_menu(current_location)
      when "exit"
        input = "exit"
      else
        "Please re-enter input"

        input = gets.strip
      end
    end
  end

  def restart?
    puts ""
    puts "Input 'back' to go back to the previous menu"
    puts "Input 'region' to returns to the regions list"
    puts""
    puts "You can also type 'exit' to log out or main to return to the main menu"

    input = gets.strip
    while input != "exit"
      case input
      when "region"
        input = "exit"
        self.regions_menu(current_location)
      when "back"
        input = "exit"
        self.resort_menu(current_region)
      when "exit"
        input = "exit"
      when "main"
        input = "exit"
        self.main
      else
        puts "Invalid entry, please enter:"
        puts "'back' to go back to the previous menu"
        puts "'region' to return to the regions list"
        puts "'main' to return to the main menu"
        puts "'exit' to log off"
        input = gets.strip
      end
    end
  end

end
