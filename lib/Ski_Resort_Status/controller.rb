class SkiResortStatus::Controller

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
    status = "open"
    restart?
  end

  def all_resorts
    SkiResortStatus::SkiResort.all.each.with_index(1) do |attribute, index|
      puts "#{index}. #{attribute.name} - #{attribute.region}, #{attribute.status}"
    end
  end

  def closed_resorts
    puts "closed resorts"
    restart?
  end

  def resort_details(input,status)
    case status
    when "all"
       resort = SkiResortStatus::SkiResort.all[input.to_i - 1]
       puts "#{resort.name}"
    when "open"
      puts "open"
    when "weekend"
      puts "weekend"
    when "all_open"
      puts "all open"
    when "closed"
      puts "closed"
    end
  end
end
