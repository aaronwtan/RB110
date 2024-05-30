# # Write a function, snakecase, that transforms each word in a sentence to alternate between lower (even index value) and upper (odd index value) cases when the word before or after it  begins with "s". -- Edward

=begin
  Problem
    Input: string with words
    Output: string with alternating capitalization for words that are adjacent to a word that starts with the letter s

    Explicit rules/requirements: 
      - do snakecase on words that are adjacent to words that start with the letter s
      - snakecase is where the even-indexed letters are lowercase, and odd-indexed letters are uppercase
    Implicit rules/requirements: 
        - no punctuation
        - only alphabetical characters 

  Examples: 
  
  Data strucuture: 
     input is a string -> split the input string into an array of substrings -> process the substrings 
     -> join the array of substrings to return a string
    
  Algorithm: 
      - go over each word from the input string
        - check to see if the word(s) adjacent to the current word start with an "s"
        - if yes, then apply snakecase_word
        -otherwise, move on to the next word
        - use map for this
      - return the transformed words by using join

      -snakecase method Algorithm
          - go over each character
            - downcase the entire string
            - for odd characters, make the case upcase
          - join the word and return it
=end

# def snakecase_word(word)
#   new_word = word.chars.map.with_index do |char, index|
#     if index.odd?
#       char.upcase
#     else
#       char.downcase
#     end
#   end
#   new_word.join
# end

# def snakecase(sentence)
#   words = sentence.split
#   words = words.map.with_index do |word, index|
#     if words[index - 1] != nil && (words[index - 1][0] == "s" || words[index - 1][0] == "S") && index != 0
#             snakecase_word(word)
#     elsif words[index + 1] != nil && (words[index + 1][0] == "s" || words[index + 1][0] == "S") 
#       snakecase_word(word)
#     else
#       word
#     end
#   end
#   words.join(" ")
# end

# # # Test cases
# puts snakecase("Snakes slither silently") # "sNaKeS sLiThEr sIlEnTlY"
# puts snakecase("simple sentence structure") # "sImPlE sEnTeNcE sTrUcTuRe"
# puts snakecase("apples are sweet") # "apples aRe sweet"
# puts snakecase("swiftly swimming swans") # "sWiFtLy sWiMmInG sWaNs"
# puts snakecase("the sun sets slowly") # "tHe sUn sEtS sLoWlY"
# puts snakecase("A quick brown fox") # "A quick brown fox"

# Write a function that returns the maximum possible consecutive alternating odd and even (or even and odd) numbers. Minimum possible length is 2. If there’s none return []. -- Zach

=begin

PROBLEM

  return an array that contains the largest number of consecutive alternating odd/even digits

  input: array
  output: array
  rules:
    - Minimum returned array size is 2
    - Return empty array if there are no consecutive alternating ([])

  Example:

    # => [1, 1, 3, 7, 8, 5]
      # => 1
        # => current num is odd
      # => 1
        # current num is odd, last num was odd
      # => 3
        # current num is odd, last num was odd
      # => 7
        # current num is odd, last num was odd
      # => 8
        # current num is even, last num was odd
          # append current num and last num to array
      # => 5
        # current num is odd, last num was even
          # append current num to array and last num to array
    # => [3,7,7,8,8,5]
    # unique values? [3,7,8,5]

# DSA

  Create an empty array collection ALTERNATING
  loop over given array up to 2nd to last element [-2]
    compare current element and next element 
      if they are alternating odd/even or even/odd
        append both nums to ALTERNATING
  return unique values of ALTERNATING

=end

# CODE
# def longest_alternating_subarray(arr)
#   alternating = []

#   arr[0..-2].each_with_index do |_, idx|
#     if arr[idx].odd? && arr[idx+1].even?
#       alternating << arr[idx]
#       alternating << arr[idx+1]
#     elsif arr[idx].even? && arr[idx+1].odd?
#       alternating << arr[idx]
#       alternating << arr[idx+1]
#     end
#   end

#   alternating.uniq
# end

# def longest_alternating_subarray(arr)
#   longest_subarray = []
#   current_subarray = [arr[0]]

#   (1...arr.length).each do |i|
#     if arr[i].odd? != arr[i - 1].odd?
#       current_subarray << arr[i]
#       longest_subarray = current_subarray.clone if current_subarray.length > longest_subarray.length
#     else
#       current_subarray = [arr[i]]
#     end
#   end

#   longest_subarray.length >= 2 ? longest_subarray : []
# end



