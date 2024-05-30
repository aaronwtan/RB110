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
4. iterate through chars of space-less input with index
  4a. init value of sentence at current sentence index to the current char
  4b. init current word index to current sentence index + i
  4c. loop through space-less input chars until current word index exceeds input bounds
    - append the char at the current word index to the value at the current sentence index of the sentence array
    - increment the current word index by i
5. return the sentence array joined with spaces
C
=end

def fragment(str, i)
  return "i cannot be less than 1" if i < 1

  sentence = []
  str = str.gsub(' ', '')

  str.chars.each_with_index do |char, sentence_index|
    word_index = sentence_index

    while word_index < str.length
      if sentence[sentence_index].nil?
        sentence[sentence_index] = char
      else
        sentence[sentence_index] << str[word_index]
      end

      word_index += i
    end
  end

  sentence.join(' ')
end

p fragment("abcde", 1) == "abcde bcde cde de e"
p fragment("a b c d e", 2) == "ace bd ce d e"
p fragment("mary had a little lamb", 3) == "mydila ahatem raltlb ydila hatem altlb dila atem ltlb ila tem tlb la em lb a m b"
p fragment("abcde", 0) == "i cannot be less than 1"
p fragment("abcde", 100) == "a b c d e"
p fragment("", 1) == ""
