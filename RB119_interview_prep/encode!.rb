=begin
P
input: str and an array of str commands
output: input str mutated based on commands
  - the first part of the command represents the index of the input to mutate
  - the second part of the command is the char to mutate to
  - if first part of command exceeds the length of the input, the command is ignored
  - input assumed to be all lowercase

E
"incorrect long strung"
commands: ["0a", "1 ", "18i"]
at index 0, change to 'a'
         1, change to ' '
        18, change to 'i'

"parrot"
commands: ["0m", "3m", "8m"]
at index 0, change to 'm'
         3, change to 'm'
         8, exceeds input bounds, so command ignored
D
- mutating original str
- need to convert all of each command except the last value to an integer
- need to check if integer part of command is within bounds of input

A
1. iterate through commands
  1a. for each command, take all of command except last char and convert to integer to be
    index at which to mutate input
  1b. take last char of command as char to mutate to
  1c. if the index to mutate exists in the input, mutate the char of input at the index to mutate
    to the char to mutate to
2. since objective is mutation, the return is not needed
C
=end

=begin
We want to mutate a string according to a code. In this code, given the command `"9a"`, we should change the character at index 9 of the string to `"a"`.
Write a method that takes a string and a list of these commands, and mutates the string accordingly.
=end

def encode!(str, commands)
  commands.each do |command|
    index_to_mutate = command[0...-1].to_i
    char_to_mutate_to = command[-1]

    str[index_to_mutate] = char_to_mutate_to if index_to_mutate < str.length
  end
end

test_1 = "dog"
encode!(test_1, ["0f"])
p test_1 == "fog"

test_2 = "parrot"
encode!(test_2, ["0m", "3m", "8m"])
p test_2 == "marmot"

test_3 = "weimaraner"
encode!(test_3, ["0p", "2t", "3p", "6t"])
p test_3 == "petpartner"

test_4 = "incorrect long strung"
encode!(test_4, ["0a", "1 ", "18i"])
test_4 == "a correct long string"
