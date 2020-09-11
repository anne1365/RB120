module Swim
  def swim
    'swimming!'
  end
end

module Run
end

module Climb
end

class Dog
  include Swim
end

class Fish
  include Swim
  include Climb
  include Run
end

p Fish.ancestors