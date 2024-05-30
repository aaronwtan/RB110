# Write a function, snakecase, that transforms each word in a sentence to alternate between lower
# (even index value) and upper (odd index value) cases when the word before or after it begins with "s".

=begin
P
input: str of words
output: transformed str where words that are next to words beginning with "s" are written in snakecase
  - snakecase means even index values are lowercase; odd index are upper
  - if a word is not next to another that begins with "s", leave it unchanged

E
'aaa bbb sss' -> 'aaa bBb sss'
'sss bbb ccc' -> 'sss bBb ccc'
'aaa sss ccc' -> 'aAa sss cCc'

D
- need to work with array of words
- for each word, need to check the words before and after it if they begin with char 's'
- for first word, only need to check word after
- for last word, only need to check word before
- for word between, check before or after

A
1. iterate through words of sentence
  1a. for first word, check if 2nd word begins with 's'
  1b. for middle words, check if words before or after begin w 's'
  1c. for last word, check if 2nd to last word begins with 's'
    - for each case, if true then call snakecase method to transform str to snakecase
    - otherwise, don't change word and continue to next word

2. return transformed str

C

#snakecase
P
input: str
output: str with even idx lowercase, odd idx uppercase

E
hello -> hElLo

D
chars

A
1. iterate through chars and transform each char
  1a. if even idx, make lowercase
  1b. if odd idx, make uppercase
2. return transformed str
=end

def make_snakecase(str)
  str.chars.map.with_index do |char, index|
    index.even? ? char.downcase : char.upcase
  end.join
end

def snakecase(sentence)
  words = sentence.split(' ')
  first_word_index = 0
  final_word_index = words.size - 1
  middle_word_indices = (1...final_word_index)

  words.map.with_index do |word, index|
    case index
    when first_word_index
      next_starts_with_s = words[1].start_with?('s', 'S')
      next_starts_with_s ? make_snakecase(word) : word
    when middle_word_indices
      before_or_after_starts_with_s = words[index - 1].start_with?('s', 'S') ||
                                      words[index + 1].start_with?('s', 'S')
      before_or_after_starts_with_s ? make_snakecase(word) : word
    when final_word_index
      previous_starts_with_s = words[-2].start_with?('s', 'S')
      previous_starts_with_s ? make_snakecase(word) : word
    end
  end.join(' ')
end

# Test cases
puts snakecase("Snakes slither silently") # "sNaKeS sLiThEr sIlEnTlY"
puts snakecase("simple sentence structure") # "sImPlE sEnTeNcE sTrUcTuRe"
puts snakecase("apples are sweet") # "apples aRe sweet"
puts snakecase("swiftly swimming swans") # "sWiFtLy sWiMmInG sWaNs"
puts snakecase("the sun sets slowly") # "tHe sUn sEtS sLoWlY"
puts snakecase("A quick brown fox") # "A quick brown fox"
