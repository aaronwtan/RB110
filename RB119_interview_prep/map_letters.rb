=begin
Given a word, create a hash which stores the indexes of each letter in an array.
Make sure the letters are the keys.
Make sure the letters are symbols.
Make sure the indexes are stored in an array and those arrays are values.
=end

=begin
P
input: single word string
output: hash which stores indices of each letter in an array
  - keys of hash are symbol version of letter
  - values are arrays that hold every index that the corresponding letter key occurs
  - assuming downcased input from test cases

E
"abbcccdddd"
  a: 0
  b: 1, 2
  c: 3, 4, 5
  d: 6, 7, 8, 9
return: { :a => [0],
          :b => [1, 2],
          :c => [3, 4, 5],
          :d => [6, 7, 8, 9] }

D
- need to work with hash with letter from input as key and array as value
- need to iterate through chars and indices of string
- need to append index to array of corresponding letter for each iteration
- need to initialize a hash with keys as sym versions of all unique letters of input and values initially as empty arrays
- need to determine if current letter for each iteration matches a key of returned hash

A
1. init result hash to be returned with default values as empty arrays
2. iterate through chars of word input with the index
  2a. convert current char to symbol
  2b. reference hash at current symbol and append current index
3. return result hash

C
=end

def map_letters(word)
  result = Hash.new { |hash, key| hash[key] = [] }

  word.chars.each_with_index do |char, index|
    result[char.to_sym] << index
  end

  result
end

p map_letters("froggy") == { :f => [0], :r=>[1], :o=>[2], :g=>[3, 4], :y=>[5] }
p map_letters("dodo") == { :d=>[0, 2], :o=>[1, 3] }
p map_letters("grapes") == { :g=>[0], :r=>[1], :a=>[2], :p=>[3], :e=>[4], :s=>[5] }
