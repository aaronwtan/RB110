=begin
Given an integer n, find the maximal number you can obtain by deleting exactly one digit of the given number.
=end

=begin
P
input: integer
output: max num possible by deleting exactly one digit of input
  - order of digits will remain the same after deletion

E
12345
deleting at index 0: 2345 <- max
                  1: 1345
                  2: 1245
                  3: 1235
                  4: 1234

D
- need to work with digits of num
- need to loop over indices of digits, deleting each one by one
- need to work with a new copy of digits on each iteration
- string form of digits can be used for iteration

A
1. init max num to 0 to hold max num found
2. convert input to str
3. iterate digit indices from 0 to num of digits - 1
  3a. for each digit index, convert num str to digits
  3b. delete digit at current digit index
  3c. join digit and convert back to integer
  3d. reassign transformed num if greater than max num
4. return max num

C
=end
=begin
def delete_digit(num)
  max_num = 0
  num_str = num.to_s
  max_digit_index = num_str.length - 1

  (0..max_digit_index).each do |digit_index|
    digits = num_str.chars
    digits.delete_at(digit_index)
    new_num = digits.join.to_i

    max_num = new_num if new_num > max_num
  end

  max_num
end
=end

def delete_digit(num)
  num_str = num.to_s
  max_digit_index = num_str.length - 1

  transformed_nums = (0..max_digit_index).map do |digit_index|
    digits = num_str.chars
    digits.delete_at(digit_index)
    digits.join.to_i
  end

  transformed_nums.max
end

p delete_digit(791983) == 91983
p delete_digit(152) == 52
p delete_digit(1001) == 101
p delete_digit(10) == 1
