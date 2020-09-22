=begin
  -------------------------------------THE MAIN CONCEPTS-------------------------------------
    LOCAL VARIABLE SCOPE - 
      - The main rule: A variable initialized in an outer scope is avaialable within an inner
        scope, but a variable initialized in an inner scope isn't available in an outer scope.
      - A variable initialized outside of a *block* can be reassigned within a block.
        --> One gotcha --> VARIABLE SHADOWING
      - A method definition can't access a variable initialized in an outer scope unless that
        variable is passed into the method as an argument.
      - A local variable initialized outside of a method definition can't be reassigned
        within the method definition unless the method is mutating.
  
  
    MUTATING & NON-MUTATING METHODS - 
      - CONCATENATION --> concatenation, (in ruby, '.concat' or '>>') is a mutating
        method that allows us to append a given argument to a string or collection object.

      - REASSIGNMENT  --> non-mutating - if we initialize a variable x and assign it to the
        integer object 3, then type the expression 'x = 4', we've assigned x to the integer
        object 4. x no longer points to the integer object 3. Reassignment changes the
        'binding' of a variable. 

      - INDEXED ASSIGNMENT --> mutating with respect to the collection on which it is called,
        however, the individual element that was reassigned now points to a different object.     
  

    WORKING WITH COLLECTIONS - 
      - EACH   - Iterates through each element of the collection on which it's called. When
        called with a block passed in, returns calling collection, accepts a block but
        disregards its return value.

      - MAP    - Iterates through each element of the collection on which it's called. When
        called with a block passed in, returns a new array of the block's return values.

      - SELECT - Iterates through each element of the collection on which it's called. When
        called with a block passed in, select returns a new collection object containing each
        element from the original collection for which the block returned a truthy value.                                
    
  
    VARIABLES AS POINTERS - 
      - Variables point to physical locations in memory.
      - When a destructive method is called on a mutable object, that object that the
        variable is pointing to is itself changed.
      - Immutable objects cannot be changed (in Ruby, numbers and Booleans are immutable).
  
  
    PUTS VS. RETURN - 
      - PUTS   --> When provided an argument, puts will print the argument to the console as a
        string followed by a newline character. If the given argument isn't a string, puts
        will call the to_s method on the object before printing it. When called without an
        argument, puts outputs one new line character. Puts always returns nil.

      - RETURN --> Every method call, block, and expression returns an object in Ruby, whether
        that return value is a meanigful value, the calling object, or nil.
          - EXPLICIT RETURN VALUE - What's returned by a line of code preceded by the return
            keyword.
          - IMPLICIT RETURN VALUE - What's returned automatically (without invocation of the 
            return keyword) by the last line of a block, method, or piece of code.
  
  
    FALSE VS. NIL & "TRUTHINESS" - FILL OUT
  
  
    METHOD DEFINITION & METHOD INVOCATION - FILL OUT

=end



#PROBLEMS FOR WRITTEN------------------------------------------------------------------------------

letter = 'A'

if letter
  puts "valid input"
else
  puts "Invalid!"
end



num = get_the_num

if num && get_the_num.valid?
  puts "that number is fine!"
else
  puts "your number isn't there or it isn't valid"
end



3.times do
  a = 'hello'
  puts a     
end

loop do
  puts a      
  break
end

puts a  



a = 1          

loop do       
  b = 2

  loop do      
    c = 3
    puts a     
    puts b     
    puts c     
    break
  end

  puts a       
  puts b       
  puts c       
  break
end

puts a         
puts b         
puts c 



loop do
  MY_CAT = "Sherlock"
  break
end

puts MY_CAT 



def greetings
  yield
  puts "Goodbye"
end

word = "Hello"

greetings do
  puts word
end


#INTERVIEW QUESTIONS-------------------------------------------------------------------------------

=begin
  Find the longest substring in alphabetical order.
  Example: the longest alphabetical substring in "asdfaaaabbbbcttavvfffffdf" is "aaaabbbbctt".
  There are tests with strings up to 10 000 characters long so your code will need to be efficient.
  The input will only consist of lowercase characters and will be at least one letter long.
  If there are multiple solutions, return the one that appears first.
=end


p longest('asd') == 'as'
p longest('nab') == 'ab'
p longest('abcdeapbcdef') == 'abcde'
p longest('asdfaaaabbbbcttavvfffffdf') == 'aaaabbbbctt'
p longest('asdfbyfgiklag'), 'fgikl'
p longest('z') == 'z'
p longest('zyba') == 'z'
p longest('lerbshnemkryfhigpzuwlzwrxtsofhqanjkgxkirjqtgxhhnfxplnfkqwppmhkhuakmgrbcryi') == 'fkqw'



# You are given an array (which will have a length of at least 3, but could be very large)
# containing integers. The array is either entirely comprised of odd integers or entirely
# comprised of even integers except for a single integer N. Write a method that takes the
# array as an argument and returns this "outlier" N.

# Examples
# [2, 4, 0, 100, 4, 11, 2602, 36]
# Should return: 11 (the only odd number)


# [160, 3, 1719, 19, 11, 13, -21]
# Should return: 160 (the only even number)
# =end