# # Test cases
# puts longest_alternating_subarray([1, 2, 3, 4, 5, 6]).inspect # Expected: [1, 2, 3, 4, 5, 6]
# puts longest_alternating_subarray([2, 4, 6, 8]).inspect # Expected: []
# puts longest_alternating_subarray([1, 3, 5, 7]).inspect # Expected: []
# puts longest_alternating_subarray([1, 1, 3, 7, 8, 5]).inspect # Expected: [7, 8, 5]
# puts longest_alternating_subarray([4, 6, 7, 12, 11, 9, 17]).inspect # Expected: [6, 7, 12, 11]

# # Given an array of numbers, return the count of all combination of 3 numbers where the values are in decreasing order.  -- Aaron

=begin
P
input: array of numbers
output: integer that represent count of every combination of 3 nums are in decreasing order
  - order that nums are in array matters
  - if no combinations of 3 descending nums return 0

E
[5, 4, 3, 2, 1]
break into subarray combos of size 3
  [5, 4, 3], [5, 4, 2], [5, 4, 1], [5, 3, 2], [5, 3, 1], [5, 2, 1],
  [4, 3, 2], [4, 3, 1], [4, 2, 1],
  [3, 2, 1]

D
- need to generate subarrays of size 3
- need to increment first index, then check if subsequent elements are less than this element
for [2, 5, 3, 1]
  starting at index 2:
    - 5 > 2 not valid for next element
    - 3 > 2 not valid for next element
    - 1 < 2 valid
      - reached end of str
  starting at 5:
    - 3 < 5 valid for next element
    - 1 < 5 valid for next element
      - size 3 subarr found



A
0. init decreasing_trip_count to count num of decreasing triplets
1. increment from start index 0 up to 3rd to last index of input array
2. for each start index:
  2a. init current subarr to hold current subarr, starting with element at start index
  2b. check if element at next index is less than 1st element
    - if so, check if last element is less than 2nd element
      - if so, increment decreasing_trip_count by 1
      - otherwise, continue to next start index
    - otherwise, continue to next start index
3. return count of decreasing triplets

C
=end

# # Given an array of numbers, return the count of all combination of 3 numbers where the values are in decreasing order.  -- Aaron

# def count_decreasing_triplets(nums)
#   decreasing_trip_count = 0
#   max_start_index = nums.length - 3

#   (0..max_start_index).each do |start_index|
#     first_subelement = nums[start_index]

#     initial_second_index = start_index + 1
#     max_second_index = nums.length - 2
#     second_subelement = nums[start_index + 1]

#     next unless second_subelement < first_subelement

#     (initial_second_index..max_second_index).each do |second_index|
#       second_subelement = nums[second_index]

#       initial_third_index = second_index + 1
#       max_third_index = nums.length - 1

#       (initial_third_index..max_third_index).each do |third_index|
#         third_subelement = nums[third_index]
#         decreasing_trip_count += 1 if third_subelement < second_subelement
#       end
#     end
#   end

#   decreasing_trip_count
# end

# def count_decreasing_triplets(arr)
#   count = 0

#   (0...arr.length - 2).each do |i|
#     (i + 1...arr.length - 1).each do |j|
#       (j + 1...arr.length).each do |k|
#         count += 1 if arr[i] > arr[j] && arr[j] > arr[k]
#       end
#     end
#   end

#   count
# end

# # # Test cases
# puts count_decreasing_triplets([5, 4, 3, 2, 1]) # Expected output: 10
# puts count_decreasing_triplets([-1, -2, -3, 4]) # Expected output: 1
# puts count_decreasing_triplets([1, 2, 3, 4, 5]) # Expected output: 0 (No combinations)

# # Implement the function/method, minimum shorten. The function shortens a sentence such that it will fit within the character limit set. It shortens by removing vowels in the sequence of a, e, i, o, and u. Start removing from the end of the sentence. If it can not be shortened to fit within character limit, return an empty string. Spaces don’t count for the limit.  -- Jack

# # Test cases
# puts minimum_shorten("This is a test sentence", 18) # This is  test sentence
# puts minimum_shorten("Hello World", 8) # Hllo Wrld
# puts minimum_shorten("Short", 10) # Short
# puts minimum_shorten("A very long sentence with many vowels", 10) # ""


# # Implement a function, capitalize, that capitalizes all words in a sentences. However, only capitalize if the word is followed by a word starting with a vowel (for Ruby don’t use capitalize). -- Tiia

# # Test cases
# puts capitalize("hello apple world") # "Hello apple world"
# puts capitalize("this is an umbrella") # "This Is An umbrella"
# puts capitalize("every vowel starts an echo") # "every vowel Starts An echo"
# puts capitalize("under the oak tree") # "under The oak tree"
# puts capitalize("a quick brown fox") # "a quick brown fox"

# =begin

# # Implement a function, capitalize, that capitalizes all words in a sentences. However, only capitalize if the word is followed 
# by a word starting with a vowel (for Ruby don’t use capitalize). -- Tiia

