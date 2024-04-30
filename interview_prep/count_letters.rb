=begin
P
input: string
output: hash in which keys are each unique lowercase letter of the string,
        and values are the frequency of that letter in the string
  - uppercase letter are ignored when counting
  - punctuation is ignored when counting
  - if empty string or no letters occur in the string, return an empty hash

E
'abbccc'  -> letters: ['a', 'b', 'c'] -> a: 1, b: 2, c: 3
'!!!' -> letters: [] (no lettes) -> empty hash

D
array of unique letters to count each letter in string

A
1. init lowercase alphabet constant
2. split given string into chars
3. use alphabet constant to select chars that are lowercase
4. tally how many of each letter occurs in lowercase letters
    and return hash

C
=end
LOWER_ALPHABET = ('a'..'z')

def count_letters(str)
  lower_letters = str.chars.select { |char| LOWER_ALPHABET.include?(char) }
  lower_letters.tally
end

expected = {'w' => 1, 'o' => 2, 'e' => 3, 'b' => 1, 'g' => 1, 'n' => 1}
p count_letters('woebegone') == expected

expected = {'l' => 1, 'o' => 1, 'w' => 1, 'e' => 4, 'r' => 2,
            'c' => 2, 'a' => 2, 's' => 2, 'u' => 1, 'p' => 2}
p count_letters('lowercase/uppercase') == expected

expected = {'u' => 1, 'o' => 1, 'i' => 1, 's' => 1}
p count_letters('W. E. B. Du Bois') == expected

p count_letters('x') == {'x' => 1}
p count_letters('') == {}
p count_letters('!!!') == {}
