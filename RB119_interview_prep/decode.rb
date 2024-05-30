=begin
We're receiving a set of messages in code. The messages are sets of text strings, like:
"alakwnwenvocxzZjsf"
Write a method to decode these strings into numbers. The decoded number should be the number of lowercase characters
# between the first two uppercase characters. If there aren't two uppercase characters, the number should be 0.

Test cases:
p decode(['ZoL', 'heLlo', 'XX']) == [1, 0, 0]
p decode(['foUrsCoreAnd', 'seven', '']) == [2, 0, 0]
p decode(['lucYintheskyWith', 'dIaMonDs']) == [8, 1]
p decode([]) == []
=end

=begin
P
input: array of strings
output: array of numbers with each number representing the lowercase letters
    between the first 2 uppercase letters of each string
  - if there are less than 2 uppercase letters, number should be 0
  - if there are 2 uppercase letters but no chars in between, number should be 0
  - if string is empty, number should be 0
  - if given empty array, return should also be an empty array

E
      'A  b  c  D'
      1st   /  2nd
index: 0    /   3
return: (3 - 0) - 1 == 2

      'A  b  c  d'
      1st   /     end of string
index: 0    /
return: 0 (uppercase letters < 2)

      'A  b  c  D  e  F'
      1st   /  2nd
index: 0    /   3
return: (3 - 0) - 1 == 2

      'A  b  c  D  e  F'
      1st   /  2nd
index: 0    /   3
return: (3 - 0) - 1 == 2

      'l  u  c  Y  i  n  t  h  e  s  k  y  W  i  t  h'

               1st           /            2nd
index:          3            /             12
return: (12 - 3) - 1 == 8


D
loop through chars checking for uppercase letters

A
1. return empty array if given array is empty
2. iterate through given array and return integer for each word element
  - for each word:
    - init first_upper_idx to nil
    - iterate through chars of current word
      - for each char, check if current char is uppercase by comparing if equal to uppercased version
        - if uppercase char,
          - if first_upper_idx is nil, assign current idx to first_upper_idx
          - otherwise, init second_upper_idx to current idx
          - assign num of lowercase letters between to (second_upper_idx - first_upper_idx - 1) and return
    - if iteration of current word completed without finding 2 uppercase letters, return 0 for current word
3. return array returned from completed iteration

C
=end
def between_uppers(word)
  first_upper_idx = nil

  word.chars.each_with_index do |char, idx|
    next unless char == char.upcase

    if first_upper_idx.nil?
      first_upper_idx = idx
    else
      second_upper_idx = idx
      num_of_lowers_between = second_upper_idx - first_upper_idx - 1
      return num_of_lowers_between
    end
  end

  0
end

def decode(words)
  return [] if words.empty?

  words.map { |word| between_uppers(word) }
end

p decode(['ZoL', 'heLlo', 'XX']) == [1, 0, 0]
p decode(['foUrsCoreAnd', 'seven', '']) == [2, 0, 0]
p decode(['lucYintheskyWith', 'dIaMonDs']) == [8, 1]
p decode([]) == []
