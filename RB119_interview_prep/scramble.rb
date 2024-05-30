=begin
P
input: 2 strings
output: boolean
  - returns true if any portion of first string can be used to construct 2nd string
  - only lowercase letters; no need to worry about punctuation or digits

E
str1: 'aybbfs' str2: 'baby' -> true
str1: 'adfsb' str2: 'baby' -> false

D
 array of chars

A
1. iterate through chars of 2nd str
  - for each char, delete current char from 1st str
  - if current char cannot be deleted from 1st str, return false
2. if iteration complete, return true

C
=end

# def scramble(str1, str2)
#   str2.each_char do |char2|
#     return false unless str1.sub!(char2, '')
#   end

#   true
# end

def scramble(str1, str2)
  str2.chars.uniq.each do |char2|
    return false unless str1.count(char2) >= str2.count(char2)
  end

  true
end

p scramble('javaass', 'jjss') == false
p scramble('rkqodlw', 'world') == true
p scramble('cedewaraaossoqqyt', 'codewars') == true
p scramble('katas', 'steak') == false
p scramble('scriptjava', 'javascript') == true
p scramble('scriptingjava', 'javascript') == true
