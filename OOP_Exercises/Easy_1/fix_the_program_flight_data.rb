class Flight
  # attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# Line 2 shouldn't be included, because easy access shouldn't
# be provided here