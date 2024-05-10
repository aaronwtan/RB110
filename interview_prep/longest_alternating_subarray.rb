# return an array that contains the largest number of consecutive alternating odd/even digits
=begin
P
input: array
output: array containing longest subarray of alternating odd/even digits
  - odd/even nums do not have to be in increasing order
  - output is contiguous subarray
  - if none exist, return empty array
  - return should be at least size 2

E
[1,       1,      3,      7,      8,      5]
odd      odd     odd     odd     even    odd
                                append   append

D
- need to check whether previous array element was odd/even based on current element odd/even
- only reassign longest subarr value if size >= 2

A
1. init longest_alt_subarr to empty array to hold result
2. init current_subarr to first element of input arr
3. iterate from index 1 to last index of input arr
    3a. for each element at the current index, check if previous and current num are both odd or both even
      - if not, append to current_subarr
        - reassign current_subarr to longest_alt_subarr if longer and size >= 2
      - otherwise, reset current_subarr to only hold current element
4. return longest subarr

C
=end

def longest_alternating_subarray(nums)
  longest_alt_subarr = []
  current_subarr = [nums.first]

  (1...nums.size).each do |index|
    current_num = nums[index]
    previous_num = nums[index - 1]

    if previous_num.odd? != current_num.odd?
      current_subarr << current_num
      longest_alt_subarr = current_subarr if current_subarr.size > longest_alt_subarr.size
    else
      current_subarr = [current_num]
    end
  end

  longest_alt_subarr
end

# Test cases
puts longest_alternating_subarray([1, 2, 3, 4, 5, 6]).inspect # Expected: [1, 2, 3, 4, 5, 6]
puts longest_alternating_subarray([2, 4, 6, 8]).inspect # Expected: []
puts longest_alternating_subarray([1, 3, 5, 7]).inspect # Expected: []
puts longest_alternating_subarray([1, 1, 3, 7, 8, 5]).inspect # Expected: [7, 8, 5]
puts longest_alternating_subarray([4, 6, 7, 12, 11, 9, 17]).inspect # Expected: [6, 7, 12, 11]
