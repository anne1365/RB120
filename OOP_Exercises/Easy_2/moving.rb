class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    'strolls'
  end
end


class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    'saunters'
  end
end


class Cheetah
  attr_reader :name

  def initizlize(name)
    @name = name
  end

  private

  def gait
    'runs'
  end
end