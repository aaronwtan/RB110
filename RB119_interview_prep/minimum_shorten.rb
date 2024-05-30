# Implement the function/method, minimum shorten. The function shortens a sentence such
# that it will fit within the character limit set. It shortens by removing vowels
# in the sequence of a, e, i, o, and u. Start removing from the end of the sentence.
# If it can not be shortened to fit within character limit, return an empty string.
# Spaces don’t count for the limit.

=begin
P
input: str and integer representing char limit to shorten str
output: shortened str or empty str if cannot be shortened within char limit
  - str should be shortened starting from end of str
  - str should be shortened by removing vowels in order aeiou
  - spaces don't count for char limit
  - if already within char limit, str will have value of input str

E
"A very long sentence with many vowels"  char limit: 10
sentence length excluding spaces: 31
vowels needed to remove to meet limit: 21
num vowels: 10
chars after removal: 21 -> return empty str

"Hello World" char limit: 8
sentence length excluding spaces: 10
vowels needed to remove to meet limit: 2
num vowels: 3
                "Hello World"
removal order:    1     2

D
- need to remove just enough vowels until char count is <= char limit
- need to iterate through vowels aeiou and from end of input str
- if num of vowels needed to remove is more than the num of vowels in sentence,
  return empty str immediately

A
1. init VOWELS constant str
2. Count num of chars in input after deleting spaces
  - if num of non-space chars is less than or equal to char limit, return input
3. Count how many vowels in input
4. If total num of chars minus vowels is greater than char limit, return empty str immediately
5. Reverse input str
6. Determine num of vowels to remove by subtracting total num of chars minus char limit
7. Iterate through vowels
  7a. for each vowel, iterate through reversed str
    - if current vowel can be removed:
      - remove first occurrence
      - increment vowels removed by 1
      - if vowels removed is greater than or equal to the total num of vowels needed to be removed,
        return the reversed str reversed to normal again
    - otherwise, proceed to next vowel or end of iteration


C
=end

VOWELS = 'aeiou'

def minimum_shorten(sentence, char_limit)
  total_non_space_chars = sentence.delete(' ').length
  return sentence if total_non_space_chars <= char_limit

  num_vowels = sentence.count(VOWELS)
  total_vowels_to_remove = total_non_space_chars - char_limit
  return '' if total_vowels_to_remove > num_vowels

  reversed_str = sentence.reverse
  vowels_removed = 0

  VOWELS.each_char do |vowel|
    vowels_removed += 1 if reversed_str.sub!(vowel, '')
    return reversed_str.reverse if vowels_removed >= total_vowels_to_remove
  end
end

# Test cases
puts minimum_shorten("This is a test sentence", 18) # This is  test sentence
puts minimum_shorten("Hello World", 8) # Hllo Wrld
puts minimum_shorten("Short", 10) # Short
puts minimum_shorten("A very long sentence with many vowels", 10) # ""
