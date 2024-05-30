=begin
P
input: array of integers
output: integer representing the highest possible value obtained by taking the modulus of any two integers of input
  - two elements can be any two from input
  - modulus is remainder after dividing first by second integer

E
[1, 2, 3, 4, 5]
largest integer: 5
second largest: 4
4 % 5 = 4

D
- largest modulus will be 2nd largest element modulo largest

A
1. find unique values of input array
2. if uniq values has size 1 then return 0
3. find the max of uniq value array
4. remove the max from uniq values
5. find the max of remaining uniq values to find 2nd largest
6. return 2nd largest which will be largest modulus

C
=end

# def highest_mod(nums)
#   uniq_nums = nums.uniq
#   return 0 if uniq_nums.size == 1

#   uniq_nums.delete(uniq_nums.max)
#   uniq_nums.max
# end

def highest_mod(nums)
  uniq_nums = nums.uniq
  return 0 if uniq_nums.size == 1

  uniq_nums.sort[-2]
end

=begin
Given a collection of integers, write a method to find the highest possible value that can be obtained by taking the modulus of two elements (e.g., 11 % 3 = 2)
=end
p highest_mod([1, 1, 1, 1, 1]) == 0
p highest_mod([1, 2, 3, 4, 5]) == 4
p highest_mod([88, 54, 67, 56, 36]) == 67
p highest_mod([88, 54, 67, 56, 88, 36]) == 67

=begin
PROOF
x % a < a
a, b
a % b
b % a

2 % 4

1, 3, 4, 8

8 % 3 => 2
4 % 8 => 4

=end
