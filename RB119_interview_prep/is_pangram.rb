=begin
P
input: str
output: boolean, based on whether input str is a pangram
  - pangrams contain every letter of the alphabet at least once
  - result is case insensitive

E
'abcdefg....' -> true

D
- need to check every alphabetical char
- alphabet range would include all chars needed to check

A
1. init an ALPHABET constant to contain range of all alphabetical chars
2. iterate through alphabet range
  2a. for each letter of the alphabet, check if the input includes the current letter
    - if it does, proceed to the next letter
    - otherwise, immediately return false from method
3. after entire alphabet has been iterated, if every letter included in input, return true

C
=end

ALPHABET = ('a'..'z')

def is_pangram(sentence)
  ALPHABET.all? { |letter| sentence.include?(letter) }
end

p is_pangram('The quick, brown fox jumps over the lazy dog!') == true
p is_pangram('The slow, brown fox jumps over the lazy dog!') == false
p is_pangram("A wizard’s job is to vex chumps quickly in fog.") == true
p is_pangram("A wizard’s task is to vex chumps quickly in fog.") == false
p is_pangram("A wizard’s job is to vex chumps quickly in golf.") == true

my_str = 'Sixty zippers were quickly picked from the woven jute bag.'
p is_pangram(my_str) == true
