=begin
Implement a function that calculates the sum of numbers inside of a string.

You can expect that the string will include only positive numbers.

sum_of_numbers("L12aun3ch Sch3oo451") = 469
sum_of_numbers("HE2LL3O W1OR5LD") == 11
sum_of_numbers("The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog") == 3635
=end
=begin
P
input: string
output: integer representing sum of all numbers inside the given string
  - consecutive digits in the string should be interpreted as a single multi-digit number
  - input will contain only positive numbers
E
'aa  1  bbb  23  cccc   456'   -> 1 + 23 + 456 == 480
    num      num        num
idx: 2       6,7      12,13,14
D
array of chars to iterate through checking for integer strings

A
1. init num_sums to 0 to hold sum of all string nums
2. init current_num_str to empty string to keep track of the current number to sum
3. Iterate through chars and check if current char of string is an integer representation
  3a. if it is, append to current_num_str
  3b. otherwise, convert current_num_str and add to num_sums
    - reset current_num_str to empty string
4. Repeat step 3 until end of string
5. Add any remaining current_num_str integer to num_sums
6. Return num_sums

C
=end

def integer?(str)
  str.to_i.to_s == str
end

def sum_of_numbers(str)
  num_sums = 0
  current_num_str = ''

  str.each_char do |current_char|
    if integer?(current_char)
      current_num_str << current_char
    else
      num_sums += current_num_str.to_i
      current_num_str = ''
    end
  end

  num_sums += current_num_str.to_i
  num_sums
end

p sum_of_numbers("L12aun3ch Sch3oo451") == 469
p sum_of_numbers("HE2LL3O W1OR5LD") == 11
p sum_of_numbers("The30quick20brown10f0x1203jumps914ov3r1349the102l4zy dog") == 3635
