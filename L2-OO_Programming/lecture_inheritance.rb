class Pet
  def run
    puts 'running!'
  end

  def jump
    puts 'jumping!'
  end
end


class Cat < Pet
  def speak
    puts 'Meow!'
  end
end


class Dog < Pet
  def speak
    puts 'bark!'
  end

  def swim
    puts 'swimming'
  end

  def fetch
    puts 'fetching!'
  end
end


class Bulldog < Dog
  def swim
    puts "can't swim!"
  end
end



sherlock = Cat.new
sherlock.run
sherlock.speak
sherlock.jump

tim = Dog.new
tim.fetch
tim.swim
tim.speak

bubbles = Pet.new
bubbles.run

buddo = Bulldog.new
buddo.run
buddo.swim