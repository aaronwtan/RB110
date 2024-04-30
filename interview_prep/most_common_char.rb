=begin
P
input: string
output: char that appears most often in given string
  - if multiple chars share the same greatest frequency, return char that
    appears first in the string
  - counting is case-insensitive
  - return should be lowercase

E
'aAAabbbcc' - a: 4, b: 3, c: 2 -> return 'a'
'aAAabbbBcccc' - a: 4, b: 4, c: 4 -> return 'a' ('a' appears first)

D
array of uniq chars of given string to count how many of each char is in string

A
1. assign uniq_chars to array of every unique downcased char of given string
2. init max_freq to 0 and max_freq_char to empty string
3. iterate through uniq_chars
  - for each char, count how many of current char is in lowercase version of given string
    - if count > max_freq
      - reassign max_freq to count
      - reassign max_freq_char to current char
    - otherwise continue iteration
4. return max_freq_char

C
=end

def most_common_char(str)
  lowercase_str = str.downcase
  uniq_chars = lowercase_str.chars.uniq

  max_freq = 0
  max_freq_char = ''

  uniq_chars.each do |char|
    current_char_count = lowercase_str.count(char)

    next unless current_char_count > max_freq

    max_freq = current_char_count
    max_freq_char = char
  end

  max_freq_char
end

p most_common_char('Hello World') == 'l'
p most_common_char('Mississippi') == 'i'
p most_common_char('Happy birthday!') == 'h'
p most_common_char('aaaaaAAAA') == 'a'

my_str = 'Peter Piper picked a peck of pickled peppers.'
p most_common_char(my_str) == 'p'

my_str = 'Peter Piper repicked a peck of repickled peppers. He did!'
p most_common_char(my_str) == 'e'