=begin
The maximum sum subarray problem consists in finding the maximum sum of
a contiguous subsequence in an array or list of integers:

maxSequence [-2, 1, -3, 4, -1, 2, 1, -5, 4]
-- should be 6: [4, -1, 2, 1]
Easy case is when the list is made up of only positive numbers and the
  maximum sum is the sum of the whole array. If the list is made up of
  only negative numbers, return 0 instead.

Empty list is considered to have zero greatest sum. Note that the empty
list or array is also a valid sublist/subarray.
=end

  max_sequence([]) == 0
  max_sequence([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6
  max_sequence([11]) == 11
  max_sequence([-32]) == 0
  max_sequence([-2, 1, -7, 4, -10, 2, 1, 5, 4]) == 12
  max_sequence([-11, -5, -15, 8, -6, 4, 4, -7, 4, 23, 14, -12, 18, -25, -18, 0, -24, -14, 20]) == 50


=begin
  Create a function that takes a positive integer and returns the next bigger number that can be formed by rearranging its digits. For example:

12 ==> 21
513 ==> 531
2017 ==> 2071
nextBigger(num: 12)   // returns 21
nextBigger(num: 513)  // returns 531
nextBigger(num: 2017) // returns 2071
If the digits can't be rearranged to form a bigger number, return -1 (or nil in Swift):

9 ==> -1
111 ==> -1
531 ==> -1
nextBigger(num: 9)   // returns nil
nextBigger(num: 111) // returns nil
nextBigger(num: 531) // returns nil
=end
next_bigger(12)==21
next_bigger(513)==531
next_bigger(2017)==2071
next_bigger(414)==441
next_bigger(144)==414





=begin
Background
There is a message that is circulating via public media that claims a reader can easily read a message where
the inner letters of each words is scrambled, as long as the first and last letters remain the same and the
word contains all the letters. Another example shows that it is quite difficult to read the text where all
the letters are reversed rather than scrambled. In this kata we will make a generator that generates text in
a similar pattern, but instead of scrambled or reversed, ours will be sorted alphabetically

problem
write a method that takes a string (sentence) as a parameter
returns a new string
  each word has the same starting and ending letter
  but the inner letters are all alphabatized
  
edge case rules
-empty string returns empty string
-non letter chars are left in place/ignored
  ' ', "'", ',', '.', '-'
  
algo
-make a helper function that that transforms A word according to above rules

  takes a string (word) as a parameter
  returns a new string
    with first and last letters in place
    ignore non-letter chars
    aplhabatize inner characters
  
  init result string
  get the non-alpha chars idx and char in a hash
  remove the first and last alpha chars and assign to variables first & last
  
  remove the non-alpha chars
  sort the remaining letters in alpha order
  append first, aphlabatized middle, last, then insert chars from the hash accordingly
  

-take the string and split it into an array
-return a new array (results) using map and the helper function
  -conditional - word needs to have at least three alpha chars, otherwise word
-join the results array and return it
=end

# def helper_method(word)
#   non_alpha_chars = [ ' ', "'", ',', '.', '-']
#   result = ''
#   hash = {}
#   word.chars.each_with_index do |char, idx|
#     if non_alpha_chars.include?(char)
#       hash[idx] = char
#     end
#   end
#   hash
#   non_alpha_chars.each do |char|
#     word.gsub!(char, '')
#   end
  
#   first = word.slice!(0)
#   last = word.slice!(-1)
#   alpha = word.chars.sort.join
#   result << first
#   result << alpha
#   result << last
#   hash.each_pair do | idx, char|
#     result.insert(idx, char)
#   end
#   result
# end

# #p helper_method('-test-yes,s')

# def scramble_words(sentence)
#   non_alpha_chars = [ ' ', "'", ',', '.', '-']
#   array = sentence.split
#   results = array.map do |word|
#     if word.size <= 3
#       word
#     else 
#       helper_method(word)
#     end
#   end
#   results.join(' ')
# end


def scramble_words(sentence)
  split_sentence = sentence.split(/\b/).map { |string| string.split(/(\A[a-z]{1})|([a-z]{1}\z)/) }
  split_sentence.map do |strings|
    strings.map do |string|
      if string.match?(/\A[a-z]*\z/)
        string.split('').sort.join
      else 
        string 
      end
    end.join
  end.join
end

  # map do |string|
  #   if string.match?(/\A[a-z]*\z/)
  #     string.split('').sort.join
  #   else string end
  # end.join

p scramble_words('professionals') == 'paefilnoorsss'
p scramble_words('i') == 'i'
p scramble_words('') == ''
p scramble_words('me') == 'me'
p scramble_words('you') == 'you'
p scramble_words('card-carrying') == 'caac-dinrrryg'
#                  a r,   a  d  r, a d r - a
p scramble_words("shan't") == "sahn't"
p scramble_words('-dcba') == '-dbca'
p scramble_words('dcba.') == 'dbca.'
p scramble_words("you've gotta dance like there's nobody watching, love like you'll never be hurt, sing like there's nobody listening, and live like it's heaven on earth.") == "you've gotta dacne like teehr's nbdooy wachintg, love like ylo'ul neevr be hrut, sing like teehr's nbdooy leiinnstg, and live like it's haeevn on earth."




