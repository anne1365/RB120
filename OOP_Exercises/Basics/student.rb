class Student

  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected 
  
  attr_reader :grade
end

# bob = Student.new("Bob", 83)
# jim = Student.new("Jim", 95)
# puts "Well done!" if jim.better_grade_than?(bob)



class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  private

  def hi
    "Hi"
  end
end

bob = Person.new("Bob")
bob.hi