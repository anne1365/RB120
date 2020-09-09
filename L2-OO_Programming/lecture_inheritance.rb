class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
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