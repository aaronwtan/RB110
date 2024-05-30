=begin
P
input: array of integers
output: highest possible value by taking modulus of any two input elements
  - modulus is remainder after dividing two integers
  - if all elements are the same, highest value is 0
  - assuming at least 2 elements in input array

E
  [88, 54, 67, 56, 88, 36]
88
54
67
56
88
36

67 % 88 == 67

D
- need to find every possible permutation of 2 elements
- order matters when taking modulus, so need to do nested iteration over input twice
- only need to be concerned about unique values
- if every element is the same, highest modulus is 0 

A
1. find unique values of input
2. return 0 if size of unique values is 1
3. init highest mod to 0 to hold the highest modulus value found
4. iterate over input for first mod value
  4a. iterate over input again for second mod value
  4b. find first value modulo second value
  4c. compare modulus to highest mod and reassign if larger
5. return highest mod

C
=end

def highest_mod(nums)
  uniq_nums = nums.uniq
  return 0 if uniq_nums.size == 1

  highest_mod = 0

  nums.each do |first|
    nums.each do |second|
      current_modulus = first % second
      highest_mod = current_modulus if current_modulus > highest_mod
    end
  end

  highest_mod
end

=begin
Given a collection of integers, write a method to find the highest possible value that can be obtained by taking the modulus of two elements (e.g., 11 % 3 = 2)
=end
p highest_mod([1, 1, 1, 1, 1]) == 0
p highest_mod([1, 2, 3, 4, 5]) == 4
p highest_mod([88, 54, 67, 56, 36]) == 67
p highest_mod([88, 54, 67, 56, 88, 36]) == 67
