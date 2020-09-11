module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state}, #{zipcode}"
  end
end


class Customer
  include Mailable

  attr_reader :name, :address, :city, :state, :zipcode

  def initialize(name, address, city, state, zipcode)
    @name = name
    @address = address
    @city = city
    @state = state
    @zipcode = zipcode
  end
end


class Employee < Customer
  include Mailable 
end



betty = Customer.new("Betty Johnson", "493 Almond Way", "Legumeberg",  "NT", 12345)
bob = Employee.new("Bob Smith", "1239 Sumac Drive", "Treeville", "TR", 98765)

betty.print_address
bob.print_address