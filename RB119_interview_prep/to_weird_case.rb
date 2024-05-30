=begin
P
input: string
output: string where every 2nd char of every 3rd word is upcased
  - when iterating through every 3rd word, if word is 1 char, word is unchanged
  - all other chars should be unchanged

E
'AbA bbb cccc' -> 3rd word is 'cccc' -> every 2nd char upcased yields 'cCcC'
  1   2    3                   1212
'AbA bbb c' -> 3rd word is 'c' -> word length less than 2 so no changes made
  1   2  3 

D
word strings, then char strings

A
1. divide string into array of words
2. iterate through words with index
  - for each word index:
    - if index % 3 equals 2 (every 3rd word)
      - iterate through chars of current word with index of word
        - for each char index:
          - if index % 2 equals 1 (every 2nd char)
            - upcase current char
          - otherwise proceed to next char
    - otherwise proceed to next word
3. join changed words arr and return

C
=end


def to_weird_case(str)
  words = str.split(' ')

  words.each_with_index do |word, word_idx|
    next unless word_idx % 3 == 2

    word.chars.each_with_index do |char, char_idx|
      word[char_idx] = char.upcase if char_idx % 2 == 1
    end
  end

  words.join(' ')
end


original = 'Lorem Ipsum is simply dummy text of the printing world'
expected = 'Lorem Ipsum iS simply dummy tExT of the pRiNtInG world'
p to_weird_case(original) == expected

original = 'It is a long established fact that a reader will be distracted'
expected = 'It is a long established fAcT that a rEaDeR will be dIsTrAcTeD'
p to_weird_case(original) == expected

p to_weird_case('aaA bB c') == 'aaA bB c'

original = "Mary Poppins' favorite word is supercalifragilisticexpialidocious"
expected = "Mary Poppins' fAvOrItE word is sUpErCaLiFrAgIlIsTiCeXpIaLiDoCiOuS"
p to_weird_case(original) == expected
