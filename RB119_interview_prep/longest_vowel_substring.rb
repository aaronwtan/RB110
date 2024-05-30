=begin
P
input: string of lowercase alphabetic chars
output: integer representing length of longest vowel substring
  - vowels are a, e, i, o, u
  - substrings are contiguous
  - when determining longest vowel substring, does not have to be same vowel

E
- aeiou -> 5
- aeeiiiooouuu -> 12

D
chars of given string, checking for vowels

A
1. init VOWELS constant
2. init longest_vowel_substr_count to 0
3. iterate through chars of given str
  - for each char:
    - if current char is included in VOWELS
      - init current_vowel_substr to current char
      - iterate start index from current index to end of given str
        - for each index:
          - if char at current index is included in VOWELS
            - append char at current index to current_vowel_substr
          - break from current loop
      - if length of current_vowel_substr > longest_vowel_subtr_count
        - reassign longest_vowel_subtr_count to current_vowel_substr
    - otherwise continue to next char
4. return longest_vowel_substr_count

C
=end

VOWELS = 'aeiou'

# def longest_vowel_substring(str)
#   longest_vowel_substr_length = 0
#   str.each_char.with_index do |char, idx|
#     next unless VOWELS.include?(char)

#     current_vowel_substr = char

#     (idx + 1).upto(str.length - 1) do |substr_idx|
#       current_substr_char = str[substr_idx]
#       break unless VOWELS.include?(current_substr_char)

#       current_vowel_substr << current_substr_char
#     end

#     if current_vowel_substr.length > longest_vowel_substr_length
#       longest_vowel_substr_length = current_vowel_substr.length
#     end
#   end

#   longest_vowel_substr_length
# end

def substrings(str)
  result = []

  max_start_index = str.length - 1

  0.upto(max_start_index) do |start_index|
    max_substr_length = str.length - start_index

    1.upto(max_substr_length) do |substr_length|
      result << str[start_index, substr_length]
    end
  end

  result
end

def vowel_substrings(str)
  subs_arr = substrings(str)

  subs_arr.select do |substr|
    substr.chars.all? { |substr_char| VOWELS.include?(substr_char) }
  end
end

def longest_vowel_substring(str)
  vowel_subs_arr = vowel_substrings(str)
  return 0 if vowel_subs_arr.empty?

  vowel_subs_arr.max_by(&:length).length
end

p longest_vowel_substring('cwm') == 0
p longest_vowel_substring('many') == 1
p longest_vowel_substring('launchschoolstudents') == 2
p longest_vowel_substring('eau') == 3
p longest_vowel_substring('beauteous') == 3
p longest_vowel_substring('sequoia') == 4
p longest_vowel_substring('miaoued') == 5
