=begin
P
input: array of integers
output: integer that appears an odd number of times in the input
  - there will always be exactly one integer that satisfies the condition

E
[7, 99, 7, 51, 99, 7, 51]
uniq nums: 7, 99, 51
7: 3
99: 2
51: 2
7 appears odd num of times -> return 7

D
- need to count how many times each uniq num occurs
- need to determine which of these counts are odd and return the num that appears an odd count

A
1. find uniq nums of input
2. count how many of each uniq num are in input
3. return the num if it has an odd count

C
=end

def odd_fellow(nums)
  uniq_nums = nums.uniq

  uniq_nums.each { |num| return num if nums.count(num).odd? }
end

p odd_fellow([4]) == 4
p odd_fellow([7, 99, 7, 51, 99]) == 51
p odd_fellow([7, 99, 7, 51, 99, 7, 51]) == 7
p odd_fellow([25, 10, -6, 10, 25, 10, -6, 10, -6]) == -6
p odd_fellow([0, 0, 0]) == 0
