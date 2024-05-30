=begin
Given an integer n, find the maximal number you can obtain by deleting exactly one digit of the given number.

delete_digit(791983) == 91983
delete_digit(152) == 52
delete_digit(1001) == 101
delete_digit(10) == 1
=end
=begin
P
input: integer
output: max num possible by deleting exactly one digit of input
  - order of digits after deletion will be the same

E
1234
deleting: 1 -> 234 <- max num
          2 -> 134
          3 -> 124
          4 -> 123

D
- need to work with digits
- num can be converted to str first then array of digits to delete each digit one by one
  then combine to check for max value
- need to delete without changing input

A
1. convert input num to str
2. init a max num to 0 to hold current max num found
3. iterate through indices of digit strings
  3a. for each digit index, convert num str to array of digit strings
  3b. delete digit at current digit index
  3c. convert digit strings array back to num
  3d. compare if current num after deletion is greater than max num and reassign if so
4. return max num

C
=end

def delete_digit(num)
  num_str = num.to_s
  max_num = 0

  (0...num_str.length).each do |digit_index|
    digits = num_str.chars
    digits[digit_index] = ''
    current_num_after_deletion = digits.join.to_i

    max_num = current_num_after_deletion if current_num_after_deletion > max_num
  end

  max_num
end

p delete_digit(791983) == 91983
p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1
