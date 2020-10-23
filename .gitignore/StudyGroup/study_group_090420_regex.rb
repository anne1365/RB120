#META-CHARACTERS
=begin

'$ ^ * + ? . ( ) [ ] { } | \ /'

match
match

match

sub

.sub( 'a', 'b')


=end

# Challenge: write a method that changes dates in the format 2016-06-17 or 2016/06/17 to the format 17.06.2016. You must use a regular expression and should use methods described in this section.
def format_date(date)
  # date_regex = /(?<year>\d\d\d\d)(?<seperator>[\-\/])(?<month>\d\d)\k<seperator>(?<day>\d\d)/
  # date.sub(date_regex, '\k<day>.\k<month>.\k<year>')
cookies = 
  /
    \A
    (\d{4})
    ([\-\/])
    (\d{2})
    \2
    (\d\d)
    \z
  /x #< - flag
  
  date.sub(cookies,'\4.\3.\1')
end

# /
#   ^                  # Start of line
#   (\d+,){2}          # 2 numbers at start
#   (                  # followed by...
#     (\d+,){3,}       #    at least 3 more numbers
#   )?                 #    that are optional
#   \d+                # followed by one last number
#   $                  # end of line
# /x

# https://launchschool.com/books/regex/read/quantifiers#exercises


# /regex goe here/m <- flag goes 


# /
#   ^                  # Start of line
#   (\d+,){2}          # 2 numbers at start
#   (                  # followed by...
#     (\d+,){3,}       #    at least 3 more numbers
#   )?                 #    that are optional
#   \d+                # followed by one last number
#   $                  # end of line
# /x

=begin
/ / regex

\A(\d{4})([\-\/])(\d})\2(\d\d)\z/
\A -- where we want to start (start of string) : ANCHOR

(\d{4}) -- capture group pattern that matches any digit\d using range quantifier {4} 


([\-\/])  ( ) capture group  [] character class  \escaping \- \/ escape charaters
we are escaping meta-characters   choose either '-' or '/'


(\d{2})-- or \d\d\

\2 -- backreference that references the pattern that was matched by the second capture group

(\d\d) - 2 digits

\z - end of string anchor

'\4.\3.\1' 

\9 

\k<month>. is there a limit? Cant mix \9
=end



p format_date('2016-06-17') # -> '17.06.2016'  
p format_date('2017/05/03') # -> '03.05.2017'
p format_date('2015/01-31') # -> '2015/01-31' (no change)


# def format_date(original_date)
#   original_date.sub(/\A(\d\d\d\d)-(\d\d)-(\d\d)\z/, '\3.\2.\1')
#                .sub(/\A(\d\d\d\d)\/(\d\d)\/(\d\d)\z/, '\3.\2.\1')
# end
# # Alternate solution

# def format_date(original_date)
#   date_regex = /\A(\d\d\d\d)([\-\/])(\d\d)\2(\d\d)\z/
#   original_date.sub(date_regex, '\4.\3.\1')
# end

=begin
/(\d{4})([-//])(\d{2})([-//])(\d{2})/ 
  ******   -    *****   \2   ******
                     

  1        2        3     4    5
  
  
  
["']  "  "


Input:
- year, month, day 

Output:
- Reverse into the day, month, year 
- Replace only if all is - or / into .


if / and - included, do not change 

4 numbers, followed by 2, followed by 2




=end
# p "\"my favorite quote\" \"la la la' 'another quote'".(/(['"]).+?\1/)
