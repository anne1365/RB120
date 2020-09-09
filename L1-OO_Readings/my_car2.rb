module Towable
  def can_tow?(lbs)
    lbs < 2000 ? true : false
  end
end


class Vehicle 
  @@vehicle_count = 0
  
  attr_accessor :color
  attr_reader :year, :model
  
  def initialize(year, model, color)
    @@vehicle_count += 1

    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def info
    puts "Congrats on the new vehicle! You've got a #{@color} #{@year} #{@model}!\n\n"
  end

  def self.vehicle_count
    puts "Number of objects initialized: #{@@vehicle_count}\n\n"
  end

  def self.gas_mileage(miles, gallons)
    gas_mileage = miles / gallons
    puts "Your car's gas mileage is #{gas_mileage} miles per gallon."
  end

  def spray_paint(color)
    self.color = color
    puts "That's one snazzy #{color} car you got there!\n\n"
  end

  def current_speed
    puts "Your current speed is #{@current_speed} mph!\n\n"
  end

  def speed_up(number)
    @current_speed += number
    puts "You've accelerated #{number} mph - your current speed is #{@current_speed} mph!\n\n"
  end

  def brake(number)
    @current_speed -= number
    puts "You hit the brake and slowed down #{number} mph! Your speed is now #{@current_speed} mph.\n\n"
  end

  def shut_off
    @current_speed = 0
    puts "Let's park this bad boy!\n\n"
  end

  def age
    puts "Your #{self.model} is #{vehicle_age} years old!"
  end

  private

  def vehicle_age
    Time.now.year - (self.year.to_i)
  end
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 2
end


class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
end




car = MyCar.new('1989', 'Ford Tempo', 'white')
MyCar.vehicle_count
car.info

truck = MyTruck.new('2001', 'Chevy', 'Brown')
MyTruck.vehicle_count
truck.info
truck.current_speed
truck.speed_up(32)
truck.current_speed
truck.brake(30)
truck.shut_off
truck.age

# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors