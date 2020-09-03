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



junker = MyCar.new(1987, 'Ford Tempo', 'white')
puts junker.color
junker.spray_paint('red')
puts junker.color

puts junker.model
puts junker.year

# junker.info
# junker.current_speed
# junker.speed_up(35)
# junker.speed_up(41)
# junker.brake(459)
# junker.current_speed
# junker.shut_off

