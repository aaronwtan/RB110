# Implement a function, capitalize, that capitalizes all words in a sentences. However, only capitalize if the word is followed
# by a word starting with a vowel (for Ruby don’t use capitalize).

=begin
P
input: string of words
output: new string with input transformed
  - words followed by a word starting with a vowel will be capitalized
  - last word will never be capitalized
  - words are separated by spaces
  - input assumed to be all lowercase letters

E
aaa bbb ccc ddd eee fff
aaa bbb ccc Ddd eee fff

D
- need to iterate from first to second to last word
- need to check the next word for each word iteration
- need to capitalize the current word if the next word starts with a vowel

A
0. init result array to empty array to hold transformed str
1. split input into words
2. iterate from the first word to the second to last word
  2a. for each word, check if next word starts with a vowel
    - if it does, capitalize the current word by reassigning the first char to upcased version
  2b. append current word to result
3. append the last word to result array
4. join result array with spaces and return

C
=end

def capitalize(sentence)
  result = []
  words = sentence.split

  words[0...-1].each_with_index do |current_word, index|
    next_word = words[index + 1]
    current_word[0] = current_word[0].upcase if next_word.start_with?('a', 'e', 'i', 'o', 'u')

    result << current_word
  end

  result << words.last

  result.join(' ')
end

# Test cases
p capitalize("hello apple world") ==  "Hello apple world"
p capitalize("this is an umbrella") == "This Is An umbrella"
p capitalize("every vowel starts an echo") == "every vowel Starts An echo"
p capitalize("under the oak tree") == "under The oak tree"
p capitalize("a quick brown fox") == "a quick brown fox"
