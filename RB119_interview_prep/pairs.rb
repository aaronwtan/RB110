=begin
P
input: array of integers
output: number of identical pairs of integers in the array
  - if array is empty or size 1, return 0
  - if number occurs more than twice, return each complete pair once

E
[1, 1, 1, 1, 2, 2, 2, 2, 2]
  -> 1 occurs 4 times; 2 occurs 5 times
  -> 1: 4 / 2 == 2; 2: 5 / 2 == 2
  -> 1: 2 pairs; 2: 2 pairs
  -> final return: 2 + 2 == 4 

D
array of each unique integer to count how many occurences

A
1. return 0 if given array size <= 1
2. assign uniq_nums to unique numbers of given array
3. init num_pairs to 0
4. iterate through uniq_nums
  - for each num:
    - count times current num occurs in array and assign to current_num_count
    - init current_num_pairs to current_num_count / 2
    - increment num_pairs by current_num_pairs
5. return num_pairs

C
=end

def pairs(nums)
  return 0 if nums.size <= 1

  uniq_nums = nums.uniq
  num_pairs = 0

  uniq_nums.each do |num|
    current_num_count = nums.count(num)
    current_num_pairs = current_num_count / 2
    num_pairs += current_num_pairs
  end

  num_pairs
end

p pairs([3, 1, 4, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7]) == 3
p pairs([2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4]) == 4
p pairs([]) == 0
p pairs([23]) == 0
p pairs([997, 997]) == 1
p pairs([32, 32, 32]) == 1
p pairs([7, 7, 7, 7, 7, 7, 7]) == 3
