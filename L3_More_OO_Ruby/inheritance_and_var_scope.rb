# class Animal
#   def initialize(name)
#     @name = name
#   end
# end

# class Dog < Animal

#   def dog_name
#     "bark! bark! #{@name} bark!"
#   end
# end

# teddy = Dog.new("Teddy")
# puts teddy.dog_name

module Maintenance
  def changing_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
  # def self.wheels
  #   WHEELS
  # end

  # def wheels
  #   WHEELS
  # end
end

# p Car.wheels

a_car = Car.new
p Maintenance.ancestors