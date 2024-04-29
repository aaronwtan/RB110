=begin
P
input: array of nums
output: integer representing the index of the given array where the sum of all elements left
  and right of the index are equal
  - if no such index found, return -1
  - empty arrays have a sum of 0

E
[1, 2, 3] -> index 0 left: [] sum: 0, right: [2, 3] sum: 5
             index 1 left: [1] sum: 1, right: [3] sum: 3
             index 2 left: [1, 2] sum 3, right: [] sum: 0
             overall return: -1

[-1, 1, 5, 0] -> index 0 left: [] sum: 0, right: [1, 5, 0] sum: 6
                 index 1 left: [-1] sum: -1 , right: [5, 0] sum: 5
                 index 2 left: [-1, 1] sum: 0, right: [0] sum: 0
                 index 3 left: [-1, 1, 5] sum: 5, right [] sum: 0
                 overall return: 2
D
array

A
1. iterate through indices of given array
  - for each index of array:
    - init left_elements array for elements left of index: elements from 0 to current index, noninclusive
    - init right_elements array for elements right of index: elements from current index + 1 to last index, inclusive
    - calculate sum for both arrays
      - if either array is empty, assign sum to 0
    - return index if sums are equal
    - otherwise, continue iteration
2. return -1 if iteration completed without equal sum found

C
=end

def find_even_index(nums)
  nums.each_index do |idx|
    left = nums[0...idx]
    right = nums[idx + 1..]

    return idx if left.sum == right.sum
  end

  -1
end

p find_even_index([1, 2, 3, 4, 3, 2, 1]) == 3
p find_even_index([1, 100, 50, -51, 1, 1]) == 1
p find_even_index([1, 2, 3, 4, 5, 6]) == -1
p find_even_index([20, 10, 30, 10, 10, 15, 35]) == 3
p find_even_index([20, 10, -80, 10, 10, 15, 35]) == 0
p find_even_index([10, -80, 10, 10, 15, 35, 20]) == 6
p find_even_index([-1, -2, -3, -4, -3, -2, -1]) == 3