# Input: a string of words 
# Output: a new string 

# Rules:
# - input string seems to be all lowercase letters and whitespaces only
# - cannot use capitalize, must form a new word 
# - must capitalize word if it is followed by a word starting with a vowel
#   - last word is never capitalized as there is no next word
# - vowels: a e i o u

# Data Structures:
# string --> array of words --> string

# Algorithm:
# -split the input string into an array of words
# -map over the words using with_index
#     - if the current idx is the last one, return word as is
#     - check whether the first letter of the next word is included in a vowels array
#       - if so, return a new string where word[0].upcase + word[1..-1]
#       - if not, return word as is
# -join the mapped words together into a new string

# =end

# VOWELS = %w(a e i o u)

# def capitalize(string)
#   words = string.split

#   capitalized_words = words.map.with_index do |word, idx|
#     if idx == (words.size - 1)
#       word
#     elsif VOWELS.include?words[idx+1][0] 
#       word[0].upcase + word[1..-1]
#     else
#       word
#     end
#   end

#   capitalized_words.join(' ')
# end


# # # Test cases
# p capitalize("hello apple world") ==  "Hello apple world"
# p capitalize("this is an umbrella") == "This Is An umbrella"
# p capitalize("every vowel starts an echo") == "every vowel Starts An echo"
# p capitalize("under the oak tree") == "under The oak tree"
# p capitalize("a quick brown fox") == "a quick brown fox"

=begin 
Input : String (sentence) ; Integer (the char limit)
Output: String (input sentence BUT with its' vowels removed starting from a, e, i, o and u until it fits within the char limit)

Rules:
  - MUST shorten the input by removing vowels IN ORDER of a, e, i, o, u
  - IF it cannot be shortened to fit within the char limit THEN RETURN an empty String
  - Spaces DO NOT count towards the limit - ONLY non-space chars do
  - REMOVE vowels in sequence starting from the end of the sentence to the start of the sentence
  - IF sentence is already within the char limit RETURN the sentence
  - Assuming it is case insensitive

DS
  String --> Array (of non-space chars)
  --> Array (of vowels removed accordingly) --> String (of Array joined) 

  => Integer (representing the size of the first Array of chars)
  => Array to represent removed chars

ALGO
  1. CONVERT input to Array fo chars reversed
  ** Make a copy
  2. GET the non-space chars size
  3. GET number of chars to be removed
  4. INIT vowel counter
  5. INIT char counter
  6. INIT chars removed counter
  7. GO OVER each vowel from a, e, i, o and u (with counter)
    a) GO OVER each char with index of copy Array of chars with counter
    b) IF Array contains none of the current vowel, increment to the next vowel
    c) IF current char == current vowel THEN REMOVE char at current index
    d) IF chars removed == chars to be removed BREAK
  8. RETURN Array copy re-reversed and Joined
=end

VOWELS = ['a', 'e', 'i', 'o', 'u']

def minimum_shorten(str, limit)
  chars = str.chars.reverse 
  original_size = str.scan(/[a-z]/i).size
  chars_copy = chars.dup
  
  return str if original_size <= limit

  chars_to_be_removed = original_size - limit 
  chars_removed = 0

  vowel_counter = 0
  char_counter  = 0

  loop do
    vowel = VOWELS[vowel_counter]
    char = chars_copy[char_counter]

    break if vowel == nil

    if chars_copy.none? { |char| char.downcase == vowel }
      vowel_counter += 1
      char_counter = 0
      next
    end

    if char.downcase == vowel
      chars_copy.delete_at(char_counter)
      chars_removed += 1
    else
      char_counter += 1
    end

    if char_counter == chars_copy.size
    break if chars_removed == chars_to_be_removed
  end

  p chars_copy.reverse.join
end

def minimum_shorten(sentence, limit)
  non_space_count = sentence.gsub(/\s/, '').length
  return sentence if non_space_count <= limit

  vowels = ['a', 'e', 'i', 'o', 'u']
  shortened = sentence.clone

  vowels.each do |vowel|
    while non_space_count > limit && shortened.include?(vowel)
      index = shortened.rindex(vowel)
      shortened = shortened[0...index] + shortened[index+1..-1]
      non_space_count -= 1
    end
  end

  non_space_count <= limit ? shortened : ''
end

def snakecase(sentence)
  words = sentence.split
  words.each_with_index do |word, i|
      if (i > 0 && words[i - 1].downcase.start_with?('s')) ||
         (i < words.length - 1 && words[i + 1].downcase.start_with?('s'))
          words[i] = word.chars.map.with_index { |char, index| 
              index.even? ? char.downcase : char.upcase 
          }.join
      end
  end
  words.join(' ')
end
