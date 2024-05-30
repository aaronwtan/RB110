=begin
P
input: array of words
output: array of numbers for each word representing how many letters
  of each word occupy their corresponding position in the alphabet
  - checking for position is case-insensitive
  - if no letters occupy correponding alphabet position, return 0 for that word

E
                 'abc'
alpha positions: 1 2 3
          return: 3

                 'abz'
alpha positions: 1 2 26
          return: 2

D
range representing alphabet to check for position

A
1. init ALPHABET hash constant to represent alphabet positions (starting at index 0 -> 'a')
2. iterate through given array of words using #map
  - for each word, iterate through chars using #count
    - within #count block, use ALPHABET hash to count each char
      for which the index within the current word is equal to the value when referencing ALPHABET
3. return mapped array

C
=end

#=begin
ALPHABET = ('a'..'z').zip((0..25)).to_h

def symm(words)
  words.map do |word|
    word.chars.each_with_index.count do |char, index|
      index == ALPHABET[char.downcase]
    end
  end
end

p symm(["abode","ABc","xyzD"]) == [4, 3, 1]
p symm(["abide","ABc","xyz"]) == [4, 3, 0]
p symm(["IAMDEFANDJKL","thedefgh","xyzDEFghijabc"]) == [6, 5, 7]
p symm(["encode","abc","xyzD","ABmD"]) == [1, 3, 1, 3]
#=end
