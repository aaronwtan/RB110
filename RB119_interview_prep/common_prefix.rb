=begin
PROBLEM
input: array of strings
output: string reprensenting longest common prefix among given array
  - given strings are all lowercase
  - if no common prefix found, return empty string

EXAMPLES
['aa', 'aaa', 'aaaaa', 'aabbcc'] -> 'aa'
1. 'a'
2. 'a'
result: 'aa'

['aabbcc', 'aa', 'aaa', 'aaaaa']
1. 'a'
2. 'a'
3. 'b' x

DATA STRUCTURE
string used to store common prefix

ALGORITHM
1. init result string to empty string
2. iterate through chars of first string of given array
  ex: ['flower', 'flow', 'flight']
  f l o w e r
    - for each char, check if character is the same in ALL strings for the current index
    - if it is, append to result string
    - otherwise, break out of loop and return result
3. if all chars have been iterated through, return result

CODE
=end

def common_prefix(words)
  result = ''

  words.first.chars.each_with_index do |char, index|
    return result unless words.all? { |word| word[index] == char }

    result << char
  end

  result
end

p common_prefix(['flower', 'flow', 'flight']) == 'fl'
p common_prefix(['dog', 'racecar', 'car']) == ''
p common_prefix(['interspecies', 'interstellar', 'interstate']) == 'inters'
p common_prefix(['throne', 'dungeon']) == ''
p common_prefix(['throne', 'throne']) == 'throne'
