class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post


=begin
 constant FORMAT is never initialized in the File class that the other three classes inherit from. 
 Additionally, the value of FORMAT is different for each class, and therefore this variable is likely
 better expressed as a class variable

 ^Nope
 The problem here isn't that FORMAT isn't initialized in the parent class, it's that we aren't
 properly accessing the apprpriate FORMAT when we invoke the to_s method on an instance of one of our
 subclasses. This is because when Ruby resolves a constant, it looks up its lexical scope, which is the
 File class and all of the File classes' ancestors, in this case. 

 The solution to this problem is providing the proper scope in which the FORMAT constant can be found,
 and that's the class of the instance calling the to_s method.

 Solutions: 
 1. initiallize constant in parent class
 2. implement format methods to hold info
=end