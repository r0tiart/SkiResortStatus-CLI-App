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
    puts "  1) List all open resort as of (update date)"
    puts "  2) List all resorts only open on weekends"
    puts "  3) List all resorts that are open or open on weekends only"
    puts "  4) List all resorts including closed resorts"
    puts "  5) List all closed resorts"

    input = gets.chomp
    case input
    when "1"
      open_resorts
    when "2"
      weekend_resorts
    when "3"
      all_open
    when "4"
      all_resorts
    when "5"
      closed_resorts
    when "main"
      regions
    when "exit"
      puts "Logging out"
    else
      "Please re-enter input"
      input = gets.chomp
    end
  end

  def open_resorts
    puts "all open resorts"
    restart?
  end

  def weekend_resorts
    puts "weekend only resorts"
    restart?
  end

  def all_open
    puts "here are all the open resorts inclusive of weekend only resorts"
    restart?
  end

  def all_resorts
    puts "all resorts"
    restart?
  end

  def closed_resorts
    puts "closed resorts"
    restart?
  end

  def restart?
    puts ""
    puts "Would you like to go back to your specify region menu?"
    puts""
    puts "If not please type exit or main to continue"

    input = gets.chomp

    case input
    when "yes"
      region_menu(@region_number)
    when "exit"
      puts "Logging out"
    when "main"
      regions
    else
      puts "Please type exit or main to continue"
      input = gets.chomp
    end
  end

end
