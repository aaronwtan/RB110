=begin
Given a string and an integer i, write a method that splits the string up into a sentence of strings, 
where each string in the sentence contains a character of the argued string and every ith character after it:
=end

=begin
P
input: str and an integer i
output: "sentence" of strings, where each str in the sentence contains a char of the input str and every ith char after
  - spaces are not counted when determining every ith char
  - i must be greater than or equal to 1; if not, return "i cannot be less than 1"
  - the number of words in the sentence will be equal to the num of chars in the input, not including spaces
  - first word of sentence will always start with the first char of input
  - for each word, take every ith char, until end of str, then next word will begin

E
   "m a r y  h a d  a  l i t t l e  l a m b", i = 3
start     3      3       3     3      3   

first word: mydila
...
D
- need to work with str with spaces removed
- need to iterate a starting char going from first char of str until last
- for each word, need to append every ith char starting from starting char
- position of input char will correspond to sentence position of output

A
1. return "i cannot be less than 1" if i < 1
2. init sentence array to empty array to hold result words to be joined later
3. remove spaces from input
4. iterate through indices of spaceless input, with each index corresponding to the position in the sentence output
  4a. set word index to the current sentence index
  4b. init word to an empty string to hold the word at the current sentence index
  4c. loop until current word index exceeds input bounds
    - append the char at the current word index of input to the word string
    - increment the current word index by i
  4d. append word string to sentence array
5. return the sentence array joined with spaces
C
=end

def fragment(str, i)
  return 'i cannot be less than 1' if i < 1

  sentence = []
  str = str.gsub(' ', '')

  0.upto(str.length - 1) do |sentence_index|
    word_index = sentence_index
    word = ''

    while word_index < str.length
      word << str[word_index]
      word_index += i
    end

    # (sentence_index...str.length).step(i) { |word_index| word << str[word_index] }

    sentence[sentence_index] = word
  end

  sentence.join(' ')
end

p fragment("abcde", 1) == "abcde bcde cde de e"
p fragment("a b c d e", 2) == "ace bd ce d e"
p fragment("mary had a little lamb", 3) == "mydila ahatem raltlb ydila hatem altlb dila atem ltlb ila tem tlb la em lb a m b"
p fragment("abcde", 0) == "i cannot be less than 1"
p fragment("abcde", 100) == "a b c d e"
p fragment("", 1) == ""
