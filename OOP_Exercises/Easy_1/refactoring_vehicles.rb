class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end


class Car < Vehicle
  def wheels
    4
  end
end


class Motorcycle < Vehicle
  def wheels
    2
  end
end


class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end 




car = Car.new('Hyundai', 'Sonata')
truck = Truck.new('Chevy', 'truck', 5000)
motorcycle = Motorcycle.new('Honda', 'Motorcycle')
vehicle = Vehicle.new('Generic', 'Vehicle')

puts car
puts truck
puts motorcycle
puts vehicle

puts car.wheels
puts truck.wheels
puts motorcycle.wheels
puts vehicle.wheels