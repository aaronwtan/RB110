=begin
P 
input: 2 strings
output: intger representing number of times the 2nd string occurs in the 1st string
  - overlapping strings don't count: 'ababa' contains one 'aba', not two
  - 2nd argument will never be an empty string
  - return 0 if 2nd argument does not occur at all in 1st argument
  - return 0 if 1st argument is empty

E
'ababa' / 'aba'
  1st   /  2nd
split: '' (aba) ba
            1
# split parts: 2
return: (2 - 1) == 1

'abahelloabaworldabaitsabameaba' / 'aba'
              1st                /  2nd
split: '' (aba) 'hello' (aba) 'world' (aba) 'its' (aba) 'me' (aba) ''
            1             2             3           4          5
# split parts: 6
return: (6 - 1) == 5

D
string split with 2nd argument as separator into array

A
1. return 0 if 1st str is empty
2. split 1st str with 2nd str as separator and assign into split_str
3. return (size of split_str) - 1 

C
=end

# def count_substrings(str1, str2)
#   return 0 if str1.empty?

#   split_str = str1.split(str2, -1)

#   split_str.size - 1
# end

def count_substrings(str1, str2)
  return 0 if str1.empty?

  sub_count = 0

  str1_length = str1.length
  str2_length = str2.length

  str1_start_idx = 0

  while str1_start_idx < str1_length
    if str1[str1_start_idx, str2_length] == str2
      sub_count += 1
      str1_start_idx += str2_length
    else
      str1_start_idx += 1
    end
  end

  sub_count
end

p count_substrings('babab', 'bab') == 1
p count_substrings('babab', 'ba') == 2
p count_substrings('babab', 'b') == 3
p count_substrings('babab', 'x') == 0
p count_substrings('babab', 'x') == 0
p count_substrings('', 'x') == 0
p count_substrings('bbbaabbbbaab', 'baab') == 2
p count_substrings('bbbaabbbbaab', 'bbaab') == 2
p count_substrings('bbbaabbbbaabb', 'bbbaabb') == 1
