class SkiResortStatus::CLI

  def initialize
    @controller = SkiResortStatus::Controller.new
  end

  def call
    puts "***********************************"
    puts "*    Welcome to the Snow Status    *"
    puts "***********************************"
    puts ""

    regions
  end

  def regions
    puts "Please Choose Region - by number"
    puts ""
    puts "1. Regions"
    puts "2. All"

    input = gets.chomp
    @region_number = input

    case input
    when "1"
      region_menu(input)
    when "2"
      region_menu(input)
    when "exit"
      puts "Logging out"
    else
      puts "Please re-enter the region number"
      input = gets.chomp
      @region_number = input
    end
  end

  def region_menu(region_number)
    region = region_number.to_i - 1

    puts "--------#{region}--------"
    puts ""
    puts "What would you like to see for the #{region} region"
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

      until input.to_i > 0
        puts "Invalid entry, please enter the resort number you wish to learn more about"

        input = gets.chomp
      end

      @controller.resort_details(input,status)
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
    when "main"
      regions
    when "exit"
      puts "Logging out"
    else
      "Please re-enter input"

      input = gets.chomp
    end
  end

  # def open_resorts
  #   puts "all open resorts"
  #   restart?
  # end
  #
  # def weekend_resorts
  #   puts "weekend only resorts"
  #   restart?
  # end
  #
  # def all_open
  #   puts "here are all the open resorts inclusive of weekend only resorts"
  #   restart?
  # end
  #
  # def all_resorts
  #   SkiResortStatus::SkiResort.all.each.with_index(1) do |attribute, index|
  #     puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
  #   end
  #   puts "Please select resort you want to learn more about"
  #   input = gets.chomp
  #   resort_details(input)
  # end
  #
  # def closed_resorts
  #   puts "closed resorts"
  #   restart?
  # end
  #
  # def resort_details(input)
  #
  # end

  def restart?
    puts ""
    puts "Would you like to go back to your specify region menu?"
    puts""
    puts "If not please type exit or main to return to the main menu"

    input = gets.chomp

    case input
    when "yes"
      region_menu(@region_number)
    when "exit"
      puts "Logging out"
    when "main"
      regions
    else
      puts "Please type yes to return the specified region"
      puts "Type exit to log out or main to continue to the main menu"
      input = gets.chomp
    end
  end

end
