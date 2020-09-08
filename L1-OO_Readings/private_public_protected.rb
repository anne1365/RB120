class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end

  private

  def human_years
    age * DOG_YEARS
  end
end


class Animal
  def a_public_method
    "Will this work? " + self.a_protected_method 
    # calling a protected method this way works - won't work if method is private
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end



sparky = GoodDog.new("Sparky", 4)
p sparky.public_disclosure

fido = Animal.new
puts fido.a_public_method
puts fido.a_protected_method #doesn't work