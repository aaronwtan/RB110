=begin
P
input: string
output: integer
  - return is the length of the longest substring in given string that is a palindrome
  - if given string is empty, return 0

E
'I like racecars' => longest palindrome: racecar => length: 7

D
array of substrings

A
1. return 0 if input is empty string
2. generate substrings array using helper method
3. iterate through substrings array
  - for each substring: check if substring is palindrome and select
  - assign selection to palindromes variable
4. iterate through palindromes array to return max length

C
=end

=begin
P
input: string
output: array of substrings of given string

E
abba -> a ab abb abba
        b bb bba
        b ba
        a

D
array of substrings

A
1. init result variable to empty array
2. iterate from starting index 0 to last index of given string
  - for each starting index, iterate from length 1 to length (length of given string - starting index)
    - for each length, append substring for current start index and current length to result array
3. return result

C
=end

def substrings(str)
  result = []
  max_start_index = str.length - 1

  (0..max_start_index).each do |start_index|
    max_substr_length = str.length - start_index
    (1..max_substr_length).each do |substr_length|
      result << str[start_index, substr_length]
    end
  end

  result
end

def palindrome?(str)
  str == str.reverse
end

def longest_palindrome(str)
  return 0 if str.empty?

  substrings_arr = substrings(str)

  palindromes = substrings_arr.select { |substring| palindrome?(substring) }

  palindromes.max_by(&:length).length
end

p longest_palindrome('') == 0
p longest_palindrome('a') == 1
p longest_palindrome('aa') == 2
p longest_palindrome('baa') == 2
p longest_palindrome('aab') == 2
p longest_palindrome('baabcd') == 4
p longest_palindrome('baablkj12345432133d') == 9
