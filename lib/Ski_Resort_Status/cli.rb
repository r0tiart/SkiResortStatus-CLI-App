class SkiResortStatus::CLI
  attr_accessor :current_location, :location_number, :current_region, :region_number :controller


  def initialize
    @controller = SkiResortStatus::Controller.new
  end

  def call # welcome screen
    puts "***********************************"
    puts "*    Welcome to the Snow Status    *"
    puts "***********************************"
    puts ""

    location
  end

  def main #main menu - list locations and choose location
    puts ""
    controller.list_locations
    puts ""
    puts "Please Choose Location - by number"
    puts ""

    input = gets.chomp
    location_number = input

    while input != "exit"
      if input.to_i.between?(1,SkiResortStatus::Location.all.length)
        regions_menu(input) #calls to list the regions by selected location
      else
        puts "Please re-enter the location number"
        input = gets.chomp
        location_number = input #location in the @@all array for location class
      end
    end
    puts "Logging out"
  end

  def regions_menu(number) #lists regions - and ask to choose specific region
    current_location = controller.current_location(number)

    puts ""
    controller.list_regions(number)
    puts ""
    puts "Please Choose Region - by number"
    puts ""

    input = gets.chomp

    while input != "exit"
      if input.to_i.between?(1,current_location.regions.length)
        # region_number = input #choice made so i can find the instance of the region

        current_region = controller.current_region(current_location, input) #pulls the instance of the region

        resort_menu(region)
      elsif input == "main"
        main
      else
        puts "Please re-enter the location number"
        input = gets.chomp
        # region_number = input
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
    puts ""

    input = gets.chomp
    case input
    when "1"
      @controller.open_resorts

      puts ""
      puts "Please select resort you want to learn more about"
      puts ""

      input = gets.chomp
      status = "open"

      until input.to_i.between?(1,current_region.resorts.length)
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      controller.resort_details(input,status)

      restart?
    when "2"
      @controller.weekend_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.chomp
      status = "weekend"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      @controller.resort_details(input,status)

      restart?
    when "3"
      @controller.all_open

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.chomp
      status = "all_open"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      @controller.resort_details(input,status)

      restart?
    when "4"
      @controller.all_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.chomp
      status = "all"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      @controller.resort_details(input,status)

      restart?
    when "5"
      @controller.closed_resorts

      puts ""
      puts "Please select resort you want to learn more about"

      input = gets.chomp
      status = "closed"

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      @controller.resort_details(input,status)

      restart?
    when "main"
      main
    when "regions"
      regions_menu(location_number)
    when "back"
      resort_menu(current_region)
    when "exit"
      puts "Logging out"
    else
      "Please re-enter input"

      input = gets.chomp
    end
  end

  def restart?
    puts ""
    puts "Would you like to go back to the current region menu?"
    puts""
    puts "If not please type exit or main to return to the main menu"

    input = gets.chomp

    case input
    when "yes"
      region_menu(@region_number)
    when "exit"
      puts "Logging out"
    when "main"
      main
    else
      puts "Please type yes to return the specified region"
      puts "Type exit to log out or main to continue to the main menu"
      input = gets.chomp
    end
  end

end
