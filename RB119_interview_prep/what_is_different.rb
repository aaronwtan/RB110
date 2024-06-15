=begin
P
input: array of nums
output: num in the input that differs from the rest
  - input will always have at least 3 nums
  - input will always have exactly one num that is different

E
[7, 7, 7, 7.7, 7]
uniq nums: 7, 7.7
counts of each uniq num
7: 4
7.7: 1 <- count of 1 so return

D
- need to count how many of each element there is
- need to work with uniq nums
- need to determie which num occurs exactly once

A
1. find uniq nums of input
2. count how many of each uniq num is in the input
3. return the num that has a count of 1

C
=end

def what_is_different(nums)
  uniq_nums = nums.uniq
  uniq_nums.each { |num| return num if nums.count(num) == 1 }
end

p what_is_different([0, 1, 0]) == 1
p what_is_different([7, 7, 7, 7.7, 7]) == 7.7
p what_is_different([1, 1, 1, 1, 1, 1, 1, 11, 1, 1, 1, 1]) == 11
p what_is_different([3, 4, 4, 4]) == 3
p what_is_different([4, 4, 4, 3]) == 3
