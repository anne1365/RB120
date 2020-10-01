# module Vocalize
#   def vocalize(sound)
#     puts sound
#   end
# end

# class Cat
#   include Vocalize
# end

# sherlock = Cat.new
# p sherlock.inspect
# sherlock.vocalize('MEOW!')


class GoodDog
  def initialize(name)
    @name = name
  end
end

sparky = GoodDog.new("Leonard")
