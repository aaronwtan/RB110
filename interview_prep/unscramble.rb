=begin
P
input: 2 strings
output: boolean: true if some portion of chars in 1st str can be rearranged to form 2nd str; false otherwise
  - inputs will be non-empty
  - inputs will be lowercase alphabetical letters
  - not all letters of the 1st str need to be used

E
'aaabbbbcccccxyz', 'aabbbccc' -> true
# a's: 3     # of a's in 2nd: 2
# b's: 4     # of b's in 2nd: 3
# c's: 5     # of c's in 2nd: 3

'abbbbcccccxyz', 'aabbbccc' -> false
# a's: 1     # of a's in 2nd: 2
# b's: 4     # of b's in 2nd: 3
# c's: 5     # of c's in 2nd: 3

D
- need to check how many of each char of 2nd str
- need to check if 1st str contains at least that many chars
- if not, then 1st str cannot be used to construct 2nd
- 2nd str chars should be iterated through

A
1. iterate through the unique chars of 2nd str
2. for each char of 2nd str
  2a. count how many of current char is in both strings
  2b. compare count of current char
    - if 1st str count is greater than or equal to 2nd str count, proceed to next char
    - otherwise, return false from method
3. if every char of 2nd str has been iterated through, return true

C
=end

def unscramble(str1, str2)
  str2_uniq_chars = str2.chars.uniq
  str2_uniq_chars.each do |char2|
    str1_char_count = str1.count(char2)
    str2_char_count = str2.count(char2)

    return false if str1_char_count < str2_char_count
  end

  true
end

p unscramble('ansucchlohlo', 'launchschool') == true
p unscramble('phyarunstole', 'pythonrules') == true
p unscramble('phyarunstola', 'pythonrules') == false
p unscramble('boldface', 'coal') == true
