class MyCar
  attr_accessor :color
  attr_reader :year, :model
  
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def self.what_am_i
    "I'm the MyCar class!"
  end

  def self.gas_mileage(miles, gallons)
    gas_mileage = miles / gallons
    puts "Your car's gas mileage is #{gas_mileage} miles per gallon."
  end
  
  def to_s
    "Hi there friend! That sure is a nice #{self.model} you got there!"
  end

  def info
    puts "Congrats on the new car! You've got a #{@color} #{@year} #{@model}!"
  end

  def spray_paint(color)
    self.color = color
    puts "That's one snazzy #{color} car you got there!"
  end

  def current_speed
    puts "Your current speed is #{@current_speed} mph!"
  end

  def speed_up(number)
    @current_speed += number
    puts "You've accelerated #{number} mph - your current speed is #{@current_speed} mph!"
  end

  def brake(number)
    @current_speed -= number
    puts "You hit the brake and slowed down #{number} mph! Your speed is now #{@current_speed} mph."
  end

  def shut_off
    @current_speed = 0
    puts "Let's park this bad boy!"
  end
end


MyCar.gas_mileage(450, 14.5)

junker = MyCar.new(1987, 'Ford Tempo', 'white')
puts junker

# puts junker.color
# junker.spray_paint('red')
# puts junker.color

# puts junker.model
# puts junker.year

# junker.info
# junker.current_speed
# junker.speed_up(35)
# junker.speed_up(41)
# junker.brake(459)
# junker.current_speed
# junker.shut_off

