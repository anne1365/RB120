class Pet
  def speak
    'Animal noise!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end


class Cat < Animal
  def speak
    'Meow!'
  end
end


class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming'
  end

  def fetch
    'fetching!'
  end
end


class Bulldog < Dog
  def swim
    "can't swim!"
  end
end



teddy = Bulldog.new
puts teddy.speak
puts teddy.swim