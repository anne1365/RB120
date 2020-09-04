text = "The regex /[^a-z]/i matches any character that is not a letter. Similarly, /[^0-9]/ matches any non-digit while /[^A-Z]/ matches any character that is not an uppercase letter. Beware: /[^+-<]/ is at best obscure, and may even be wrong."

p text.scan(/[\/][\[][\^]\w\-\w[\]][\/]/)

=begin
     1     2     3    4   5   6     7    8
 /  [\/]  [\[]  [\^]  \w  \-  \w  [\]]  [\/]  /

 1. matching forward slash (included escape though regex book said this wasn't needed in
    character class (what's going on here??))
 2. matching left bracket (escaped)
 3. matching carrot (spelled like the veggie?)(escaped)
 4. matching word chars
 5. matching dash (escaped)
 6. same as 4
 7. same as 2
 8. same as 1

 /\[\^[0-9A-Za-z]-[0-9A-Za-z]\]/ <-- ANOTHER OPTION
 /[\[][\^][0-9A-Za-z]-[0-9A-Za-z][\]]/  <-- YET ANOTHER OPTION
=end