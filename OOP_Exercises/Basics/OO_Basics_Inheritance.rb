# -------------------------------------------------------------
# WORKING WITH CLASSES

# module Towable
#   def tow
#     "I can tow a trailer!"
#   end
# end


# class Vehicle
#   attr_reader :year

#   def initialize (year)
#     @year = year
#   end

#   # def start_engine
#   #   'Ready to go!'
#   # end
# end


# class Car < Vehicle
# end


# class Truck < Vehicle
#   include Towable

#   # attr_reader :bed_type

#   # def initialize(year, bed_type)
#   #   # super(year)
#   #   # @bed_type = bed_type
#   # end
  
#   # def start_engine(speed)
#   #   super() + " Drive #{speed}, please!"
#   # end
# end




# truck1 = Truck.new(1994)
# puts truck1.year
# # puts truck1.bed_type
# # puts truck1.start_engine('fast')
# puts truck1.tow

# car1 = Car.new(2006)
# puts car1.year

# ---------------------------------------------------------------
# MODULES FOR NAMESPACING
module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

p my_car = Transportation::Car.new
p my_truck = Transportation::Truck.new
p my_vehicle = Transportation::Vehicle.new