#method that returns true if argument looks like a url, false otherwise
def url?(str)
  url = /\Ahttps?:\/\/\S*.com\z/
  str.match(url) ? true : false
end

url?('http://launchschool.com')   # -> true
url?('https://example.com')       # -> true
url?('https://example.com hello') # -> false
url?('   https://example.com')    # -> false





#method that returns all feilds in a haphazardly formatted string
def fields(str)
  str.split(/[\t, ]+/)
end

fields("Pete,201,Student")
# -> ['Pete', '201', 'Student']

fields("Pete \t 201    ,  TA")
# -> ['Pete', '201', 'TA']

fields("Pete \t 201")
# -> ['Pete', '201']

fields("Pete \n 201")
# -> ['Pete', '\n', '201']





#method that changes first arithmetic operator in a string to '?'
def mystery_math(str)
  str.sub(/[*+\-\/]/, '?')
end

mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# -> '(4 ? 3 + 2) / 7 - 1 = 1'





#method that changes every arithmetic operator in a string to '?' w/out
#modifying original string
def mysterious_math(str)
  str.gsub(/[*+\-\/]/, '?')
end

mysterious_math('4 + 3 - 5 = 2')           # -> '4 ? 3 ? 5 = 2'
mysterious_math('(4 * 3 + 2) / 7 - 1 = 1') # -> '(4 ? 3 ? 2) ? 7 ? 1 = 1'




#Write a method that changes the first occurrence of the word apple, blueberry,
#or cherry in a string to danish.
def danish(str)
  str.sub(/\b(apple|blueberry|cherry)/, 'danish')
end

danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

danish('The cherry of my eye')
# -> 'The danish of my eye'

danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

danish('I love pineapple')
# -> 'I love pineapple'





#Challenge: write a method that changes dates in the format 2016-06-17
#to the format 17.06.2016. You must use a regular expression and should
#use methods described in this section.
def format_date1(date)
  date.sub(/\A(\d{4})-(\d\d)-(\d\d)\z/, '\3.\2.\1')
end

format_date1('2016-06-17') # -> '17.06.2016'
format_date1('2016/06/17') # -> '2016/06/17' (no change)





# Challenge: write a method that changes dates in the format 2016-06-17
#or 2016/06/17 to the format 17.06.2016. You must use a regular expression
#and should use methods described in this section.
def format_date(str)
  str.sub(/\A(\d{4})([\-\/])(\d\d)\2(\d\d)/, '\4.\3.\1')
end

format_date('2016-06-17') # -> '17.06.2016'
format_date('2017/05/03') # -> '03.05.2017'
format_date('2015/01-31') # -> '2015/01-31' (no change)