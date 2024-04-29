=begin
P
input: 2 strings
output: boolean
  - true if strings share a substring
  - shared substring must be 2 or more chars long
  - comparison of substring is case-insenstive

E
'aabbcc', 'abc' -> false
'aabbcc', 'abbc' -> true

D
array of substrings

A
1. generate substrings arrays from both strings using helper method
2. iterate through first substrings array
  - for each substring, check if second substrings array includes current substring
  - if it does, return true
3. after iteration, if no match, return false

C
=end

=begin
#substrings submethod
P
input: string
output: array of substrings of length 2 or more

E
'abcde' -> [ab, abc, abcd, abcde,
            bc, bcd, bcde,
            cd, cde,
            de]

D
array

A
1. init result array to empty array
2. iterate starting at first index to second to last index of given string
  - for each starting index:
    - iterate from length 2 to length (given string length - starting index)
      - for each length, append downcased substring of current length at current starting index to result array
3. return result
=end

def substrings(str)
  result = []
  max_start_index = str.length - 2

  (0..max_start_index).each do |start_index|
    max_substr_length = str.length - start_index

    (2..max_substr_length).each do |substr_length|
      result << str[start_index, substr_length].downcase
    end
  end

  result
end

def substring_test(str1, str2)
  substrings1 = substrings(str1)
  substrings2 = substrings(str2)

  !substrings1.intersection(substrings2).empty?
end

p substring_test('Something', 'Fun') == false
p substring_test('Something', 'Home') == true
p substring_test('Something', 'Fun') == false
p substring_test('Something', '') == false
p substring_test('', 'Something') == false
p substring_test('BANANA', 'banana') == true
p substring_test('test', 'lllt') == false
p substring_test('', '') == false
p substring_test('1234567', '541265') == true
p substring_test('supercalifragilisticexpialidocious', 'SoundOfItIsAtrociou') == true
