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
    self.main
  end

  def main #main menu - list locations and choose location
    puts ""
    self.controller.list_locations
    puts ""

    main_input = nil
    # location_number = input
    puts "Please Choose Location - by number"
    puts ""

    while main_input != "exit"

      main_input = gets.strip

      if main_input.to_i.between?(1,SkiResortStatus::Location.all.length)
        self.current_location = controller.current_location(main_input)

        self.regions_menu(current_location) #calls to list the regions by selected location

        main_input = "exit"
      elsif main_input == "exit"
        main_input = "exit"
      else
        puts "Please re-enter the location number"
        main_input = gets.strip
      end

    end
    puts ""
    puts "logging out"

    exit

  end

  def regions_menu(region) #lists regions - and ask to choose specific region

    puts ""
    self.controller.list_regions(region)
    puts ""

    region_input = nil
    puts "Please Choose Region - by number"
    puts ""

    while region_input != "exit"

      region_input = gets.strip

      if region_input.to_i.between?(1,self.current_location.regions.length)
        self.current_region = controller.current_region(self.current_location, region_input) #pulls the instance of the region

        self.resort_menu(current_region)

        region_input = "exit"
      elsif region_input == "main"
        region_input = "exit"
        self.main
      elsif region_input == "exit"
        region_input = "exit"
      else
        puts "Please re-enter the location number"
        region_input = gets.strip
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
    puts "You can enter 'exit' - to log out, 'main' - to go back to the main menu or 'regions' to return to the region selector"
    puts ""

    resort_input = gets.strip
    while resort_input != "exit"
      case resort_input
      when "1"
        @controller.open_resorts(region)

        new_input = gets.strip
        status = "open"

        if controller.open.length > 0
          until new_input.to_i.between?(1,controller.open.length)
            resort_input = "exit"

            puts "Invalid entry, please enter the resort number you wish to learn more about"

            new_input = gets.strip
          end

          self.controller.resort_details(new_input,status)

          self.restart?
        else
          until new_input == "exit" || new_input == "back" || new_input == "main" || new_input == "regions"
            if new_input == "exit"
              new_input = "exit"
            elsif new_input == "back"
              new_input = "back"
            elsif new_input == "main"
              new_input = "main"
            elsif new_input == "regions"
              new_input = "regions"
            else
              puts "Invalid entry, there are no open resorts - you can type:"
              puts "'exit' to log off, 'main' to go back to main menu, 'back' to return to previous menu or 'regions' to go back to the regions menu"

              new_input = gets.strip
            end
          end
          resort_input = new_input
        end
      when "2"
        self.controller.weekend_resorts(region)

        new_input = gets.strip
        status = "weekend"

        if controller.weekend.length > 0
          until new_input.to_i.between?(1,controller.weekend.length)
            resort_input = "exit"

            puts "Invalid entry, please enter the resort number you wish to learn more about"

            new_input = gets.strip
          end

          self.controller.resort_details(new_input,status)

          self.restart?
        else
          until new_input == "exit" || new_input == "back" || new_input == "main" || new_input == "regions"
            if new_input == "exit"
              new_input = "exit"
            elsif new_input == "back"
              new_input = "back"
            elsif new_input == "main"
              new_input = "main"
            elsif new_input == "regions"
              new_input = "regions"
            else
              puts "Invalid entry, there are no open resorts - you can type:"
              puts "'exit' to log off, 'main' to go back to main menu, 'back' to return to previous menu or 'regions' to go back to the regions menu"

              new_input = gets.strip
            end
          end
          resort_input = new_input
        end
      when "3"
        self.controller.all_open(region)

        new_input = gets.strip
        status = "all_open"

        if controller.every_open.length > 0
          until new_input.to_i.between?(1,controller.every_open.length)
            resort_input = "exit"

            puts "Invalid entry, please enter the resort number you wish to learn more about"

            new_input = gets.strip
          end

          self.controller.resort_details(new_input,status)

          resort_input = "exit"
          self.restart?
        else
          until new_input == "exit" || new_input == "back" || new_input == "main" || new_input == "regions"
            if new_input == "exit"
              new_input = "exit"
            elsif new_input == "back"
              new_input = "back"
            elsif new_input == "main"
              new_input = "main"
            elsif new_input == "regions"
              new_input = "regions"
            else
              puts "Invalid entry, there are no open resorts - you can type:"
              puts "'exit' to log off, 'main' to go back to main menu, 'back' to return to previous menu or 'regions' to go back to the regions menu"

              new_input = gets.strip
            end
          end
          resort_input = new_input
        end
      when "4"
        self.controller.all_resorts(region)

        new_input = gets.strip
        status = "all"

        until new_input.to_i.between?(1,controller.resorts.length)
          puts "Invalid entry, please enter the resort number you wish to learn more about"

          new_input = gets.strip
        end

        self.controller.resort_details(new_input,status)
        resort_input = "exit"
        self.restart?
      when "5"
        self.controller.closed_resorts(region)

        new_input = gets.strip
        status = "closed"

        if controller.closed.length > 0
          resort_input = "exit"

          until new_input.to_i.between?(1,controller.closed.length)
            puts "Invalid entry, please enter the resort number you wish to learn more about"

            new_input = gets.strip
          end

          self.controller.resort_details(new_input,status)

          resort_input = "exit"
          self.restart?
        else
          until new_input == "exit" || new_input == "back" || new_input == "main" || new_input == "regions"
            if new_input == "exit"
              new_input = "exit"
            elsif new_input == "back"
              new_input = "back"
            elsif new_input == "main"
              new_input = "main"
            elsif new_input == "regions"
              new_input = "regions"
            else
              puts "Invalid entry, there are no open resorts - you can type:"
              puts "'exit' to log off, 'main' to go back to main menu, 'back' to return to previous menu or 'regions' to go to the regions menu"

              new_input = gets.strip
            end
          end
          resort_input = new_input
        end
      when "main"
        resort_input = "exit"
        self.main
      when "back"
        resort_input = "exit"
        self.resort_menu(current_region)
      when "regions"
        resort_input = "exit"
        self.regions_menu(current_location)
      when "exit"
        resort_input = "exit"
      else
        "Please re-enter input"

        resort_input = gets.strip
      end
    end
  end

  def restart?
    puts ""
    puts "Input 'back' to go back to the previous menu"
    puts "Input 'region' to returns to the regions list"
    puts""
    puts "You can also type 'exit' to log out or main to return to the main menu"
    restart_input = nil

    while restart_input != "exit"
      restart_input = gets.strip

      case restart_input
      when "region"
        restart_input = "exit"
        self.regions_menu(current_location)
      when "back"
        restart_input = "exit"
        self.resort_menu(current_region)
      when "exit"
        restart_input = "exit"
      when "main"
        restart_input = "exit"
        self.main
      else
        puts "Invalid entry, please enter:"
        puts "'back' to go back to the previous menu"
        puts "'region' to return to the regions list"
        puts "'main' to return to the main menu"
        puts "'exit' to log off"
        restart_input = gets.strip
      end
    end
  end

end
