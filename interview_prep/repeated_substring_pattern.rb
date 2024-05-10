# Check if a given string can be constructed by taking a substring of it and appending multiple copies of the substring together

=begin
P
input: string
output: boolean
  - return true if given string can be constructed by taking substring and appending multiple copies of it together
  - false otherwise
  - must be at least 2 substring copies (full string is not a substring)

E
'abab' -> true
'ab|ab'
2 'ab's

'aba' -> false
'ab|a'
no multiple subs

'abaababaab' -> true
'abaab|abaab'
2 'abaab's

D
- need to construct string using multiple copies of substring
- string method String#* can be used to multiply substring to obtain multiple copies until total length is
 greater than or equal to the length of the input string
- potential substring patterns must have a length that is a multiple of the total string length
- only half of the string needs to be checked; substrings greater in length than the input str's length / 2 will never work
for 'abaababaab':
  - 'a'     - multiplied by 10 will equal length of input
  - 'ab'    - mult by 5 will equal length of input
  - 'aba'   - length not a mult of string length
  - 'abaa'  - length not a mult of string length
  - 'abaab' <- multiplied by 2 will equal length of input and will match input
- multipler can be obtained by dividing length of input str by length of substrings 

A
1. Iterate substrings starting at first char of input for lengths 1 up to half the length of input str
2. For each substr:
  2a. Obtain multiplier by dividing length of input string by length of current substring
  2b. Multiply current substring by multiplier
  2c. Return true if match found
3. If all possible substring patterns iterated through, return false
C
=end

def repeated_substring_pattern(str)
  max_substr_length = str.length / 2

  (1..max_substr_length).each do |substr_length|
    current_substr = str[0, substr_length]
    multiplier = str.length / current_substr.length

    return true if current_substr * multiplier == str
  end

  false
end

p repeated_substring_pattern("abab") == true
p repeated_substring_pattern("aba") == false
p repeated_substring_pattern("aabaaba") == false
p repeated_substring_pattern("abaababaab") == true
p repeated_substring_pattern("abcabcabcabc") == true
