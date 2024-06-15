=begin
P
input: array of nums
output: index for which all numbers to left and right of index have the same sum
  - sum of nums left of index 0 is 0; sum of nums right of last element is also 0
  - if multiple indices satisfy conditions, returns the smallest index
  - if no indices satisfy condition, return -1

E
[1, 2, 3, 4, 5]
index:
0 -> [| 2, 3, 4, 5] -> left sum: 0, right: 14
1 -> [1 | 3, 4, 5] -> left: 1, right: 12
2 -> [1, 2 | 4, 5] -> left: 3, right: 9
...

D
- need to iterate through all indices of input
- need to find elements to left and right of index, not including the element at the index
- need to sum left and right elements and compare them
- need to define 0 sums at left and right of array

A
1. iterate from 0 to last index of input
  1a. for each index, find elements to left and right of index
  1b. sum the elements for both the left and right
  1c. compare the left and right sums
    - if equal, return the current index
    - otherwise, proceed to the next index
2. if all indices have been iterated through without finding an index with equal sums, return -1

C
=end

def equal_sum_index(nums)
  max_index = nums.size - 1

  (0..max_index).each do |index|
    left = nums[0...index]
    right = nums[index + 1..]

    return index if left.sum == right.sum
  end

  -1
end

p equal_sum_index([1, 2, 4, 4, 2, 3, 2]) == 3
p equal_sum_index([7, 99, 51, -48, 0, 4]) == 1
p equal_sum_index([17, 20, 5, -60, 10, 25]) == 0

# The following test case could return 0 or 3. Since we're
# supposed to return the smallest correct index, the correct
# return value is 0.
p equal_sum_index([0, 20, 10, -60, 5, 25]) == 0
